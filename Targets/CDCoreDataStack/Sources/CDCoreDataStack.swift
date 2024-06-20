//
//  CoreDataStack.swift
//  CoreDataStack
//
//  Created by iOS Developer on 2023/09/15.
//

import Foundation
import CoreData

open class CoreDataStack {
    
    // Determines if the CoreData stack should use an in-memory store, primarily for testing.
    private let inMemory: Bool
    
    // The name of the Core Data model.
    private let modelName: String
    
    // The managed object model for the Core Data stack, loaded from the specified bundle.
    private let model: NSManagedObjectModel
    
    // Initializes the CoreDataStack with a model name, optionally setting it to use an in-memory store.
    public init(modelName: String, inMemory: Bool = false) {
        self.modelName = modelName
        self.inMemory = inMemory
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to locate Core Data model file for \(modelName).")
        }
        self.model = managedObjectModel
    }
    
    // The main context for performing Core Data operations on the main thread.
    public lazy var mainContext: NSManagedObjectContext = {
        return storeContainer.viewContext
    }()
    
    // The persistent container that encapsulates the Core Data stack.
    public lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName, managedObjectModel: model)
        
        // If in-memory store is specified, configure the container accordingly.
        if inMemory {
            let persistentStoreDescription = NSPersistentStoreDescription()
            persistentStoreDescription.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [persistentStoreDescription]
        }
        
        // Load the persistent stores, handling any errors that occur.
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // Creates a new background context derived from the store container.
    public func newDerivedContext() -> NSManagedObjectContext {
        let context = storeContainer.newBackgroundContext()
        return context
    }
    
    // Saves changes in the main context.
    public func saveContext() {
        saveContext(mainContext)
    }
    
    // Saves changes in the specified context.
    public func saveContext(_ context: NSManagedObjectContext) {
        if context != mainContext {
            saveDerivedContext(context)
            return
        }
        
        // Performs the save operation on the main context.
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    // Saves changes in a derived context and then propagates them to the main context.
    public func saveDerivedContext(_ context: NSManagedObjectContext) {
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            self.saveContext(self.mainContext)
        }
    }
}
