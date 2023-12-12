//
//  CoreDataManager.swift
//  MarvelFireBase
//
//  Created by Macbook on 9/12/23.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    
    var heroItemCopy: [HeroItem] { get }
    func addHeroInfo(name: String, decription: String)
    func addHeroImage(heroImage: Data?)
}

final class CoreDataManager: CoreDataManagerProtocol {
    
    //MARK: - Custom Queue
    private var cuncurent = DispatchQueue(label: "cuncurent", attributes: .concurrent)
    private var heroItem = [HeroItem]()
    
    var heroItemCopy: [HeroItem] {
        var item = [HeroItem]()
        cuncurent.sync {
            item = heroItem
        }
        return item
    }
    
    init() {
        fetchAllData()
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MarvelFireBase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAllData() {
        let request = HeroItem.fetchRequest()
        if let items = try? persistentContainer.viewContext.fetch(request) {
            self.heroItem = items
        }
    }
    
    func addHeroInfo(name: String, decription: String) {
        let heroItem = HeroItem(context: persistentContainer.viewContext)
        
        do {
            cuncurent.async(flags: .barrier) { [weak self] in
                guard let self = self else { return }
                heroItem.id = UUID().uuidString
                heroItem.name = name
                heroItem.heroDesc = decription
                
                self.saveContext()
                self.fetchAllData()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func addHeroImage(heroImage: Data?) {
        
        do {
            guard let data = heroImage else { print("can't encode image to data!"); return }
            let heroItem = HeroItem(context: persistentContainer.viewContext)
            
            cuncurent.async(flags: .barrier) { [weak self] in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    heroItem.heroImage = data
                }
                self.saveContext()
                self.fetchAllData()
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

@objc(HeroItem)
public class HeroItem: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeroItem> {
        return NSFetchRequest<HeroItem>(entityName: "HeroItem")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var heroDesc: String?
    @NSManaged public var heroImage: Data?
    
}

