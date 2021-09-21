//
//  AppDelegate.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Set the initial window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let controller = LaunchViewController()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
        setupAppearance()
        
        return true
    }

    private func setupAppearance() {
        UINavigationBar.appearance().tintColor = Constants.Colors.orangeLBC
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : Constants.Colors.orangeLBC ?? .black, NSAttributedString.Key.font : Constants.Font.OpenSans.bold.font(withSize: 17)]
    }
}

