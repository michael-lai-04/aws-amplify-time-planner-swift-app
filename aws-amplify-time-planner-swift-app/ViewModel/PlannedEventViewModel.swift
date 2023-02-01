//
//  PlannedEventViewModel.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 23/1/2023.
//

import Foundation

class PlannedEventViewModel: ObservableObject {
    
    @Published var plannedMorningEvents: [PlannedEvent]
    @Published var plannedMorningEventsDict: [TimeInterval: String]
    
    let dateHelper = DateHelper()
    let coreDM = CoreDataManager()
    
    init(){
        plannedMorningEvents = []
        plannedMorningEventsDict = [:]
    }
    
    func updateAllPlannedEvent() {
        plannedMorningEvents = coreDM.getAllPlannedEvent()
    }
        
    func updatePlannedMorningEventsDict() {
        updateAllPlannedEvent()
        var dict: [TimeInterval: String]   = [:]
        for event in plannedMorningEvents{
            dict[event.timestamp] = event.name
        }
        plannedMorningEventsDict = dict
    }
    
}
