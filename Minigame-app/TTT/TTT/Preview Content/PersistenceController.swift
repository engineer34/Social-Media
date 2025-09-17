//
//  PersistenceController.swift
//  TTT
//
//  Created by Feliciano Medina on 3/2/25.
//


import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "CoreDataTable") // Match your .xcdatamodeld file name
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    var context: NSManagedObjectContext {
            return container.viewContext
        }
}
