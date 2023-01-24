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
    let dateHelper = DateHelper()
    
    init(){
        persistantContainer = NSPersistentContainer(name: modelName)
        persistantContainer.loadPersistentStores { (description, error) in
            if let error = error{
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func getAllPlannedEvent() -> [PlannedEvent]{
        
        let fetchRequest: NSFetchRequest<PlannedEvent> = PlannedEvent.fetchRequest()
        
        do{
            return try persistantContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }

    func savePlannedEvent(name:String){
        
        let plannedEvent = PlannedEvent(context:persistantContainer.viewContext)
        plannedEvent.id = UUID()
        plannedEvent.name = name
        let date = Date()
        let timestamp = dateHelper.formatFromDateToTimestamp(date: date)
        plannedEvent.timestamp = timestamp
        
        do{
            try persistantContainer.viewContext.save()
        }catch{
            print("Failed to save \(error)")
        }
    }
    
}
