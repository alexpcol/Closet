//
//  AddClotheViewModel.swift
//  Closet
//
//  Created by chila on 6/20/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class AddClotheViewMothel {

    var color: Dynamic<String>
    var piece: Dynamic<String>
    var style: Dynamic<String>
    var image: Dynamic<UIImage>?
    
    var colors = [UIColor]()
    var pieces: [PieceType]
    var styles: [ClotheStyle]
    private var dressMaker: DressMaker
    
    init() {
        dressMaker = DressMaker(container: UIApplication.container)
        color = Dynamic("")
        piece = Dynamic("")
        style = Dynamic("")
        pieces = PieceType.allCases
        styles = ClotheStyle.allCases
        colors.append(UIColor.red)
        colors.append(UIColor.green)
        colors.append(UIColor.blue)
    }
    
    
    func addImage(_ view: AddClotheViewController) {
        if Camera.shared.prepare(inView: view) {
            presentSourceImagesOptions(view)
        }
    }
    
    func addClothe(_ view: AddClotheViewController) -> Bool {
        dressMaker.add(Clothe.clotheForDressMakerAdd(color: .red,
                                                     piece: .top,
                                                     style: .informal,
                                                     image: UIImage(named: "bear")!))
        return true
    }
    
    private func validateForm() -> Bool {
        if color.value.isEmpty {
            return false
        }
        if piece.value.isEmpty {
            return false
        }
        return true
    }
    
    private func presentSourceImagesOptions(_ view: AddClotheViewController) {
        let camera = UIAlertAction(title: "Camera", style: .default) { (alertAction) in
            ActivityPresenter.shared.showImagePickerFromCamera(inView: view)
        }
        
        let library = UIAlertAction(title: "Library", style: .default) { (alertAction) in
            ActivityPresenter.shared.showImagePickerFromGallery(inView: view)
        }
        
        AlertsPresenter.shared.showActionSheet(actions: [camera, library], title: "Hola", message: nil, inView: view)
    }
}
