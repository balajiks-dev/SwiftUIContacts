//
//  Persons+CoreDataProperties.swift
//  
//
//  Created by Balaji Sundaram on 23/08/20.
//
//

import Foundation
import CoreData


extension Persons {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Persons> {
        return NSFetchRequest<Persons>(entityName: "Persons")
    }

    @NSManaged public var persons: [PersonData]?

}
