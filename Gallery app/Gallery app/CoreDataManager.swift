//
//  CoreDataManager.swift
//  Gallery app
//
//  Created by Victoria Samsonova on 5.03.25.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "FavouritesModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("unable to init CoreData \(error.localizedDescription)")
            }
        }
    }
    
}
