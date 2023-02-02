//
//  PlannedEventViewModel.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 23/1/2023.
//

import Foundation

class PlannedEventViewModel: ObservableObject {
    
    @Published var plannedEvents: [PlannedEvent]
    @Published var plannedEventsDict: [TimeInterval: String]
    
    let dateHelper = DateHelper()
    let plannedEventManager = PlannedEventManager()
    
    init(){
        plannedEvents = []
        plannedEventsDict = [:]
    }
    
    func updateAllPlannedEvent() {
        plannedEvents = plannedEventManager.getAllPlannedEvent()
    }
    
    func updatePlannedEventsDict() {
        updateAllPlannedEvent()
        var dict: [TimeInterval: String]   = [:]
        for event in plannedEvents{
            dict[event.timestamp] = event.name
        }
        plannedEventsDict = dict
    }
    
}
