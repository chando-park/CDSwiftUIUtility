//
//  CDCoreDataStackPublisher.swift
//  CDCoreDataStack
//
//  Created by Chando Park on 6/16/24.
//

import CoreData
import Combine

open class CDCoreDataStackPublisher: CDCoreDataStack{
    public func saveContext(_ context: NSManagedObjectContext) -> Future<Void, NSError> {
        return Future<Void, NSError> { promiss in
            context.perform {
                do {
                    try context.save()
                    promiss(.success(()))
                } catch let error as NSError {
                    promiss(.failure(error))
                }
            }
        }
    }
}
