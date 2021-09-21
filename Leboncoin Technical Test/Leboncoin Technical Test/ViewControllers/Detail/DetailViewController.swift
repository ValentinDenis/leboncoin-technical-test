//
//  DetailViewController.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import UIKit

class DetailViewController: BaseViewController {

    //-----------------------------------------------------------------------
    // MARK: - SubViews
    //-----------------------------------------------------------------------
    private var scrollView = UIScrollView()
    private var contentView = UIStackView()
    private var innerContentView = UIStackView()
    private var adImageView = UIImageView()
    private var titleLabel = UILabel()
    private var priceLabel = UILabel()
    private var descLabel = UILabel()
    private var categoryLabel = UILabel()
    private var dateLabel = UILabel()
    private var contactButton = UIButton()
    
    //-----------------------------------------------------------------------
    // MARK: - Properties
    //-----------------------------------------------------------------------
    var ad: Ad?
    var category: Category?
    
    //-----------------------------------------------------------------------
    // MARK: - Life Cycle
    //-----------------------------------------------------------------------
    override func initialize() {
        super.initialize()
        
        //For testing
        view.accessibilityIdentifier = "DetailView"
        
        //Title
        self.title = "Détail"
        
        //Setup the scrollView
        setupScrollView()
        
        //Setup the views inside the scroll view
        setupSubViews()
    }

    //-----------------------------------------------------------------------
    // MARK: - Private Functions
    //-----------------------------------------------------------------------
    /// Setup the scroll view and its content view
    private func setupScrollView(){
        view.backgroundColor = .white
        contentView.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.axis = .vertical
        contentView.spacing = 0
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
            
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
        
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    /// Setup the subviews of the scrollview
    private func setupSubViews() {
        guard let ad = ad, let category = category else { return }
        
        //ImageView
        contentView.addArrangedSubview(adImageView)
        adImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 9.0 / 16.0).isActive = true
        adImageView.contentMode = .scaleAspectFit
        adImageView.backgroundColor = .black
        adImageView.layer.masksToBounds = true
        if let urlString = ad.imagesUrl.thumb, let url = URL(string: urlString) {
            adImageView.load(url: url)
        }else {
            adImageView.image = UIImage(named: "placeholder")
        }
        
        //Horizontal For Spacing
        let horizontalSpacerStackView = UIStackView()
        horizontalSpacerStackView.axis = .horizontal
        horizontalSpacerStackView.spacing = 0
        contentView.addArrangedSubview(horizontalSpacerStackView)
        let leftSpacer = UIView()
        let rightSpacer = UIView()
        leftSpacer.widthAnchor.constraint(equalToConstant: 16).isActive = true
        rightSpacer.widthAnchor.constraint(equalToConstant: 16).isActive = true
        let innerVerticalContentStackView = UIStackView()
        innerVerticalContentStackView.axis = .vertical
        innerVerticalContentStackView.spacing = 16.0
        horizontalSpacerStackView.addArrangedSubview(leftSpacer)
        horizontalSpacerStackView.addArrangedSubview(innerVerticalContentStackView)
        horizontalSpacerStackView.addArrangedSubview(rightSpacer)
        
        //Top Spacer
        let topSpacerView = UIView()
        topSpacerView.widthAnchor.constraint(equalToConstant: 2).isActive = true
        innerVerticalContentStackView.addArrangedSubview(topSpacerView)
        
        //Date & Category
        let horizontalDateAndCategoryStackView = UIStackView()
        horizontalDateAndCategoryStackView.axis = .horizontal
        innerVerticalContentStackView.addArrangedSubview(horizontalDateAndCategoryStackView)
        horizontalDateAndCategoryStackView.addArrangedSubview(dateLabel)
        horizontalDateAndCategoryStackView.addArrangedSubview(categoryLabel)
        dateLabel.numberOfLines = 1
        dateLabel.font = Constants.Font.OpenSans.light.font(withSize: 12)
        dateLabel.textColor = Constants.Colors.blackLBC?.withAlphaComponent(0.8)
        dateLabel.text = ad.dateFormat()
        dateLabel.textAlignment = .left
        categoryLabel.numberOfLines = 1
        categoryLabel.font = Constants.Font.OpenSans.italic.font(withSize: 12)
        categoryLabel.textColor = Constants.Colors.blackLBC
        categoryLabel.text = "\(category.name)"
        categoryLabel.textAlignment = .right

        //Title
        innerVerticalContentStackView.addArrangedSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.font = Constants.Font.OpenSans.semiBold.font(withSize: 18.0)
        titleLabel.textColor = Constants.Colors.blackLBC
        titleLabel.text = ad.title
        
        //Price
        innerVerticalContentStackView.addArrangedSubview(priceLabel)
        priceLabel.numberOfLines = 0
        priceLabel.font = Constants.Font.OpenSans.bold.font(withSize: 22.0)
        priceLabel.textColor = Constants.Colors.blackLBC
        priceLabel.text = ad.priceFormat()
        
        //Spacer
        let spacerBelowPrice = UIView()
        spacerBelowPrice.heightAnchor.constraint(equalToConstant: 1).isActive = true
        innerVerticalContentStackView.addArrangedSubview(spacerBelowPrice)
        
        //Description Title
        let descTitle = UILabel()
        innerVerticalContentStackView.addArrangedSubview(descTitle)
        descTitle.numberOfLines = 1
        descTitle.font = Constants.Font.OpenSans.semiBold.font(withSize: 15.0)
        descTitle.textColor = Constants.Colors.blackLBC
        descTitle.text = "Description: "
        
        //Description
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        innerVerticalContentStackView.addArrangedSubview(descLabel)
        descLabel.numberOfLines = 0
        descLabel.font = Constants.Font.OpenSans.regular.font(withSize: 14.0)
        descLabel.textColor = Constants.Colors.blackLBC
        descLabel.text = ad.description
        
        //Bottom Spacer
        let bottomSpacer = UIView()
        bottomSpacer.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
        innerVerticalContentStackView.addArrangedSubview(bottomSpacer)
        
        //Contact Button
        let contactStackView = UIStackView()
        contactStackView.axis = .horizontal
        contactStackView.spacing = 8
        innerVerticalContentStackView.addArrangedSubview(contactStackView)
        let leftContactSpacer = UIView()
        let rightContactSpacer = UIView()
        contactButton = UIButton()
        leftContactSpacer.widthAnchor.constraint(equalToConstant: 16).isActive = true
        rightContactSpacer.widthAnchor.constraint(equalToConstant: 16).isActive = true
        contactStackView.addArrangedSubview(leftContactSpacer)
        contactStackView.addArrangedSubview(contactButton)
        contactStackView.addArrangedSubview(rightContactSpacer)
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        contactButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        contactButton.setTitle("Contacter le vendeur", for: .normal)
        contactButton.backgroundColor = Constants.Colors.orangeLBC
        contactButton.setTitleColor(.white, for: .normal)
        contactButton.titleLabel?.font = Constants.Font.OpenSans.bold.font(withSize: 20)
        contactButton.addTarget(self, action: #selector(didTapContact), for: .touchUpInside)
        
        //Bottom Filler
        let bottomFillerView = UIView()
        innerVerticalContentStackView.addArrangedSubview(bottomFillerView)
    }
    
    @objc private func didTapContact() {
        let alert = UIAlertController(title: "Pas tout de suite !", message: "Peut-être dans une prochaine version 😀", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Avec plaisir !", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
