//
//  AddClothePresenter.swift
//  Closet
//
//  Created by chila on 6/29/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class AddClothePresenter: AddClothePresentable {
    private weak var view: AddClotheViewable?
    private var router: ClothesRouter!
    private var colorSelected: UIColor?
    private var pieceSelected: PieceType?
    private var styleSelected: ClotheStyle?
    private var imageSelected: UIImage?
    private var colors = [UIColor]()
    private let pieces: [PieceType] = PieceType.allCases
    private let styles: [ClotheStyle] = ClotheStyle.allCases
    private var dressMaker: DressmakerEditable
    
    init(withDressMaker dressMaker: DressmakerEditable, router: ClothesRouter) {
        colors.append(UIColor.red)
        colors.append(UIColor.green)
        colors.append(UIColor.blue)
        self.dressMaker = dressMaker
        self.router = router
    }
    
    func attach(view: AddClotheViewable) {
        self.view = view
        self.view?.setup(title: "Nueva", presenter: self as AddClothePresentable)
        self.view?.showSaveButton(action: {
            self.saveClothe()
        })
    }
    
    func startEditing(property: ClotheProperties) {
        var options = [String]()
        var handler: (Int) -> Void
        switch property {
        case .color:
            options = colorNames()
            handler = { (index) in
                self.colorSelected = self.colors[index]
                self.view?.showClothe(property: property, withText: options[index])
            }
        case .piece:
            options = piecesNames()
            handler = { (index) in
                self.pieceSelected = self.pieces[index]
                self.view?.showClothe(property: property, withText: options[index])
            }
        case .style:
            options = stylesNames()
            handler = { (index) in
                self.styleSelected = self.styles[index]
                self.view?.showClothe(property: property, withText: options[index])
            }
        }
        
        view?.showPicker(withModel: PickerOptionsModel(options: options, didSelectOptionIndex: handler))
    }
    
    func prepareMediaOptions(in view: UIViewController,
                          withCameraPersmissions cameraPermissions: CameraAccess,
                          _ completionHandler: @escaping ([UIAlertAction]?) -> Void) {
        
        cameraPermissions.prepare(inView: view) { (granted) in
            granted ? self.presentSourceImagesOptions(view, completionHandler) : completionHandler(nil)
        }
    }
    
    func didSelect(image: UIImage) {
        imageSelected = image
        view?.show(clotheImage: image)
    }
    
    private func validateForm() -> Bool {
        if colorSelected == nil {
            return false
        }
        if pieceSelected == nil {
            return false
        }
        if styleSelected == nil {
            return false
        }
        if imageSelected == nil {
            return false
        }
        return true
    }
    
    private func presentSourceImagesOptions(_ view: UIViewController,_ completionHandler: @escaping ([UIAlertAction]) -> Void) {
        let viewController = view as! AddClotheViewControllerMVP
        let camera = UIAlertAction(title: "Cámara", style: .default) { (alertAction) in
            ActivityPresenter.shared.showImagePickerFromCamera(inView: viewController)
        }
        
        let library = UIAlertAction(title: "Galería", style: .default) { (alertAction) in
            ActivityPresenter.shared.showImagePickerFromGallery(inView: viewController)
        }
        completionHandler([camera,library])
    }
    
    private func colorNames() -> [String] {
        let colorNames = colors.map { (color) -> String in
            switch color {
            case .red:
                return "Rojo"
            case .green:
                return "Verde"
            case .blue:
                return "Azul"
            default:
                return "Color"
            }
        }
        return colorNames
    }
    
    private func piecesNames() -> [String] {
        let piecesNames = pieces.map { (piece) -> String in
            switch piece {
            case .top:
                return "Para torso"
            case .trouser:
                return "Para piernas"
            case .footwear:
                return "Para pies"
            }
        }
        return piecesNames
    }
    
    private func stylesNames() -> [String] {
        let stylesNames = styles.map { (style) -> String in
            switch style {
            case .casual:
                return "Estilo casual👕"
            case .formal:
                return "Estilo formal 👔"
            case .informal:
                return "Estilo informal🧢"
            case .sport:
                return "Estilo deportivo🎽"
            }
        }
        return stylesNames
    }
    private func saveClothe() -> AlertHeaderModel {
        if validateForm() {
            let clothe = Clothe(color: colorSelected!, piece: pieceSelected!, style: styleSelected!, image: imageSelected!)
            dressMaker.add([clothe])
            return AlertHeaderModel(title: "Closet", message: "¡Ropa añadida!", alertAction: .ok) {
                self.router.returnToPreviousView()
            }
        }
        return AlertHeaderModel(title: "Closet", message: "Verifica tu información")
    }
}
