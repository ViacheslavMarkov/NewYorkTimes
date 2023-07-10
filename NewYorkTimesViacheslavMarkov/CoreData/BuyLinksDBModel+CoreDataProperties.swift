//
//  BuyLinksDBModel+CoreDataProperties.swift
//  NYUtilities
//
//  Created by Viacheslav Markov on 10.07.2023.
//
//

import Foundation
import CoreData


extension BuyLinksDBModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BuyLinksDBModel> {
        return NSFetchRequest<BuyLinksDBModel>(entityName: "BuyLinksDBModel")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var linkId: String?
    @NSManaged public var parentId: String?

}

extension BuyLinksDBModel : Identifiable {

}
