//
//  DescriptionEntity+CoreDataProperties.swift
//  NewYorkTimesViacheslavMarkov
//
//  Created by Viacheslav Markov on 12.07.2023.
//
//

import Foundation
import CoreData


extension DescriptionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DescriptionEntity> {
        return NSFetchRequest<DescriptionEntity>(entityName: "DescriptionEntity")
    }

    @NSManaged public var displayName: String?
    @NSManaged public var listId: Int16
    @NSManaged public var books: NSSet?

}

// MARK: Generated accessors for books
extension DescriptionEntity {

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: BookEntity)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: BookEntity)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSSet)

}

extension DescriptionEntity : Identifiable {

}
