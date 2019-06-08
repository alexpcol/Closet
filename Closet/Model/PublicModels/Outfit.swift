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
    let name: String
    let clothes: [Clothe]
    
    init(id: URL, name: String?, clothes: NSSet?) {
        self.id = id
        self.name = name ?? ""
        if let result = clothes, result.count > 0 {
            var clothes = [Clothe]()
            for case let item as ClotheDatabase in result {
                clothes.append(Clothe(id: item.objectID.uriRepresentation(),
                                      color: item.color,
                                      piece: item.piece,
                                      style: item.style))
            }
            self.clothes = clothes
        }
        else {
            self.clothes = [Clothe]()
        }
    }
    
    init(id: URL, name: String, clothes: [Clothe]) {
        self.id = id
        self.name = name
        self.clothes = clothes
    }
}
