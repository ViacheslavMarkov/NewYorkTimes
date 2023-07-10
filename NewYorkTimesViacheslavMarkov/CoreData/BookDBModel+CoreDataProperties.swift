//
//  BookDBModel+CoreDataProperties.swift
//  NYUtilities
//
//  Created by Viacheslav Markov on 10.07.2023.
//
//

import Foundation
import CoreData


extension BookDBModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookDBModel> {
        return NSFetchRequest<BookDBModel>(entityName: "BookDBModel")
    }

    @NSManaged public var author: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var imageUrlString: String?
    @NSManaged public var publisher: String?
    @NSManaged public var rank: Int16
    @NSManaged public var bookId: String?
    @NSManaged public var parentId: String?
    @NSManaged public var links: NSSet?

}

// MARK: Generated accessors for links
public extension BookDBModel {

    @objc(addLinksObject:)
    @NSManaged func addToLinks(_ value: BuyLinksDBModel)

    @objc(removeLinksObject:)
    @NSManaged func removeFromLinks(_ value: BuyLinksDBModel)

    @objc(addLinks:)
    @NSManaged func addToLinks(_ values: NSSet)

    @objc(removeLinks:)
    @NSManaged func removeFromLinks(_ values: NSSet)

}

extension BookDBModel : Identifiable {

}
