//
//  AppCoordinator.swift
//  MarvelFireBase
//
//  Created by Macbook on 9/12/23.
//

import UIKit

final class AppCoordinator {
    
    private var window: UIWindow
    private var dataBaseManager: DataBaseManagerProtocol
    private var uiManager: UIManagerFactoryProtocol
    private var coreDataManager: CoreDataManagerProtocol
    
    init(window: UIWindow,
         dataBaseManager: DataBaseManagerProtocol,
         uiManager: UIManagerFactoryProtocol,
         coreDataManager: CoreDataManagerProtocol) {
        
        self.window = window
        self.dataBaseManager = dataBaseManager
        self.uiManager = uiManager
        self.coreDataManager = coreDataManager
    }
    
    func start() {
        let marvelVC = MarverViewController(dataBaseManager: dataBaseManager, uiManager: uiManager, coreDataManager: coreDataManager)
        marvelVC.view.backgroundColor = .white
        marvelVC.navigationItem.title = "MARVEL 🔥"
        let nav = UINavigationController(rootViewController: marvelVC)
        nav.navigationBar.prefersLargeTitles = true
        nav.navigationItem.largeTitleDisplayMode = .automatic
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}



