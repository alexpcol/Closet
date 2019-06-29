//
//  OutfitCellModel.swift
//  Closet
//
//  Created by chila on 6/21/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

struct OutfitCellModel {
    let name: String
    
    public func congifure(_ cell: UITableViewCell) {
        cell.textLabel?.text = name
    }
    
}
