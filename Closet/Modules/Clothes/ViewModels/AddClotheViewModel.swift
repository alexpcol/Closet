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
    
    
    func addImage(_ view: AddClotheViewController) {
        if Camera.shared.prepare(inView: view) {
            presentSourceImagesOptions(view)
        }
    }
    
    func addClothe(_ view: AddClotheViewController) {
        dressMaker.add(Clothe.clotheForDressMakerAdd(color: .red,
                                                     piece: .top,
                                                     style: .informal,
                                                     image: UIImage(named: "bear")!))
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
