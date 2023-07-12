//
//  OverviewEntity+CoreDataProperties.swift
//  NewYorkTimesViacheslavMarkov
//
//  Created by Viacheslav Markov on 12.07.2023.
//
//

import Foundation
import CoreData


extension OverviewEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OverviewEntity> {
        return NSFetchRequest<OverviewEntity>(entityName: "OverviewEntity")
    }

    @NSManaged public var publishedDate: String?
    @NSManaged public var list: NSSet?

}

// MARK: Generated accessors for list
extension OverviewEntity {

    @objc(addListObject:)
    @NSManaged public func addToList(_ value: DescriptionEntity)

    @objc(removeListObject:)
    @NSManaged public func removeFromList(_ value: DescriptionEntity)

    @objc(addList:)
    @NSManaged public func addToList(_ values: NSSet)

    @objc(removeList:)
    @NSManaged public func removeFromList(_ values: NSSet)

}

extension OverviewEntity : Identifiable {

}
