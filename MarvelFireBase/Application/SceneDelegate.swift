//
//  SceneDelegate.swift
//  MarvelFireBase
//
//  Created by Macbook on 8/12/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var dataBaseManager: DataBaseManagerProtocol?
    private var uiManager: UIManagerFactoryProtocol?
    private var coreDataManager: CoreDataManagerProtocol? //TODO: - Should be implement
    private var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        self.dataBaseManager = DataBaseManager()
        self.uiManager = UIManagerFactory()
        self.coreDataManager = CoreDataManager()
        
        guard let window = window, let dataBaseManager = dataBaseManager, let uiManager = uiManager, let coreDataManager = coreDataManager else { return }
        
        self.appCoordinator = AppCoordinator(window: window, dataBaseManager: dataBaseManager, uiManager: uiManager, coreDataManager: coreDataManager)
        appCoordinator?.start()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

