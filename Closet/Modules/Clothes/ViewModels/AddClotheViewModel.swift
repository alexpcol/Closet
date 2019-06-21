//
//  AddClotheViewModel.swift
//  Closet
//
//  Created by chila on 6/20/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class AddClotheViewMothel {
    private var dressMaker: DressMaker
    var colors = [UIColor]()
    var pieces: [PieceType]
    var styles: [ClotheStyle]
    
    init() {
        dressMaker = DressMaker(container: UIApplication.container)
        pieces = PieceType.allCases
        styles = ClotheStyle.allCases
        colors.append(UIColor.red)
        colors.append(UIColor.green)
        colors.append(UIColor.blue)
    }
    
    func addClothe() {
        dressMaker.add(Clothe.clotheForDressMakerAdd(color: .red,
                                                     piece: .top,
                                                     style: .informal,
                                                     image: UIImage(named: "bear")!))
    }
    
}
