//
//  CategoryTableViewCell.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 21/09/2021.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    //-----------------------------------------------------------------------
    // MARK: - SubViews
    //-----------------------------------------------------------------------
    internal let nameLabel = UILabel()
    internal let selectedImageView = UIImageView()
    
    //-----------------------------------------------------------------------
    // MARK: - Life Cycle
    //-----------------------------------------------------------------------
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Public Functions
    //-----------------------------------------------------------------------
    func fill(withCategory category: Category, selected: Bool) {
        nameLabel.text = category.name
        selectedImageView.isHidden = !selected
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Private Functions
    //-----------------------------------------------------------------------
    /// Reset the cell when reused
    internal func resetCell() {
        nameLabel.text = nil
    }
    
    /// Setup the subviews of the cell
    private func setupSubViews() {
        //Name
        contentView.addSubview(nameLabel)
        nameLabel.font = Constants.Font.OpenSans.regular.font(withSize: 15)
        nameLabel.textColor = Constants.Colors.blackLBC
        nameLabel.numberOfLines = 1
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 48.0).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 4).isActive = true
        
        //Selected Image
        contentView.addSubview(selectedImageView)
        selectedImageView.image = UIImage(named: "check")
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        selectedImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16.0).isActive = true
        selectedImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        selectedImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
    }

}
