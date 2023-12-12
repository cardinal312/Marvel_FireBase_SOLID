//
//  DataBaseManager.swift
//  MarvelFireBase
//
//  Created by Macbook on 8/12/23.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

protocol DataBaseManagerProtocol {
    func obtainPosts(docId: Constants, completion: @escaping (Result<Hero?, NetworkError>) -> Void)
    func getImage(imageName: Constants, completion: @escaping (Result<UIImage?, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case wrongUrl
}

final class DataBaseManager: DataBaseManagerProtocol {
    
    private let coreDataManager: CoreDataManagerProtocol
    private let firestore = Firestore.firestore()
    private let storage = Storage.storage()
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func obtainPosts(docId: Constants, completion: @escaping (Result<Hero?, NetworkError>) -> Void) {
        
        firestore.collection("herous").document("\(docId.rawValue)").getDocument { docs, error in
            guard error == nil else { completion(.failure(.wrongUrl)); return }
            let hero = Hero(name: docs?.get("name") as? String, description: docs?.get("description") as? String)
            DispatchQueue.main.async {
                self.coreDataManager.addHeroInfo(name: hero.name ?? "", decription: hero.description ?? "")
                completion(.success(hero))
            }
        }
    }
    
    func getImage(imageName: Constants, completion: @escaping (Result<UIImage?, NetworkError>) -> Void) {
        
        let reference = storage.reference()
        let path = reference.child("pictures")
        let defaultPic = UIImage(systemName: "star")
        let filePath = path.child(imageName.rawValue + ".jpeg")
        
        filePath.getData(maxSize: 1024 * 1024) { data, error in
            guard error == nil, let data = data else { completion(.failure(.wrongUrl)); return }
            self.coreDataManager.addHeroImage(heroImage: data)
            let image = UIImage(data: data) ?? defaultPic
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
    }
}






