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
    private let searchBar = UISearchBar()
    private var countLabel = UILabel()
    
    //Filter
    private var filterLabel = UILabel()
    private var filterButton = UIButton()
    private var filterImageView = UIImageView()
    
    //-----------------------------------------------------------------------
    // MARK: - Properties
    //-----------------------------------------------------------------------
    private var dataSource: [Ad] = []
    private var filteredDataSource: [Ad] = [] {
        didSet {
            updateCount()
        }
    }
    private var originalFilteredDataSourceBeforeSearch: [Ad] = []
    private var categories: [Category] = []
    private var pickedCategory: Category = Category.defaultCategory()
    private var isAlreadyPresentingAlert = false
    
    lazy var compactLayout: UICollectionViewFlowLayout = {
        //Cell Size
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width - 36
        let height = width * 9 / 16
        layout.itemSize = CGSize(width: width, height: height)
        
        return layout
      }()

    lazy var regLayout: UICollectionViewFlowLayout = {
        //Cell Size
        let layout = UICollectionViewFlowLayout()
        let width = 480.0
        let height = 230.0
        layout.itemSize = CGSize(width: width, height: height)

        return layout
      }()
    
    //-----------------------------------------------------------------------
    // MARK: - Life Cycle
    //-----------------------------------------------------------------------
    override func initialize() {
        super.initialize()
        
        //For tests
        view.accessibilityIdentifier = "ListView"
        
        //Title
        self.title = "Annonces"
        
        //Filter
        setupFilter()
        
        //Setup the views of the VC
        setUpViews()
        
        //Configure the layout for the correct size (handle iPad)
        configureLayoutForSize()
        
        //Fetch both ads and categories in parallel so we have both ready at the same time (because we need to show the category in each ad cell)
        fetchData()
        
    }
    
    override func finishInitializeAfterFirstAppear() {
        super.finishInitializeAfterFirstAppear()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.configureLayoutForSize()
        self.adCollectionView.reloadData()
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Private Functions
    //-----------------------------------------------------------------------
    /// Fetch all the needed data
    @objc private func fetchData() {
        showLoader()
        
        let taskGroup = DispatchGroup()
        
        //Fetch the ads
        taskGroup.enter()
        fetchAds {[weak self] ads in
            guard let self = self else { return }
            if let ads = ads {
                self.dataSource = ads
                self.filteredDataSource = ads
                self.originalFilteredDataSourceBeforeSearch = ads
            }
            taskGroup.leave()
        }
        
        //Fetch the categories for the picker
        taskGroup.enter()
        fetchCategories {[weak self] cats in
            guard let self = self else { return }
            if let cats = cats {
                self.categories = [Category.defaultCategory()]
                self.categories.append(contentsOf: cats)
                self.categories.sort(by: { $0.id < $1.id})
            }
            taskGroup.leave()
        }
        
        taskGroup.notify(queue: .main) {[weak self] in
            guard let self = self else { return }
            self.hideLoader()
            self.didPickCategory(category: self.pickedCategory)
        }
    }
    
    /// Fetch the ads from distance
    private func fetchAds(completion: (([Ad]?) -> Void)?) {
        adCollectionView.refreshControl?.beginRefreshing()
        APIService.fetchAds {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let ads):
                    completion?(ads)
                case .failure(let error):
                    completion?(nil)
                    self.showErrorAlert(withError: error)
                }
                self.adCollectionView.refreshControl?.endRefreshing()
                
            }
        }
    }
    
    /// Fetch the categories from distance
    private func fetchCategories(completion: (([Category]?) -> Void)?) {
        APIService.fetchCategories {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    completion?(categories)
                case .failure(let error):
                    completion?(nil)
                    self.showErrorAlert(withError: error)
                }
            }
        }
    }
    
    
    /// Shows an alert with the error localized description
    /// - Parameter error: The APIError received
    private func showErrorAlert(withError error: APIError) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            if !self.isAlreadyPresentingAlert {
                let alert = UIAlertController(title: "Erreur", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {[weak self] action in
                    guard let self = self else { return }
                    self.isAlreadyPresentingAlert = false
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
    }
    
    /// Setup all the views of the VC
    private func setUpViews() {
        //Setup the search bar
        setupSearchBar()
        
        //Setup the count label
        setupCount()
        
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
        adCollectionView.topAnchor.constraint(equalTo:countLabel.bottomAnchor, constant: 16).isActive = true
        adCollectionView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        adCollectionView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        adCollectionView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        //Delegates
        adCollectionView.delegate = self
        adCollectionView.dataSource = self
        
        //Cell
        adCollectionView.register(AdCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifiers.Cells.adCollectionViewCellID)
        
        //Refresh Control
        adCollectionView.alwaysBounceVertical = true
        refreshControl.tintColor = Constants.Colors.orangeLBC
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        adCollectionView.refreshControl = refreshControl
        
        //Default hidden
        adCollectionView.alpha = 0.0
    }
    
    /// Setup the loader in the center
    private func setupLoader() {
        view.addSubview(loaderView)
        loaderView.color = Constants.Colors.orangeLBC
        loaderView.hidesWhenStopped = true
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    /// Setup a filter custom nav bar button
    private func setupFilter() {
        filterLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 64, height: 30))
        filterLabel.text = "Toutes"
        filterLabel.textAlignment = .right
        filterLabel.font = Constants.Font.OpenSans.semiBold.font(withSize: 14)
        filterLabel.textColor = Constants.Colors.orangeLBC
        filterLabel.minimumScaleFactor = 0.5
        filterLabel.numberOfLines = 2
        
        filterButton = UIButton(type: .custom)
        filterButton.addTarget(self, action: #selector(filterPressed), for: .touchUpInside)
        
        filterImageView = UIImageView(frame: CGRect(x: 70, y: 5, width: 20, height: 20))
        filterImageView.image = UIImage(named: "filter")
        filterImageView.image = filterImageView.image?.withRenderingMode(.alwaysTemplate)
        filterImageView.tintColor = Constants.Colors.orangeLBC
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        filterButton.frame = customView.frame
        customView.addSubview(filterButton)
        customView.addSubview(filterImageView)
        customView.addSubview(filterLabel)
        
        let rightBarButton = UIBarButtonItem(customView: customView)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    /// Setup the search bar view
    private func setupSearchBar() {
        //Layout
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        searchBar.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        searchBar.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        
        //Config
        searchBar.barStyle = .default
        searchBar.placeholder = "Recherchez une annonce..."
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = false
        
        //Delegates
        searchBar.delegate = self
        
        //Default hidden
        searchBar.alpha = 0.0
    }
    
    /// Setup the count label
    private func setupCount() {
        //Layout
        view.addSubview(countLabel)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16).isActive = true
        countLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        countLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 16).isActive = true
        
        //Config
        countLabel.font = Constants.Font.OpenSans.semiBoldItalic.font(withSize: 18)
        countLabel.textColor = Constants.Colors.blackLBC
        
        //Default hidden
        countLabel.alpha = 0.0
    }
    
    /// Update the count label
    private func updateCount() {
        countLabel.text = "\(filteredDataSource.count) annonce(s)"
    }
    
    /// The nav bar button for filter has been pressed
    @objc func filterPressed() {
        Router.navigate(toRoute: .categoryPicker(categories: categories, pickedCategory: pickedCategory, delegate: self), presentationStyle: .modal(embedInNav: true), fromVC: self)
    }
    
    /// Show the loader in the center
    private func showLoader() {
        //Hide the CV and show the loader
        loaderView.startAnimating()
        UIView.animate(withDuration: 0.3) {[weak self] in
            guard let self = self else { return }
            self.loaderView.alpha = 1.0
            self.adCollectionView.alpha = 0.0
            self.searchBar.alpha = 0.0
            self.countLabel.alpha = 0.0
        }
    }
    
    /// Hide the loader in the center
    private func hideLoader() {
        //Hide the loader and show the CV
        loaderView.stopAnimating()
        UIView.animate(withDuration: 0.3) {[weak self] in
            guard let self = self else { return }
            self.adCollectionView.alpha = 1.0
            self.searchBar.alpha = 1.0
            self.countLabel.alpha = 1.0
        }
    }
    
    /// Filter the datasource with the searchtext
    /// - Parameter searchText: The search text
    private func filterWithSearch(searchText: String) {
        if searchText == "" {
            filteredDataSource = originalFilteredDataSourceBeforeSearch
        }else {
            filteredDataSource = originalFilteredDataSourceBeforeSearch.filter { ad in
                return ad.title.lowercased().contains(searchText.lowercased()) || ad.description.lowercased().contains(searchText.lowercased())
            }
        }
        
        //Reload
        adCollectionView.performBatchUpdates {
            adCollectionView.reloadSections(IndexSet(integer: 0))
        } completion: { finished in }
        
    }

}

