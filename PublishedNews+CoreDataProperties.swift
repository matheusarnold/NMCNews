//
//  PublishedNews+CoreDataProperties.swift
//  arrayNMCNews
//
//  Created by Laurentia Audrey on 15/12/20.
//  Copyright © 2020 Matheus. All rights reserved.
//
//

import Foundation
import CoreData


extension PublishedNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PublishedNews> {
        return NSFetchRequest<PublishedNews>(entityName: "PublishedNews")
    }

    @NSManaged public var newsAuthor: String?
    @NSManaged public var newsCategory: String?
    @NSManaged public var newsContent: String?
    @NSManaged public var newsDate: String?
    @NSManaged public var newsId: String?
    @NSManaged public var newsImage: String?
    @NSManaged public var newsTitle: String?
    @NSManaged public var newsStatus: String?

}
