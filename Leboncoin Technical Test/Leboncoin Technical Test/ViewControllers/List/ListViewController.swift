//
//  ListViewController.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import UIKit

class ListViewController: BaseViewController {

    //-----------------------------------------------------------------------
    // MARK: - SubViews
    //-----------------------------------------------------------------------
    private let adCollectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let loaderView = UIActivityIndicatorView()
    private let refreshControl = UIRefreshControl()
    
    //-----------------------------------------------------------------------
    // MARK: - Properties
    //-----------------------------------------------------------------------
    private var dataSource: [Ad] = [] {
        didSet {
            adCollectionView.reloadData()
        }
    }
    
    private var categories: [Category] = [] {
        didSet {
            
        }
    }
    
    
    
    //-----------------------------------------------------------------------
    // MARK: - Life Cycle
    //-----------------------------------------------------------------------
    override func initialize() {
        super.initialize()
        
        //Setup the views of the VC
        setUpViews()
        
        //Fetch the ads for the CV
        showLoader()
        fetchAds {[weak self] in
            guard let self = self else { return }
            self.hideLoader()
        }
        
        //Fetch the categories for the picker
        fetchCategories()
        
    }
    
    override func finishInitializeAfterFirstAppear() {
        super.finishInitializeAfterFirstAppear()
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Private Functions
    //-----------------------------------------------------------------------
    /// Fetch the ads from distance
    @objc private func fetchAds(completion: (() -> Void)?) {
        adCollectionView.refreshControl?.beginRefreshing()
        APIService.fetchAds {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let ads):
                    self.dataSource = ads
                case .failure(let error):
                    self.showErrorAlert(withError: error)
                }
                self.adCollectionView.refreshControl?.endRefreshing()
                completion?()
            }
        }
    }
    
    /// Fetch the categories from distance
    private func fetchCategories() {
        APIService.fetchCategories {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self.categories = categories
                case .failure(let error):
                    self.showErrorAlert(withError: error)
                }
            }
        }
    }
    
    
    /// Shows an alert with the error localized description
    /// - Parameter error: The APIError received
    private func showErrorAlert(withError error: APIError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Erreur", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    /// Setup all the views of the VC
    private func setUpViews() {
        //Setup the collectionview
        setupCollectionView()
    }
    
    /// Setup the collection view
    private func setupCollectionView() {
        view.backgroundColor = .white
        adCollectionView.backgroundColor = .white
        
        //Layout
        view.addSubview(adCollectionView)
        adCollectionView.translatesAutoresizingMaskIntoConstraints = false
        adCollectionView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        adCollectionView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        adCollectionView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        adCollectionView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        
        //Delegates
        adCollectionView.delegate = self
        adCollectionView.dataSource = self
        
        //Cell
        adCollectionView.register(AdCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifiers.Cells.adCollectionViewCellID)
        
        //Refresh Control
        adCollectionView.alwaysBounceVertical = true
        refreshControl.tintColor = Constants.Colors.orangeLBC
        refreshControl.addTarget(self, action: #selector(fetchAds(completion:)), for: .valueChanged)
        adCollectionView.refreshControl = refreshControl
    }
    
    private func setupLoader() {
        view.addSubview(loaderView)
        loaderView.color = Constants.Colors.orangeLBC
        loaderView.hidesWhenStopped = true
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func showLoader() {
        //Hide the CV and show the loader
        UIView.animate(withDuration: 0.3) {[weak self] in
            guard let self = self else { return }
            self.loaderView.alpha = 1.0
            self.adCollectionView.alpha = 0.0
        }
    }
    
    private func hideLoader() {
        //Hide the loader and show the CV
        UIView.animate(withDuration: 0.3) {[weak self] in
            guard let self = self else { return }
            self.loaderView.alpha = 0.0
            self.adCollectionView.alpha = 1.0
        }
    }

}

/// Extension for CollectionView delegate & datasource
extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.Cells.adCollectionViewCellID, for: indexPath) as? AdCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.fill(withAd: dataSource[indexPath.row])
        return cell
    }
    
}

/// Extension for CollectionView Layout
extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width - 36
        let height = width * 9 / 16
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 16, bottom: 32, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32.0
    }
}
