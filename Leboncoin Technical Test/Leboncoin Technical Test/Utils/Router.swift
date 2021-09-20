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
    case detail(ad: Ad)
}

enum RoutePresentationStyle {
    case modal(embedInNav: Bool)
    case replacingRoot(embedInNav: Bool)
    case push
}

struct Router {
    static func navigate(toRoute route: Route, presentationStyle: RoutePresentationStyle = .push, fromVC: BaseViewController) {
        var destinationVC : UIViewController?
        
        switch route {
        case .listing:
            destinationVC = ListViewController()
        case .detail(let ad):
            destinationVC = DetailViewController()
            (destinationVC as? DetailViewController)?.ad = ad
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
