//
//  AdCollectionViewCell.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import UIKit

class AdCollectionViewCell: UICollectionViewCell {
    //-----------------------------------------------------------------------
    // MARK: - SubViews
    //-----------------------------------------------------------------------
    internal let mainStackView = UIStackView(frame: CGRect.zero)
    internal let titleLabel = UILabel()
    internal let categoryLabel = UILabel()
    internal let descExcerptLabel = UILabel()
    internal let dateLabel = UILabel()
    internal let priceLabel = UILabel()
    internal let urgentLabel = UILabel()
    internal let adImageView = UIImageView()
    
    //-----------------------------------------------------------------------
    // MARK: - Life Cycle
    //-----------------------------------------------------------------------
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isAccessibilityElement = true
        setUpSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Public Functions
    //-----------------------------------------------------------------------
    func fill(withAd ad: Ad, forCategory category: Category?) {
        //Title
        titleLabel.text = ad.title
        
        //Price
        priceLabel.text = ad.priceFormat()
        
        //Short description
        descExcerptLabel.text = ad.description
        
        //Category
        if let cat = category {
            categoryLabel.text = cat.name
        }else {
            categoryLabel.isHidden = true
        }
        
        //Date
        dateLabel.text = ad.dateFormat()
        
        //Urgent
        urgentLabel.isHidden = !ad.isUrgent
    
        //Image
        guard let urlString = ad.imagesUrl.small, let url = URL(string: urlString) else {
            adImageView.image = UIImage(named: "placeholder")
            return
        }
        adImageView.load(url: url)
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Private Functions
    //-----------------------------------------------------------------------
    private func resetCell() {
        titleLabel.text = nil
        categoryLabel.text = nil
        descExcerptLabel.text = nil
        dateLabel.text = nil
        priceLabel.text = nil
        adImageView.image = nil
    }
    
    private func setUpSubViews() {
        //Shadow
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        
        
        //Horizontal StackView
        contentView.addSubview(mainStackView)
        mainStackView.addBackground(color: .white)
        mainStackView.alignment = .fill
        mainStackView.axis = .horizontal
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        //Spacer Left
        let spacerLeft = UIView()
        spacerLeft.translatesAutoresizingMaskIntoConstraints = false
        spacerLeft.widthAnchor.constraint(equalToConstant: 16.0).isActive = true
        mainStackView.addArrangedSubview(spacerLeft)
        
        //Inner Vertical Stack View
        let innerStackView = UIStackView()
        innerStackView.translatesAutoresizingMaskIntoConstraints = false
        innerStackView.alignment = .fill
        innerStackView.axis = .horizontal
        mainStackView.addArrangedSubview(innerStackView)
        
        //Spacer Right
        let spacerRight = UIView()
        spacerRight.translatesAutoresizingMaskIntoConstraints = false
        spacerRight.widthAnchor.constraint(equalToConstant: 16.0).isActive = true
        mainStackView.addArrangedSubview(spacerRight)
        
        //Image View Stack
        let imageViewStackView = UIStackView()
        imageViewStackView.axis = .vertical
        imageViewStackView.alignment = .fill
        imageViewStackView.spacing = 16
        //Image View Stack Top Spacer
        let topImageSpacer = UIView()
        topImageSpacer.translatesAutoresizingMaskIntoConstraints = false
        imageViewStackView.addArrangedSubview(topImageSpacer)
        
        //ImageView itself
        adImageView.contentMode = .scaleAspectFill
        adImageView.translatesAutoresizingMaskIntoConstraints = false
        adImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        adImageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        adImageView.layer.masksToBounds = true
        adImageView.layer.cornerRadius = 8.0
        imageViewStackView.addArrangedSubview(adImageView)
        
        //Urgent Label
        urgentLabel.numberOfLines = 1
        urgentLabel.text = "Urgent"
        urgentLabel.textAlignment = .center
        urgentLabel.backgroundColor = Constants.Colors.orangeLBC
        urgentLabel.textColor = .white
        urgentLabel.layer.cornerRadius = 10.0
        urgentLabel.layer.masksToBounds = true
        urgentLabel.font = Constants.Font.OpenSans.bold.font(withSize: 13)
        urgentLabel.translatesAutoresizingMaskIntoConstraints = false
        urgentLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageViewStackView.addArrangedSubview(urgentLabel)
        
        //Image View Stack Bottom Spacer
        let bottomImageSpacer = UIView()
        bottomImageSpacer.translatesAutoresizingMaskIntoConstraints = false
        imageViewStackView.addArrangedSubview(bottomImageSpacer)
        //Layout
        topImageSpacer.heightAnchor.constraint(equalTo: bottomImageSpacer.heightAnchor, multiplier: 1).isActive = true
        innerStackView.addArrangedSubview(imageViewStackView)

        //Spacer after Image
        let afterImageSpacer = UIView()
        afterImageSpacer.translatesAutoresizingMaskIntoConstraints = false
        afterImageSpacer.widthAnchor.constraint(equalToConstant: 16.0).isActive = true
        innerStackView.addArrangedSubview(afterImageSpacer)
        
        //Infos stack view
        let infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.alignment = .fill
        infoStackView.spacing = 4.0
        innerStackView.addArrangedSubview(infoStackView)
        
        //Top filler
        let topFiller = UIView()
        infoStackView.addArrangedSubview(topFiller)
        
        //Top info Spacer
        let topInfoSpacer = UIView()
        topInfoSpacer.translatesAutoresizingMaskIntoConstraints = false
        topInfoSpacer.heightAnchor.constraint(equalToConstant: 12.0).isActive = true
        infoStackView.addArrangedSubview(topInfoSpacer)
        
        //Title
        titleLabel.numberOfLines = 2
        titleLabel.font = Constants.Font.OpenSans.semiBold.font(withSize: 13)
        titleLabel.textColor = Constants.Colors.blackLBC
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.addArrangedSubview(titleLabel)
        
        //Price
        priceLabel.numberOfLines = 1
        priceLabel.font = Constants.Font.OpenSans.regular.font(withSize: 12)
        priceLabel.textColor = Constants.Colors.blackLBC
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.addArrangedSubview(priceLabel)
        
        //Spacer
        let infoSpacer = UIView()
        infoSpacer.translatesAutoresizingMaskIntoConstraints = false
        infoSpacer.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
        infoStackView.addArrangedSubview(infoSpacer)
        
        //Short Desc
        descExcerptLabel.numberOfLines = 3
        descExcerptLabel.font = Constants.Font.OpenSans.regular.font(withSize: 10)
        descExcerptLabel.textColor = Constants.Colors.blackLBC?.withAlphaComponent(0.8)
        descExcerptLabel.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.addArrangedSubview(descExcerptLabel)
        
        //Spacer
        let infoSpacer2 = UIView()
        infoSpacer2.translatesAutoresizingMaskIntoConstraints = false
        infoSpacer2.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
        infoStackView.addArrangedSubview(infoSpacer2)
        
        //Category
        categoryLabel.numberOfLines = 1
        categoryLabel.font = Constants.Font.OpenSans.italic.font(withSize: 10)
        categoryLabel.textColor = Constants.Colors.blackLBC
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.addArrangedSubview(categoryLabel)
        
        //Date
        dateLabel.numberOfLines = 1
        dateLabel.font = Constants.Font.OpenSans.italic.font(withSize: 10)
        dateLabel.textColor = Constants.Colors.blackLBC?.withAlphaComponent(0.5)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.addArrangedSubview(dateLabel)
        
        //Dynamic Height Spacer
        let dynSpacer = UIView()
        infoSpacer.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.addArrangedSubview(dynSpacer)
        topFiller.heightAnchor.constraint(equalTo: dynSpacer.heightAnchor, multiplier: 1.0).isActive = true
        
    }
}