/// Extension for CollectionView delegate & datasource
extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.Cells.adCollectionViewCellID, for: indexPath) as? AdCollectionViewCell else {
            return UICollectionViewCell()
        }
        let ad = filteredDataSource[indexPath.row]
        let category = categories.first(where: { $0.id == ad.categoryId })
        cell.fill(withAd: ad, forCategory: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ad = filteredDataSource[indexPath.row]
        guard let category = categories.first(where: { $0.id == ad.categoryId }) else { return }
        
        Router.navigate(toRoute: .detail(ad: ad, category: category), presentationStyle: .push, fromVC: self)
        
    }
    
}

/// Extension for CollectionView Layout
extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32.0
    }
    
    func configureLayoutForSize() {
        switch self.traitCollection.horizontalSizeClass{
        case .regular:
            self.adCollectionView.setCollectionViewLayout(self.regLayout, animated: false)
        case .compact, .unspecified:
            self.adCollectionView.setCollectionViewLayout(self.compactLayout, animated: false)
        @unknown default:
            self.adCollectionView.setCollectionViewLayout(self.compactLayout, animated: false)
        }
    }
   
}

/// Extension for the search bar delegate
extension ListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterWithSearch(searchText: searchText)
    }
}

/// Extension for Category Picker Delegate
extension ListViewController: CategoryPickerDelegate {
    func didPickCategory(category: Category) {
        //Dismiss the filter view
        dismiss(animated: true, completion: nil)
        
        //Reload after filtering
        pickedCategory = category
        if pickedCategory.id == Category.defaultCategory().id {
            filteredDataSource = Ad.sortAdsByUrgentAndDate(ads: dataSource)
        }else {
            filteredDataSource = Ad.sortAdsByUrgentAndDate(ads: dataSource.filter { $0.categoryId == category.id })
        }
        originalFilteredDataSourceBeforeSearch = filteredDataSource
        filterLabel.text = category.name
        
        //Reload
        adCollectionView.performBatchUpdates {
            adCollectionView.reloadSections(IndexSet(integer: 0))
        } completion: { finished in }
    }
    
    func didDismissWithoutPicking() {}
    
    
}
