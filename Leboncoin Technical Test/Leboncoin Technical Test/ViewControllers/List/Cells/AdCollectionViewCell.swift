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
    private let mainStackView = UIStackView(frame: CGRect.zero)
    private let titleLabel = UILabel()
    private let categoryLabel = UILabel()
    private let descExcerptLabel = UILabel()
    private let dateLabel = UILabel()
    private let priceLabel = UILabel()
    private let urgentLabel = UILabel()
    private let adImageView = UIImageView()
    
    //-----------------------------------------------------------------------
    // MARK: - Life Cycle
    //-----------------------------------------------------------------------
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Public Functions
    //-----------------------------------------------------------------------
    func fill(withAd ad: Ad) {
        titleLabel.text = ad.title
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Private Functions
    //-----------------------------------------------------------------------
    private func setUpSubViews() {
        //Test
        contentView.layer.cornerRadius = 6.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        
        
        //Stack View
        contentView.addSubview(mainStackView)
        mainStackView.addBackground(color: .white)
        mainStackView.alignment = .fill
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        //Title
        titleLabel.textColor = .blue
        mainStackView.addArrangedSubview(titleLabel)
    }
}
