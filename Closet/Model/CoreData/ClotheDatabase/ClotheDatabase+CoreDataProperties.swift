//
//  ClotheDatabase+CoreDataProperties.swift
//  Closet
//
//  Created by chila on 6/12/19.
//  Copyright © 2019 chila. All rights reserved.
//
//

import Foundation
import CoreData


extension ClotheDatabase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClotheDatabase> {
        return NSFetchRequest<ClotheDatabase>(entityName: "ClotheDatabase")
    }

    @NSManaged public var color: NSObject
    @NSManaged public var piece: String
    @NSManaged public var style: String
    @NSManaged public var outfit: NSSet?

}

// MARK: Generated accessors for outfit
extension ClotheDatabase {

    @objc(addOutfitObject:)
    @NSManaged public func addToOutfit(_ value: OutfitDatabase)

    @objc(removeOutfitObject:)
    @NSManaged public func removeFromOutfit(_ value: OutfitDatabase)

    @objc(addOutfit:)
    @NSManaged public func addToOutfit(_ values: NSSet)

    @objc(removeOutfit:)
    @NSManaged public func removeFromOutfit(_ values: NSSet)

}
