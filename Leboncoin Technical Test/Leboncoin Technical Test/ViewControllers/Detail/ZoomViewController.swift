//
//  ZoomViewController.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 22/09/2021.
//

import UIKit

class ZoomViewController: BaseViewController {

    //-----------------------------------------------------------------------
    // MARK: - SubViews
    //-----------------------------------------------------------------------
    private var imageView = UIImageView()
    
    //-----------------------------------------------------------------------
    // MARK: - Properties
    //-----------------------------------------------------------------------
    var image: UIImage?
    
    //-----------------------------------------------------------------------
    // MARK: - Life Cycle
    //-----------------------------------------------------------------------
    override func initialize() {
        super.initialize()
        
        //For testing
        view.accessibilityIdentifier = "ZoomView"
        
        //Setup the subviews
        setupSubViews()
        
    }

    //-----------------------------------------------------------------------
    // MARK: - Private Functions
    //-----------------------------------------------------------------------
    /// Setup the subviews
    private func setupSubViews() {
        guard let image = image else { return }
        
        view.backgroundColor = .white
        
        //ImageView
        imageView.image = image
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.enableZoom()
    }
    
}
