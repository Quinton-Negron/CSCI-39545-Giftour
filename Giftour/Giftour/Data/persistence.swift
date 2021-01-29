//
//  Persistence.swift
//  Giftour
//
//  Created by Quinton Negron on 1/10/21.
//  Copyright © 2021 Quinton Negron. All rights reserved.
//

import Foundation
import CoreData

class persistence{
    static var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Date")
        container.loadPersistentStores { (storeDescription, error)
            in
            if let error = error {
                fatalError("Could not load data store: \(error)")
            }
        }
        return container
    }()
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("saved")
            } catch {
                let nserror = error as NSError
                fatalError("ERROR: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
