//
//  PlannedEventViewModel.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 23/1/2023.
//

import Foundation

class PlannedEventViewModel: ObservableObject {
    
    @Published var plannedMorningEvents: [PlannedEvent]

    let dateHelper = DateHelper()
    let coreDM = CoreDataManager()
    
    init(){
        plannedMorningEvents = coreDM.getAllPlannedEvent()
    }
        
    func generatePlannedMorningEventsDict () -> [TimeInterval: String] {
        var dict: [TimeInterval: String]   = [:]
        for event in plannedMorningEvents{
            dict[event.timestamp] = event.name
        }
        return dict
    }
    
}
