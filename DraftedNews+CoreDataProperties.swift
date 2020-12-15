//
//  DraftedNews+CoreDataProperties.swift
//  arrayNMCNews
//
//  Created by Laurentia Audrey on 15/12/20.
//  Copyright © 2020 Matheus. All rights reserved.
//
//

import Foundation
import CoreData


extension DraftedNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DraftedNews> {
        return NSFetchRequest<DraftedNews>(entityName: "DraftedNews")
    }

    @NSManaged public var draftNewsId: String?
    @NSManaged public var draftNewsTitle: String?
    @NSManaged public var draftNewsContent: String?
    @NSManaged public var draftNewsCategory: String?
    @NSManaged public var draftNewsDate: String?
    @NSManaged public var draftNewsAuthor: String?
    @NSManaged public var draftNewsStatus: String?
    @NSManaged public var draftNewsImage: String?

}
