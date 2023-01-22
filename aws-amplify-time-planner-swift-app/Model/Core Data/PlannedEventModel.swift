//
//  PlannedEventModel.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 23/1/2023.
//

import Foundation

struct PlannedEvent: Identifiable {
    let id = UUID()
    let name: String
    let timestamp:TimeInterval
}
