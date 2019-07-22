//
//  Clothe.swift
//  Closet
//
//  Created by chila on 5/25/19.
//  Copyright © 2019 chila. All rights reserved.
//

import Foundation
import UIKit

enum ClotheProperties {
    case color
    case piece
    case style
}

struct Clothe: Hashable {
    let id: URL
    var color: UIColor
    var piece: PieceType
    var style: ClotheStyle
    var image: UIImage
    
    
    //Normal
    init(id: URL = URL(fileURLWithPath: ""), color: UIColor, piece: PieceType, style: ClotheStyle, image: UIImage) {
        self.id = id
        self.color = color
        self.piece = piece
        self.style = style
        self.image = image
    }
    //Database
    init(id: URL, color: NSObject?, piece: String?, style: String?, image: NSData) {
        self.id = id
        self.color = color as! UIColor
        self.piece = PieceType.with(text: piece)
        self.style = ClotheStyle.with(text: style)
        if let data = image as Data?{
            self.image = UIImage(data: data)!
        }
        else {
            self.image = UIImage(named: "clothePlaceholder")!
        }
    }
    //Views
    init(id: URL = URL(fileURLWithPath: ""), color: String, piece: String, style: String, image: UIImage) {
        self.id = id
        switch color {
        case "Red":
            self.color = UIColor.red
        case "Green":
            self.color = UIColor.green
        case "Blue":
            self.color = UIColor.blue
        default:
            self.color = UIColor.black
        }
        self.piece = PieceType.with(text: piece)
        self.style = ClotheStyle.with(text: style)
        self.image = image
    }
    
    // Static class for the creation of a ClotheDatabase object
    static func clotheForDressMakerAdd(color: UIColor, piece: PieceType, style: ClotheStyle, image: UIImage) -> Clothe {
       return  Clothe(id: URL(fileURLWithPath: ""), color: color, piece: piece, style: style, image: image)
    }
    
}
