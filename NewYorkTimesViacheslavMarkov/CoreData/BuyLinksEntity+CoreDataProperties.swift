//
//  BuyLinksEntity+CoreDataProperties.swift
//  NewYorkTimesViacheslavMarkov
//
//  Created by Viacheslav Markov on 12.07.2023.
//
//

import Foundation
import CoreData


extension BuyLinksEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BuyLinksEntity> {
        return NSFetchRequest<BuyLinksEntity>(entityName: "BuyLinksEntity")
    }

    @NSManaged public var linkId: String?
    @NSManaged public var name: String?
    @NSManaged public var parentId: String?
    @NSManaged public var url: String?

}

extension BuyLinksEntity : Identifiable {

}
