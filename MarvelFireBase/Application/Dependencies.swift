//
//  Dependencies.swift
//  MarvelFireBase
//
//  Created by Macbook on 12/12/23.
//

final class Dependencies {
    
    var dataBaseManager: DataBaseManagerProtocol
    var uiManagerFactory: UIManagerFactoryProtocol
    var coreDataManager: CoreDataManagerProtocol
    
    init(dataBaseManager: DataBaseManagerProtocol, uiManagerFactory: UIManagerFactoryProtocol, coreDataManager: CoreDataManagerProtocol) {
        self.dataBaseManager = dataBaseManager
        self.uiManagerFactory = uiManagerFactory
        self.coreDataManager = coreDataManager
    }
}
