//
//  AddClotheViewControllerMVP.swift
//  Closet
//
//  Created by chila on 6/29/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class AddClotheViewControllerMVP: GenericFormVC, AddClotheViewable, Storyboarded {
    @IBOutlet private weak var colorText: UITextField!
    @IBOutlet private weak var pieceText: UITextField!
    @IBOutlet private weak var styleText: UITextField!
    @IBOutlet private weak var clotheImage: UIImageView!
    
    private var pickerOptionsModel: PickerOptionsModel?
    private let picker = PickerView()
    private var presenter: AddClothePresentable!
    private var saveButtonAction:(() -> AlertHeaderModel)!
    
    //MARK:- Viewable Methods
    func showSaveButton(action: @escaping () -> AlertHeaderModel) {
        saveButtonAction = action
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapSaveButton))
        navigationItem.rightBarButtonItems = [addButtonItem]
    }
    
    func show(clotheImage: UIImage) {
        self.clotheImage.image = clotheImage
    }
    
    func showClothe(property: ClotheProperties, withText text: String) {
        switch property {
        case .color:
            colorText.text = text
        case .piece:
            pieceText.text = text
        case .style:
            styleText.text = text
        }
    }
    
    func showPicker(withModel model: PickerOptionsModel) {
        pickerOptionsModel = model
        picker.show()
    }
    
    func setup(title: String, presenter: AddClothePresentable) {
        self.title = title
        self.presenter = presenter
        picker.delegate = self
        picker.dataSource = self
    }
    
    func closeView() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Actions
    @IBAction private func didSelectColor(_ sender: UIButton) {
        presenter.startEditing(property: .color)
    }
    
    @IBAction private func didSelectPiece(_ sender: UIButton) {
        presenter.startEditing(property: .piece)
    }
    
    @IBAction private func didSelectStyle(_ sender: UIButton) {
        presenter.startEditing(property: .style)
    }
    
    @IBAction func didTapAddImage(_ sender: UIButton) {
        presenter.prepareMediaOptions(in: self, withCameraPersmissions: Camera.shared) { (actions) in
            guard let actions = actions else { return }
            AlertsPresenter.shared.showActionSheet(actions: actions, title: "Media", message: nil, inView: self)
        }
    }
    
    @objc private func didTapSaveButton() {
        let resultModel = saveButtonAction()
        if let actionTitle = resultModel.alertAction, let completion = resultModel.action {
            AlertsPresenter.shared.showAlertWithAction(alertTitle: resultModel.title, alertMessage: resultModel.message, actionTitle: actionTitle.rawValue, actionStyle: .default, inView: self, completion: completion)
        } else {
            AlertsPresenter.shared.showOKAlert(title: resultModel.title, message: resultModel.message, inView: self)
        }
        
    }
}

//MARK:- PickerView delegate
extension AddClotheViewControllerMVP: PickerViewDelegate {
    func pickerDataView(pickerView: PickerView, selectedIndex index: Int) {
        pickerOptionsModel?.didSelectOptionIndex(index)
    }
}
//MARK:- PickerView dataSource
extension AddClotheViewControllerMVP: PickerViewDataSource {
    func titleFor(pickerView: PickerView, atIndex index: Int) -> String {
        return pickerOptionsModel?.options[index] ?? ""
    }
    
    func numberOfRowsFor(pickerView: PickerView) -> Int {
        return pickerOptionsModel?.options.count ?? 0
    }
}
//MARK:- PUIImagePickerControllerDelegate
extension AddClotheViewControllerMVP : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        presenter.didSelect(image: info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        self.dismiss(animated: true, completion: nil)
    }
}
