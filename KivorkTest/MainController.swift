//
//  ViewController.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/13/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var fromTextfield: UITextField!
    
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var toTextfield: UITextField!
    
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var departureTextfield: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var tableview: UITableView!
    
    private lazy var timer: Timer = Timer()
    private lazy var viewModel: MainViewModel = MainViewModel()
    
    private lazy var originTagView = TagsView()
    private lazy var destinationTagView = TagsView()
    
    private var originId: String = ""
    private var destinationId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = UIBarButtonItem(title: "profile".localized, style: .plain, target: self, action: #selector(presentProfile(sender:)))
        navigationItem.setRightBarButton(item, animated: false)
        
        viewModel
            .onEmpty ({ [weak self] in
                self?.presentAlertWithTitle(title: "no_data_title".localized, message: "no_data_message".localized, completion: { _ in
                    self?.searchButton.loadingIndicator(false)
                })
            })
            .onError ({ [weak self] (error) in
                self?.presentAlertWithTitle(title: "Oops!", message: error.localizedDescription, completion: { _ in
                    self?.searchButton.loadingIndicator(false)
                })
            })
        
        
        configureFrom()
        
        configureTo()
        
        configurateDeparture()
        
        configureTableView()
        
        searchButton.setTitle("search".localized, for: .normal)
    }
    
    @IBAction func searchButtonTap(_ sender: Any) {
        searchButton.loadingIndicator(true)
        self.view.endEditing(true)
        viewModel.searchQuotes(from: originId, to: destinationId, departureDate: departureTextfield.text)
    }
}

//  MARK: - Private func

extension MainController {
    
    private func configureFrom() {
        fromLabel.text = "from".localized
        originTagView
            .onSelect { [weak self] (location) in
                self?.fromTextfield.text = location.PlaceName + ", " + location.CountryName
                self?.originId = location.CountryId
                self?.toTextfield.becomeFirstResponder()
        }
        
        fromTextfield.text = "chisi"
        fromTextfield.clearButtonMode = .always
        fromTextfield.inputAccessoryView = originTagView
        fromTextfield.addTarget(self, action: #selector(self.textFieldDidChange(sender:)), for: .editingChanged)
    }
    
    private func configureTo() {
        toLabel.text = "to".localized
        destinationTagView.onSelect { [weak self] (location) in
            self?.toTextfield.text = location.PlaceName + ", " + location.CountryName
            self?.destinationId = location.CountryId
            self?.departureTextfield.becomeFirstResponder()
        }
        
        toTextfield.text = "franta"
        toTextfield.clearButtonMode = .always
        toTextfield.inputAccessoryView = destinationTagView
        toTextfield.addTarget(self, action: #selector(self.textFieldDidChange(sender:)), for: .editingChanged)
    }
    
    private func configurateDeparture() {
        departureLabel.text = "departure_date".localized
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        departureTextfield.clearButtonMode = .always
        departureTextfield.inputView = datePickerView
        departureTextfield.inputAccessoryView = InputToolbar()
    }
    
    private func configureTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.keyboardDismissMode = .onDrag
        tableview.register(UINib(nibName: "Cell",bundle: nil), forCellReuseIdentifier: "Cell")
        viewModel.onDataChange { [weak self] in
            self?.searchButton.loadingIndicator(false)
            self?.tableview.reloadData()
        }
    }
    
    @objc private func textFieldDidChange(sender: UITextField) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(updateData(sender:)), object: sender)
        perform(#selector(updateData(sender:)), with: sender, afterDelay: 0.5)
    }
    
    
    @objc private func updateData(sender: UITextField) {
        if sender == fromTextfield, let from = fromTextfield.text, !from.isEmpty {
            originTagView.update(from)
        }
        
        if sender == toTextfield, let to = toTextfield.text, !to.isEmpty  {
            destinationTagView.update(to)
        }
    }
    
    @objc private func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        departureTextfield.text = dateFormatter.string(from: sender.date)
    }
    
    @objc private func presentProfile(sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProfileController") as! ProfileController
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}

//  MARK: - TableView Delegate & Datasource

extension MainController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        cell.viewModel = CellViewModel(quote: viewModel.dataForIndex(indexPath.row).0,
                                       places:viewModel.dataForIndex(indexPath.row).1,
                                       carriers: viewModel.dataForIndex(indexPath.row).2,
                                       currencySymbol: viewModel.dataForIndex(indexPath.row).3)
        cell.update()
        return cell
    }
}
