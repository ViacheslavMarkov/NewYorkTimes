//
//  BookEntity+CoreDataProperties.swift
//  NewYorkTimesViacheslavMarkov
//
//  Created by Viacheslav Markov on 12.07.2023.
//
//

import Foundation
import CoreData


public extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var author: String?
    @NSManaged public var bookId: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var imageUrlString: String?
    @NSManaged public var parentId: String?
    @NSManaged public var publisher: String?
    @NSManaged public var rank: Int16
    @NSManaged public var links: NSSet?

}

// MARK: Generated accessors for links
extension BookEntity {

    @objc(addLinksObject:)
    @NSManaged public func addToLinks(_ value: BuyLinksEntity)

    @objc(removeLinksObject:)
    @NSManaged public func removeFromLinks(_ value: BuyLinksEntity)

    @objc(addLinks:)
    @NSManaged public func addToLinks(_ values: NSSet)

    @objc(removeLinks:)
    @NSManaged public func removeFromLinks(_ values: NSSet)

}

extension BookEntity : Identifiable {

}
