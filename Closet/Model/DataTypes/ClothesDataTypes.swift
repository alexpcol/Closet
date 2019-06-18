//
//  ClothesDataTypes.swift
//  Closet
//
//  Created by chila on 5/25/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

enum ClotheStyle: String, CaseIterable {
    case casual = "casualClotheStyle"
    case formal = "formalClotheStyle"
    case informal = "informalClotheStyle"
    case sport = "sportClotheStyle"
    
    static func with(text: String?) -> ClotheStyle {
        guard let styleKey = text else { return .casual }
        return ClotheStyle(rawValue: styleKey) ?? .casual
    }
}

enum PieceType: String, CaseIterable {
    case top = "topPieceType"
    case trouser = "trouserPieceType"
    case footwear = "footwearPieceType"
    
    static func with(text: String?) -> PieceType {
        guard let pieceKey = text else { return .top }
        return PieceType(rawValue: pieceKey) ?? .top
    }
    
    func icon() -> UIImage {
        switch self {
        case .top:
            return UIImage(named: "iconPlaceholder")!
        case .trouser:
            return UIImage(named: "iconPlaceholder")!
        case .footwear:
            return UIImage(named: "iconPlaceholder")!
        }
    }
}
