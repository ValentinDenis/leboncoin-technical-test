//
//  LaunchViewController.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import UIKit

class LaunchViewController: BaseViewController {

    //-----------------------------------------------------------------------
    // MARK: - SubViews
    //-----------------------------------------------------------------------
    private var logoImageView = UIImageView()
    private var loaderView = UIActivityIndicatorView()
    
    //-----------------------------------------------------------------------
    // MARK: - Life Cycle
    //-----------------------------------------------------------------------
    override func initialize() {
        super.initialize()
        setUpViews()
    }
    
    override func finishInitializeAfterFirstAppear() {
        super.finishInitializeAfterFirstAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Simulate fake initial loading (for now, maybe later wait for things to get in cache or initialize SDKs and stuff)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            Router.navigate(toRoute: .listing, presentationStyle: .replacingRoot(embedInNav: true), fromVC: self)
        }

    }
    
    deinit {
        loaderView.stopAnimating()
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Private Functions
    //-----------------------------------------------------------------------
    /// Setup the views of the controller
    private func setUpViews() {
        view.backgroundColor = .white
        
        //Logo
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: 1.0).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //Loader
        view.addSubview(loaderView)
        loaderView.color = Constants.Colors.orangeLBC
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32.0).isActive = true
        loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loaderView.startAnimating()
        
    }
}
