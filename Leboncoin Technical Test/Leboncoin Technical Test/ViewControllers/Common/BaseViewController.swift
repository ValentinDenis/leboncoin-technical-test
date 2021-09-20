//
//  BaseViewController.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import UIKit

protocol BaseViewControllerProtocol {
    /// Initiailze View Controller before it appears
    func initialize()
    
    /// Other initialisation to do in VC when first appear.
    /// This method is not recalled when viewWillAppear or viewDidAppear methods are re-calling
    func finishInitializeAfterFirstAppear()
    
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {

    //-----------------------------------------------------------------------
    // MARK: - Properties
    //-----------------------------------------------------------------------
    private var hadFinishFirstLayout: Bool = false
    
    //-----------------------------------------------------------------------
    // MARK: - Life Cycle
    //-----------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialize
        initialize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Check if is first layout
        if !hadFinishFirstLayout{
            //First layout
            //Call sub initialize
            finishInitializeAfterFirstAppear()
            hadFinishFirstLayout = true
        }
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Protocol stubs
    //-----------------------------------------------------------------------
    func initialize() {}
    func finishInitializeAfterFirstAppear() {}

}
