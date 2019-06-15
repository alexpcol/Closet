//
//  OutfitDatabase+CoreDataProperties.swift
//  Closet
//
//  Created by chila on 6/12/19.
//  Copyright © 2019 chila. All rights reserved.
//
//

import Foundation
import CoreData


extension OutfitDatabase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OutfitDatabase> {
        return NSFetchRequest<OutfitDatabase>(entityName: "OutfitDatabase")
    }

    @NSManaged public var name: String?
    @NSManaged public var clothes: NSSet

}

// MARK: Generated accessors for clothes
extension OutfitDatabase {

    @objc(addClothesObject:)
    @NSManaged public func addToClothes(_ value: ClotheDatabase)

    @objc(removeClothesObject:)
    @NSManaged public func removeFromClothes(_ value: ClotheDatabase)

    @objc(addClothes:)
    @NSManaged public func addToClothes(_ values: NSSet)

    @objc(removeClothes:)
    @NSManaged public func removeFromClothes(_ values: NSSet)

}
