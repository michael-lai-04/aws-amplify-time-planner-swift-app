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
    
    init(){
        plannedMorningEvents = [
            PlannedEvent(name: "起床", timestamp:dateHelper.formatFromDateToTimestamp(date: "2023-01-18 06") )
        ]
    }
        
    func generatePlannedMorningEventsDict () -> [TimeInterval: String] {
        var dict: [TimeInterval: String]   = [:]
        for event in plannedMorningEvents{
            dict[event.timestamp] = event.name
        }
        return dict
    }
    
}
