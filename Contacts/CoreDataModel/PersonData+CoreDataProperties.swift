//
//  PersonData+CoreDataProperties.swift
//  
//
//  Created by Balaji Sundaram on 23/08/20.
//
//

import Foundation
import CoreData


extension PersonData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonData> {
        return NSFetchRequest<PersonData>(entityName: "PersonData")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var roleTitle: String?
    @NSManaged public var mobileNumber: String?
    @NSManaged public var emailId: String?
    @NSManaged public var id: UUID?

}
