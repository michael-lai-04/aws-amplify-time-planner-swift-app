//
//  ActualEventViewModel.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 2/2/2023.
//

import Foundation

class ActualEventViewModel : ObservableObject{
    @Published var actualEvents: [ActualEvent]
    @Published var actualEventsDict: [TimeInterval: String]
    
    let dateHelper = DateHelper()
    let actualEventManager = ActualEventManager()
    
    init(){
        actualEvents = []
        actualEventsDict = [:]
    }
    
    func updateAllActualEvent(){
        actualEvents = actualEventManager.getAllActualEvent()
    }
    
    func updateActualEventsDict(){
        updateAllActualEvent()
        var dict:[TimeInterval : String] = [:]
        for event in actualEvents{
            dict[event.timestamp] = event.name
        }
        actualEventsDict = dict
    }
}
