//
//  AddClotheViewController.swift
//  Closet
//
//  Created by chila on 6/20/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class AddClotheViewController: GenericFormVC, Storyboarded {
    
    private var pickerColor = PickerView()
    private var pickerPiece = PickerView()
    private var pickerStyle = PickerView()
    private var viewModel: AddClotheViewMothel?
    @IBOutlet private weak var colorTextField: UITextField!
    @IBOutlet private weak var pieceTextField: UITextField!
    @IBOutlet private weak var styleTextField: UITextField!
    @IBOutlet private weak var mainImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupView(viewModel: AddClotheViewMothel) {
        // Configuración inicial al momento de crear la instnacia
        self.viewModel = viewModel
    }
    
    private func initialize() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addClothe))
        navigationItem.rightBarButtonItems = [addButtonItem]
        pickerColor.delegate = self
        pickerColor.dataSource = self
        pickerPiece.delegate = self
        pickerPiece.dataSource = self
        pickerStyle.delegate = self
        pickerStyle.dataSource = self
        setTags()
        subscribeNotifications()
        setViewModelProperties()
    }
    
    private func setTags() {
        pickerColor.tag = FormTags.pickerAddClotheColor.rawValue
        pickerPiece.tag = FormTags.pickerAddClothePiece.rawValue
        pickerStyle.tag = FormTags.pickerAddClotheStyle.rawValue
    }
    
    private func subscribeNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didReceiveNotification(_:)),
                                               name: .cameraShowItAgain,
                                               object: nil)
    }
    
    private func setViewModelProperties() {
        viewModel?.color.bindAndFire({ [unowned self] in
            self.colorTextField.text = $0
        })
        viewModel?.piece.bindAndFire({ [unowned self] in
            self.pieceTextField.text = $0
        })
        viewModel?.style.bindAndFire({ [unowned self] in
            self.styleTextField.text = $0
        })
    }
    
    //MARK:- Actions
    @objc private func addClothe() {
        print("lol")
    }
    
    @objc private func didReceiveNotification(_ notification: Notification) {
        guard let showCamera = notification.userInfo?["showCamera"] as? Bool else { return }
        if showCamera {
            viewModel?.addImage(self)
        }
    }
    
    @IBAction func textFieldTapped(_ sender: UIButton) {
        switch sender.tag {
        case FormTags.buttonAddClotheColor.rawValue:
            pickerColor.show()
        case FormTags.buttonAddClothePiece.rawValue:
            pickerPiece.show()
        case FormTags.buttonAddClotheStyle.rawValue:
            pickerStyle.show()
        default:
            print("default")
        }
    }
    @IBAction func addImageTapped(_ sender: UIButton) {
        viewModel?.addImage(self)
    }
}

//MARK:- PickerView delegate
extension AddClotheViewController: PickerViewDelegate {
    func pickerDataView(pickerView: PickerView, selectedIndex index: Int) {
        switch pickerView.tag {
        case FormTags.pickerAddClotheColor.rawValue:
            switch viewModel?.colors[index] {
            case UIColor.red:
                viewModel?.color.value = "Red"
            case UIColor.green:
                viewModel?.color.value = "Green"
            case UIColor.blue:
                viewModel?.color.value = "Blue"
            default:
                viewModel?.color.value = ""
            }
        case FormTags.pickerAddClothePiece.rawValue:
            viewModel?.piece.value = viewModel!.pieces[index].rawValue
        case FormTags.pickerAddClotheStyle.rawValue:
            viewModel?.style.value = viewModel!.styles[index].rawValue
        default:
            break
        }
    }
}

//MARK:- PickerView dataSource
extension AddClotheViewController: PickerViewDataSource {
    
    func numberOfRowsFor(pickerView: PickerView) -> Int {
        switch pickerView.tag {
        case FormTags.pickerAddClotheColor.rawValue:
            return viewModel?.colors.count ?? 0
        case FormTags.pickerAddClothePiece.rawValue:
            return viewModel?.pieces.count ?? 0
        case FormTags.pickerAddClotheStyle.rawValue:
            return viewModel?.styles.count ?? 0
        default:
            return 0
        }
    }
    
    func titleFor(pickerView: PickerView, atIndex index: Int) -> String {
        switch pickerView.tag {
        case FormTags.pickerAddClotheColor.rawValue:
            switch viewModel?.colors[index] {
            case UIColor.red:
                return "Red"
            case UIColor.green:
                return "Green"
            case UIColor.blue:
                return "Blue"
            default:
                return ""
            }
        case FormTags.pickerAddClothePiece.rawValue:
            return viewModel!.pieces[index].rawValue
        case FormTags.pickerAddClotheStyle.rawValue:
            return viewModel!.styles[index].rawValue
        default:
            return ""
        }
    }
}

//MARK:- PUIImagePickerControllerDelegate
extension AddClotheViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        mainImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}
