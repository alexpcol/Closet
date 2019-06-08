//
//  Clothe.swift
//  Closet
//
//  Created by chila on 5/25/19.
//  Copyright © 2019 chila. All rights reserved.
//

import Foundation
import UIKit

struct Clothe: Hashable {
    let id: URL
    let color: UIColor
    let piece: PieceType
    let style: ClotheStyle
    
    init(id: URL, color: NSObject?, piece: String?, style: String?) {
        self.id = id
        self.color = color as! UIColor
        self.piece = PieceType.with(text: piece)
        self.style = ClotheStyle.with(text: style)
    }
    
    init(id: URL, color: UIColor, piece: PieceType, style: ClotheStyle) {
        self.id = id
        self.color = color
        self.piece = piece
        self.style = style
    }
    // Static class for the creation of a ClotheDatabase object
    static func clotheForDressMakerAdd(color: UIColor, piece: PieceType, style: ClotheStyle) -> Clothe {
       return  Clothe(id: URL(fileURLWithPath: ""), color: color, piece: piece, style: style)
    }
    
}
