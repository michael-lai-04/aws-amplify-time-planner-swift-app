//
//  PlannedEventManager.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 2/2/2023.
//

import Foundation
import CoreData

class PlannedEventManager {
    
    let coreDataManager = CoreDataManager()
    let dateHelper = DateHelper()

    func getAllPlannedEvent() -> [PlannedEvent]{
        
        let fetchRequest: NSFetchRequest<PlannedEvent> = PlannedEvent.fetchRequest()
        
        do{
            return try coreDataManager.persistantContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }

    func savePlannedEvent(name:String, date: Date){
        
        let plannedEvent = PlannedEvent(context:coreDataManager.persistantContainer.viewContext)
        
        plannedEvent.id = UUID()
        plannedEvent.name = name
        let timestamp = dateHelper.formatFromDateToTimestamp(date: date)
        plannedEvent.timestamp = timestamp
        
        do{
            try coreDataManager.persistantContainer.viewContext.save()
        }catch{
            print("Failed to save \(error)")
        }
    }
}
