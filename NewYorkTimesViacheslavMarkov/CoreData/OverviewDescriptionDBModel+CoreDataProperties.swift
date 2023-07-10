//
//  OverviewDescriptionDBModel+CoreDataProperties.swift
//  NYUtilities
//
//  Created by Viacheslav Markov on 10.07.2023.
//
//

import Foundation
import CoreData


extension OverviewDescriptionDBModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OverviewDescriptionDBModel> {
        return NSFetchRequest<OverviewDescriptionDBModel>(entityName: "OverviewDescriptionDBModel")
    }

    @NSManaged public var displayName: String?
    @NSManaged public var listId: Int16
    @NSManaged public var books: NSSet?

}

// MARK: Generated accessors for books
public extension OverviewDescriptionDBModel {

    @objc(addBooksObject:)
    @NSManaged func addToBooks(_ value: BookDBModel)

    @objc(removeBooksObject:)
    @NSManaged func removeFromBooks(_ value: BookDBModel)

    @objc(addBooks:)
    @NSManaged func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged func removeFromBooks(_ values: NSSet)

}

extension OverviewDescriptionDBModel : Identifiable {

}
