//
//  CoreDataManager.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 23/1/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistantContainer: NSPersistentContainer
    let modelName = "aws-amplify-time-planner-swift-app-model"
    
    init(){
        persistantContainer = NSPersistentContainer(name: modelName)
        persistantContainer.loadPersistentStores { (description, error) in
            if let error = error{
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
}
