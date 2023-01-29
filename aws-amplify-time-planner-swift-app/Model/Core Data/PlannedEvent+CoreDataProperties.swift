//
//  PlannedEvent+CoreDataProperties.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 25/1/2023.
//
//

import Foundation
import CoreData


extension PlannedEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlannedEvent> {
        return NSFetchRequest<PlannedEvent>(entityName: "PlannedEvent")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var timestamp: Double

}

extension PlannedEvent : Identifiable {

}
