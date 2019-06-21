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
        
        pickerColor.tag = 1
        pickerPiece.tag = 2
        pickerStyle.tag = 3
        
    }
    
    //MARK:- Actions
    @objc private func addClothe() {
        print("lol")
    }
    @IBAction func textFieldTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            pickerColor.show()
        case 2:
            pickerPiece.show()
        case 3:
            pickerStyle.show()
        default:
            print("default")
        }
    }
    @IBAction func addImageTapped(_ sender: UIButton) {
        
    }
}

//MARK:- PickerView delegate
extension AddClotheViewController: PickerViewDelegate {
    func pickerDataView(pickerView: PickerView, selectedIndex index: Int) {
        switch pickerView.tag {
        case 1:
            switch viewModel?.colors[index] {
            case UIColor.red:
                colorTextField.text = "Red"
            case UIColor.green:
                colorTextField.text = "Green"
            case UIColor.blue:
                colorTextField.text = "Blue"
            default:
                colorTextField.text = ""
            }
        case 2:
            pieceTextField.text = viewModel!.pieces[index].rawValue
        case 3:
            styleTextField.text = viewModel!.styles[index].rawValue
        default:
            break
        }
    }
}

//MARK:- PickerView dataSource
extension AddClotheViewController: PickerViewDataSource {
    
    func numberOfRowsFor(pickerView: PickerView) -> Int {
        switch pickerView.tag {
        case 1:
            return viewModel?.colors.count ?? 0
        case 2:
            return viewModel?.pieces.count ?? 0
        case 3:
            return viewModel?.styles.count ?? 0
        default:
            return 0
        }
    }
    
    func titleFor(pickerView: PickerView, atIndex index: Int) -> String {
        switch pickerView.tag {
        case 1:
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
        case 2:
            return viewModel!.pieces[index].rawValue
        case 3:
            return viewModel!.styles[index].rawValue
        default:
            return ""
        }
    }
}
