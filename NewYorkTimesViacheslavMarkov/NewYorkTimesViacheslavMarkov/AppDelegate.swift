//
//  AppDelegate.swift
//  NewYorkTimesViacheslavMarkov
//
//  Created by Viacheslav Markov on 02.07.2023.
//

import UIKit
import NYViewModels

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var window: UIWindow? = .init(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        showCategoryViewController()
        
        return true
    }
}

private extension AppDelegate {
    func showCategoryViewController() {
        let vm = CategoryVM()
        let vc = CategoryVC(viewModel: vm)
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}
