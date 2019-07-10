//
//  ClothesProtocols.swift
//  Closet
//
//  Created by chila on 6/29/19.
//  Copyright © 2019 chila. All rights reserved.
//
import UIKit

//MARK:- Clothes
protocol ClothePresentable {
    func fetchClothes()
}

protocol ClotheViewable: class {
    func showAddButton(action: @escaping () -> Void)
    func setup(title: String, presenter: ClothePresentable)
    func setSection(icon: String, title: String)
    func show(clothes:[Clothe])
}

//MARK:- AddClothes
protocol AddClothePresentable {
    func startEditing(property: ClotheProperties)
    func prepareMediaOptions(in view: UIViewController,
                          withCameraPersmissions cameraPermissions: CameraAccess,
                          _ completionHandler: @escaping ([UIAlertAction]?) -> Void)
    func didSelect(image:UIImage)
}

protocol AddClotheViewable: class {
    func showSaveButton(action: @escaping () -> AlertHeaderModel)
    func setup(title: String, presenter: AddClothePresentable)
    func show(clotheImage: UIImage)
    func showClothe(property: ClotheProperties,withText text: String)
    func showPicker(withModel model: PickerOptionsModel)
}

struct PickerOptionsModel {
    var options: [String]
    var didSelectOptionIndex: (Int) -> Void
    
}
