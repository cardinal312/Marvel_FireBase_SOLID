//
//  AppCoordinator.swift
//  MarvelFireBase
//
//  Created by Macbook on 9/12/23.
//

import UIKit

final class AppCoordinator {
    
    private let window: UIWindow
    private let dependencies: AppDependency
    
    init?(window: UIWindow?, dependencies: AppDependency? ) {
        guard let window = window, let dependencies = dependencies else { return nil }
        self.window = window
        self.dependencies = dependencies
    }
    
    func start() {
        
        let marvelVC = MarvelViewController(dependencies: dependencies)
        marvelVC.view.backgroundColor = .white
        marvelVC.navigationItem.title = "MARVEL 🔥"
        let nav = UINavigationController(rootViewController: marvelVC)
        nav.navigationBar.prefersLargeTitles = true
        nav.navigationItem.largeTitleDisplayMode = .automatic
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}



