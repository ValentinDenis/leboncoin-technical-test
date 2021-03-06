//
//  Router.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import Foundation
import UIKit

enum Route {
    case listing
    case detail(ad: Ad, category: Category)
    case categoryPicker(categories: [Category], pickedCategory: Category, delegate: CategoryPickerDelegate?)
    case zoom(image: UIImage)
}

enum RoutePresentationStyle {
    case modal(embedInNav: Bool)
    case replacingRoot(embedInNav: Bool)
    case push
}

struct Router {
    /// Used to navigate to different part of the application, and handle navigation stack if necessary
    /// - Parameters:
    ///   - route: The route to display
    ///   - presentationStyle: The presentation style for displaying the route
    ///   - fromVC: The VC calling this methond
    static func navigate(toRoute route: Route, presentationStyle: RoutePresentationStyle = .push, fromVC: BaseViewController) {
        var destinationVC : UIViewController?
        
        switch route {
        case .listing:
            destinationVC = ListViewController()
        case .detail(let ad, let category):
            destinationVC = DetailViewController()
            (destinationVC as? DetailViewController)?.ad = ad
            (destinationVC as? DetailViewController)?.category = category
        case .categoryPicker(let categories, let pickedCategory, let delegate):
            destinationVC = CategoryPickerViewController()
            (destinationVC as? CategoryPickerViewController)?.categoryDataSource = categories
            (destinationVC as? CategoryPickerViewController)?.alreadyPickedCategory = pickedCategory
            (destinationVC as? CategoryPickerViewController)?.delegate = delegate
        case .zoom(let image):
            destinationVC = ZoomViewController()
            (destinationVC as? ZoomViewController)?.image = image
        }
        
        guard let destinationVC = destinationVC else { return }
        
        switch presentationStyle {
        case .modal(let embedInNav):
            let toPresent = embedInNav ? UINavigationController(rootViewController: destinationVC) : destinationVC
            fromVC.present(toPresent, animated: true, completion: nil)
        case .push:
            fromVC.navigationController?.pushViewController(destinationVC, animated: true)
        case .replacingRoot(let embedInNav):
            let toReplace = embedInNav ? UINavigationController(rootViewController: destinationVC) : destinationVC
            UIApplication.shared.windows.first?.rootViewController = toReplace
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}
