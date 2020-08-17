//
//  ServiceProvider.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/13/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
    case empty
}

class ServiceProvider<T: Service> {
    
    private var urlSession = URLSession.shared
    
    var cache: URLCache = {
        let allowedDiskSize = 100 * 1024 * 1024
        return URLCache(memoryCapacity: 0, diskCapacity: allowedDiskSize, diskPath: "reqCache")
    }()
    
    private var decoder: JSONDecoder {
        let _decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        _decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return _decoder
    }
    
    init() { }
    
    func load(service: T, completion: @escaping (Result<Data>) -> Void) {
        call(service.urlRequest, completion: completion)
    }
    
    func load<U>(service: T, decodeType: U.Type, completion: @escaping (Result<U>) -> Void) where U: Decodable {
        call(service.urlRequest) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let resp = try self?.decoder.decode(decodeType, from: data)
                    completion(.success(resp!))
                }
                catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            case .empty:
                completion(.empty)
            }
        }
    }
}

extension ServiceProvider {
    private func call(_ request: URLRequest, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping (Result<Data>) -> Void) {
        print(request)

        if let cachedResponse = cache.cachedResponse(for: request) {
            completion(.success(cachedResponse.data))
        }
        
        urlSession.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                deliverQueue.async {
                    completion(.failure(error))
                }
            } else if let data = data, let response = response, let httpResponse = response as? HTTPURLResponse {
                                switch httpResponse.statusCode {
                case 200..<300:
                    deliverQueue.async {
                        // save
                        let cacheResponse = CachedURLResponse(response: response, data: data)
                        self?.cache.storeCachedResponse(cacheResponse, for: request)
                        completion(.success(data))
                    }
                    
                case 429:
                    deliverQueue.async {
                        completion(.failure(ApiError.toManyRequests))
                    }
                    
                case 404:
                    deliverQueue.async {
                        completion(.empty)
                    }
                    
                default:
                    do {
                        let resp = try self?.decoder.decode(ErrorResponse.self, from: data)
                        completion(.failure(ApiError.invalidInput(resp?.ValidationErrors.first?.Message ?? "")))
                    }
                    catch {
                        completion(.failure(error))
                    }
                }
            } else {
                deliverQueue.async {
                    completion(.empty)
                }
            }
        }.resume()
    }
}
