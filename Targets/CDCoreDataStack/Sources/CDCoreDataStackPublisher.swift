//
//  CDCoreDataStackPublisher.swift
//  CDCoreDataStack
//
//  Created by Chando Park on 6/16/24.
//

import CoreData
import Combine

public class CDCoreDataStackPublisher: CDCoreDataStack{
    public func saveContext(_ context: NSManagedObjectContext) -> Future<String?, NSError> {
        return Future<String?, NSError> { promiss in
            context.perform {
                do {
                    try context.save()
                    promiss(.success(nil))
                } catch let error as NSError {
                    promiss(.failure(error))
                }
            }
        }
    }
}
