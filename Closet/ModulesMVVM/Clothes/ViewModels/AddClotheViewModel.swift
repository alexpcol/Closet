//
//  AddClotheViewModel.swift
//  Closet
//
//  Created by chila on 6/20/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class AddClotheViewMothel {

    //TODO:- Cambiar el naming de los propiedades que interactuan con la vista y que sean inidces para trabajar los datos con los arreglos y evitar doble casteo
    var color: Dynamic<String>
    var piece: Dynamic<String>
    var style: Dynamic<String>
    var image: Dynamic<UIImage>
    
    var colors = [UIColor]()
    var pieces: [PieceType]
    var styles: [ClotheStyle]
    private var dressMaker: DressMaker
    
    init() {
        dressMaker = DressMaker(container: UIApplication.container)
        color = Dynamic("")
        piece = Dynamic("")
        style = Dynamic("")
        image = Dynamic(UIImage(named: "clothePlaceholder")!)
        pieces = PieceType.allCases
        styles = ClotheStyle.allCases
        colors.append(UIColor.red)
        colors.append(UIColor.green)
        colors.append(UIColor.blue)
    }
    
    func addImage(_ view: AddClotheViewController,
                  cameraPermissions: CameraAccess,
                  _ completionHandler: @escaping ([UIAlertAction]?) -> Void) {
        cameraPermissions.prepare(inView: view) { (granted) in
            granted ? self.presentSourceImagesOptions(view, completionHandler) : completionHandler(nil)
        }
    }
    
    func addClothe() -> AlertHeaderModel {
        if validateForm() {
            let clothe = Clothe(color: color.value, piece: pieceType(for: piece.value), style: styleType(for: style.value), image: image.value)
            dressMaker.add(clothe)
            return AlertHeaderModel(title: "Closet", message: "¡Ropa añadida!")
        }
        return AlertHeaderModel(title: "Closet", message: "Verifica tu información")
    }
    
    func colorName(_ index: Int) -> String {
        if index < colors.count {
            switch colors[index] {
            case UIColor.red:
                return "Rojo"
            case UIColor.green:
                return "Verde"
            case UIColor.blue:
                return "Azul"
            default:
                return ""
            }
        }
        return ""
    }
    
    func pieceName(for index: Int) -> String {
        if index < pieces.count {
            switch pieces[index] {
            case .top:
                return "Para torso"
            case .trouser:
                return "Para piernas"
            case .footwear:
                return "Para pies"
            }
        }
        return ""
    }
    
    func styleName(for index: Int) -> String {
        if index < styles.count {
            switch styles[index] {
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
        return ""
    }
    
    private func pieceType(for pieceName: String) -> String {
        var piece:PieceType = .top
        switch pieceName {
        case "Para torso":
            piece = .top
        case "Para piernas":
            piece = .trouser
        case "Para pies":
            piece = .footwear
        default:
            piece = .top
        }
        return piece.rawValue
    }
    
    private func styleType(for styleName: String) -> String {
        var style: ClotheStyle = .casual
        switch styleName {
        case "Estilo casual👕":
            style = .casual
        case "Estilo formal 👔":
            style = .formal
        case "Estilo informal🧢":
            style = .informal
        case "Estilo deportivo🎽":
            style = .sport
        default:
            style = .casual
        }
        return style.rawValue
    }
    
    private func validateForm() -> Bool {
        if color.value.isEmpty {
            return false
        }
        if piece.value.isEmpty {
            return false
        }
        if style.value.isEmpty {
            return false
        }
        return true
    }
    
    private func presentSourceImagesOptions(_ view: AddClotheViewController,_ completionHandler: @escaping ([UIAlertAction]) -> Void) {
        let camera = UIAlertAction(title: "Cámara", style: .default) { (alertAction) in
            ActivityPresenter.shared.showImagePickerFromCamera(inView: view)
        }
        
        let library = UIAlertAction(title: "Galería", style: .default) { (alertAction) in
            ActivityPresenter.shared.showImagePickerFromGallery(inView: view)
        }
        
        completionHandler([camera,library])
    }
    
}
