//
//  TagsView.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/14/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import UIKit

class TagsView: UIView {
    
    private var viewModel: TagsViewModel
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.register(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: "TagCell")
        cv.contentInset = UIEdgeInsets(top: 0, left: 10, bottom:0, right: 10)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .lightGray
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    private var _onSelect: (Location) -> Void
    
    init(frame: CGRect = CGRect(x: 0, y: 0, width: 10, height: 54), viewModel: TagsViewModel = TagsViewModel()) {
        self.viewModel = viewModel
        self._onSelect = { _ in }
        super.init(frame: frame)
        
        viewModel.onDataChange { [weak self] in
            self?.collectionView.reloadData()
        }
        addSubview(collectionView)
        addConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

extension TagsView {
    
    private func addConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        
        let rightConstraint = NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        
        let topConstraint =  NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        
        let bottomConstraint =  NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        self.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
}

// MARK: - CollectionView Delegate & DataSource
 
extension TagsView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _onSelect(viewModel.dataAtIndex(index: indexPath))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        cell.configure(viewModel.dataAtIndex(index: indexPath))
        return cell
    }
}

// MARK: - Public

extension TagsView {
    
    func update(_ text: String) {
        viewModel.update(text)
    }
    
    func onSelect(completion: @escaping (Location) -> Void) {
        _onSelect = completion
    }
}
