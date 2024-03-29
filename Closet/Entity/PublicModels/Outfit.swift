//
//  Outfit.swift
//  Closet
//
//  Created by chila on 6/2/19.
//  Copyright © 2019 chila. All rights reserved.
//

import Foundation
import UIKit

struct Outfit {
    let id: URL
    var name: String
    var clothes: [Clothe]
    
    //Normal
    init(id: URL = URL(fileURLWithPath: ""), name: String, clothes: [Clothe]) {
        self.id = id
        self.name = name
        self.clothes = clothes
    }
    
    //Database
    init(id: URL, name: String?, clothes: NSSet?) {
        self.id = id
        self.name = name ?? ""
        if let result = clothes, result.count > 0 {
            let clothes = result.map { (item) -> Clothe in
                let clotheItem = item as! ClotheDatabase
                return Clothe(id: clotheItem.objectID.uriRepresentation(),
                              color: clotheItem.color,
                              piece: clotheItem.piece,
                              style: clotheItem.style,
                              image: clotheItem.image)
            }
            self.clothes = clothes
        }
        else {
            self.clothes = [Clothe]()
        }
    }

    // Static class for the creation of a ClotheDatabase object
    static func outfitForFashionMakerAdd(name: String, clothes: [Clothe]) -> Outfit {
        return Outfit(id: URL(fileURLWithPath: ""), name: name, clothes: clothes)
    }
}
