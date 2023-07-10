//
//  OverviewDBModel+CoreDataProperties.swift
//  NYUtilities
//
//  Created by Viacheslav Markov on 10.07.2023.
//
//

import Foundation
import CoreData


extension OverviewDBModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OverviewDBModel> {
        return NSFetchRequest<OverviewDBModel>(entityName: "OverviewDBModel")
    }

    @NSManaged public var publishedDate: String?
    @NSManaged public var list: NSSet?

}

// MARK: Generated accessors for list
public extension OverviewDBModel {

    @objc(addListObject:)
    @NSManaged func addToList(_ value: OverviewDescriptionDBModel)

    @objc(removeListObject:)
    @NSManaged func removeFromList(_ value: OverviewDescriptionDBModel)

    @objc(addList:)
    @NSManaged func addToList(_ values: NSSet)

    @objc(removeList:)
    @NSManaged func removeFromList(_ values: NSSet)

}

extension OverviewDBModel : Identifiable {

}
