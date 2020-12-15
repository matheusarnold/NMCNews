//
//  BookmarkedNews+CoreDataProperties.swift
//  arrayNMCNews
//
//  Created by Laurentia Audrey on 15/12/20.
//  Copyright © 2020 Matheus. All rights reserved.
//
//

import Foundation
import CoreData


extension BookmarkedNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookmarkedNews> {
        return NSFetchRequest<BookmarkedNews>(entityName: "BookmarkedNews")
    }

    @NSManaged public var bookmarkNewsTitle: String?
    @NSManaged public var bookmarkNewsId: String?
    @NSManaged public var bookmarkNewsContent: String?
    @NSManaged public var bookmarkNewsImage: String?
    @NSManaged public var bookmarkNewsAuthor: String?
    @NSManaged public var bookmarkNewsDate: String?
    @NSManaged public var bookmarkNewsStatus: String?
    @NSManaged public var bookmarkNewsCategory: String?

}
