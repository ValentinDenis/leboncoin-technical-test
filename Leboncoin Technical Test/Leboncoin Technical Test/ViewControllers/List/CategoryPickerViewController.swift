//
//  CategoryPickerViewController.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 21/09/2021.
//

import Foundation
import UIKit

protocol CategoryPickerDelegate {
    func didPickCategory(category: Category)
    func didDismissWithoutPicking()
}

class CategoryPickerViewController: BaseViewController {
    //-----------------------------------------------------------------------
    // MARK: - SubViews
    //-----------------------------------------------------------------------
    internal let tableView = UITableView()
    
    //-----------------------------------------------------------------------
    // MARK: - Properties
    //-----------------------------------------------------------------------
    var alreadyPickedCategory: Category?
    var categoryDataSource: [Category] = []
    var delegate: CategoryPickerDelegate?
    
    //-----------------------------------------------------------------------
    // MARK: - Life Cycle
    //-----------------------------------------------------------------------
    override func initialize() {
        super.initialize()
        
        //For tests
        view.accessibilityIdentifier = "CategoryPickerView"
        
        //Title
        self.title = "Filtres"
        
        //Setup the table view
        setupFilterTableView()
        
    }
    
    override func finishInitializeAfterFirstAppear() {
        super.finishInitializeAfterFirstAppear()
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Private Functions
    //-----------------------------------------------------------------------
    private func setupFilterTableView() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        
        //Layout
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        
        //Delegates & config
        tableView.delegate = self
        tableView.dataSource = self
        
        //Cell
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.Cells.categoryTableViewCellID)
        
        //Reload
        tableView.reloadData()
    }
}

extension CategoryPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.Cells.categoryTableViewCellID, for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        let category = categoryDataSource[indexPath.row]
        cell.fill(withCategory: category, selected: category.id == alreadyPickedCategory?.id)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categorySelected = categoryDataSource[indexPath.row]
        delegate?.didPickCategory(category: categorySelected)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
}
