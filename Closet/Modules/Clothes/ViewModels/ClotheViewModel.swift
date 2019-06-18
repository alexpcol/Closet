//
//  ClotheViewModel.swift
//  Closet
//
//  Created by chila on 6/15/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class ClotheViewModel {
    //TODO: Subscribirme a la notificación de se modifico la base de datos, al recibirla actualizar el arreglo de clothes y recargar la vista por medio de un delegado
    var clothes: [Clothe]  {
        get {
            if _clothes == nil {
                refreshFromDatabase()
            }
            return _clothes!
        }
    }
    
    var clotheCellModel: [ClotheCellModel]  {
        get {
            return clothes.map({ (clothe: Clothe) -> ClotheCellModel in
                //TODO: Obtener de base de datos el preview
                ClotheCellModel(typeIcon: clothe.piece.icon(), preview: clothe.piece.icon(), name: clothe.style.rawValue)
            })
        }
    }
    
    private var dressMaker: DressMaker
    private var _clothes: [Clothe]?
    init() {
        dressMaker = DressMaker(container: UIApplication.container)
    }
    
    func refreshFromDatabase()  {
        _clothes = dressMaker.fetchAllClothes() ?? [Clothe]()
    }
    
    func dumbAddClothe() {
        dressMaker.add(Clothe.clotheForDressMakerAdd(color: .red, piece: .top, style: .informal))
    }
    
}
