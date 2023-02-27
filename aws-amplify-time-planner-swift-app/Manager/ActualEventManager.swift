//
//  ActualEventManager.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 2/2/2023.
//

import Foundation
import CoreData

class ActualEventManager {
    let dateHelper = DateHelper()
    
    func getAllActualEvent() -> [ActualEvent]{
        
        let fetchRequest: NSFetchRequest<ActualEvent> = ActualEvent.fetchRequest()
        
        do{
            return try CoreDataManager.intance.persistantContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
    
    func saveActualEvent(name:String, date: Date){
        let actualEvent = ActualEvent(context: CoreDataManager.intance.persistantContainer.viewContext)
        
        actualEvent.id = UUID()
        actualEvent.name = name
        
        let timestamp = dateHelper.formatFromDateToTimestamp(date: date)
        actualEvent.timestamp = timestamp
        
        do{
            try CoreDataManager.intance.persistantContainer.viewContext.save()
        }catch{
            print("Failed to save \(error)")
        }
        
    }
}
