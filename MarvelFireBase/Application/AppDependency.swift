//
//  Dependencies.swift
//  MarvelFireBase
//
//  Created by Macbook on 12/12/23.
//

final class AppDependency {
    
    let dataBaseManager: DataBaseManagerProtocol
    let uiManagerFactory: UIManagerFactoryProtocol
    let coreDataManager: CoreDataManagerProtocol
    
    init(dataBaseManager: DataBaseManagerProtocol, uiManagerFactory: UIManagerFactoryProtocol, coreDataManager: CoreDataManagerProtocol) {
        self.dataBaseManager = dataBaseManager
        self.uiManagerFactory = uiManagerFactory
        self.coreDataManager = coreDataManager
    }
    
    static func makeDI() -> AppDependency {
        let coreDataManager = CoreDataManager()
        let dataBaseManager = DataBaseManager(coreDataManager: coreDataManager)
        let uiManagerFactory = UIManagerFactory()

        return AppDependency(dataBaseManager: dataBaseManager, uiManagerFactory: uiManagerFactory, coreDataManager: coreDataManager)
    }
}
