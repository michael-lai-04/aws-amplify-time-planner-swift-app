//
//  ActualEvent+CoreDataProperties.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 2/2/2023.
//
//

import Foundation
import CoreData


extension ActualEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActualEvent> {
        return NSFetchRequest<ActualEvent>(entityName: "ActualEvent")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var timestamp: Double

}

extension ActualEvent : Identifiable {

}
