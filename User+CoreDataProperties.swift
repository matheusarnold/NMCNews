//
//  User+CoreDataProperties.swift
//  arrayNMCNews
//
//  Created by Laurentia Audrey on 15/12/20.
//  Copyright © 2020 Matheus. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userId: String?
    @NSManaged public var userName: String?
    @NSManaged public var userEmail: String?
    @NSManaged public var userPassword: String?

}
