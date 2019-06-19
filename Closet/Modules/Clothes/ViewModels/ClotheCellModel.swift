//
//  ClotheCellViewModel.swift
//  Closet
//
//  Created by chila on 6/15/19.
//  Copyright © 2019 chila. All rights reserved.
//

import Foundation
import UIKit

struct ClotheCellModel {
    
    let typeIcon: UIImage
    let preview: UIImage
    let name: String
    
    public func congifure(_ cell: ClotheCell) {
        cell.preview.image = preview
        cell.typeIcon.image = typeIcon
    }
    
}
