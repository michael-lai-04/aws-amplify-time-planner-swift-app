//
//  ActualEventManager.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 2/2/2023.
//

import Foundation
import CoreData

class ActualEventManager {
    let coreDataManager = CoreDataManager()
    let dateHelper = DateHelper()
    
    func getAllActualEvent() -> [ActualEvent]{
        
        let fetchRequest: NSFetchRequest<ActualEvent> = ActualEvent.fetchRequest()
        
        do{
            return try coreDataManager.persistantContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
    
    func saveActualEvent(name:String, date: Date){
        let actualEvent = ActualEvent(context: coreDataManager.persistantContainer.viewContext)
        
        actualEvent.id = UUID()
        actualEvent.name = name
        
        let timestamp = dateHelper.formatFromDateToTimestamp(date: date)
        actualEvent.timestamp = timestamp
        
        do{
            try coreDataManager.persistantContainer.viewContext.save()
        }catch{
            print("Failed to save \(error)")
        }
        
    }
}
