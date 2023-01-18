//
//  Movie+CoreDataProperties.swift
//  
//
//  Created by Michael  Lai on 17/1/2023.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?

}
