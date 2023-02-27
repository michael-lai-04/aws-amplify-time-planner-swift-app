//
//  PlannedEventManager.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 2/2/2023.
//

import Foundation
import CoreData

class PlannedEventManager {
    
    let dateHelper = DateHelper()

    func getAllPlannedEvent() -> [PlannedEvent]{
        
        let fetchRequest: NSFetchRequest<PlannedEvent> = PlannedEvent.fetchRequest()
        
        do{
            return try CoreDataManager.intance.persistantContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }

    func savePlannedEvent(name:String, date: Date){
        
        let plannedEvent = PlannedEvent(context:CoreDataManager.intance.persistantContainer.viewContext)
        
        plannedEvent.id = UUID()
        plannedEvent.name = name
        let timestamp = dateHelper.formatFromDateToTimestamp(date: date)
        plannedEvent.timestamp = timestamp
        
        do{
            try CoreDataManager.intance.persistantContainer.viewContext.save()
        }catch{
            print("Failed to save \(error)")
        }
    }
}
