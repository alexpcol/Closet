//
//  PickerView.swift
//  Closet
//
//  Created by chila on 6/20/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

//MARK:- PickerViewDelegate
@objc protocol PickerViewDelegate {
    func pickerDataView(pickerView: PickerView, selectedIndex index: Int)
    @objc optional func shouldPickerBeginEditing(_ pickerView: PickerView) -> Bool
    @objc optional func pickerDataViewNoItems(_ pickerView: PickerView)
    @objc optional func onPickerDataViewBeginEditing(_ pickerView: PickerView)
}
//MARK:- PickerDataSource
protocol  PickerViewDataSource {
    func titleFor(pickerView: PickerView, atIndex index: Int) -> String
    func numberOfRowsFor(pickerView: PickerView) -> Int
}

class PickerView: UIView {
    var selectedIndex: Dynamic<Int> = Dynamic(0)
    var items: [String]?
    var delegate: PickerViewDelegate?
    var dataSource: PickerViewDataSource?
    
    private var picker: UIPickerView!
    private var toolBar: UIToolbar!
    private var backgroundView: UIView!
    private struct Keys {
        static let pickerHeight = CGFloat(150)
        static let toolbarHeight = CGFloat(40)
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    init(items: [String]) {
        super.init(frame: .zero)
        self.items = items
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Functions
    func show() {
        if let shouldContinue = delegate?.shouldPickerBeginEditing?(self) {
            if !shouldContinue {return}
        }
        
        self.delegate?.onPickerDataViewBeginEditing?(self)
        
        let screenSize = UIScreen.main.bounds.size
        let window: UIWindow = (UIApplication.shared.delegate?.window!)!
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.destroyPicker))
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.0
        backgroundView.addGestureRecognizer(tapGesture)
        
        let pickerFrame = CGRect(x: 0,
                                 y: screenSize.height,
                                 width: screenSize.width,
                                 height: Keys.pickerHeight)
        picker = UIPickerView(frame: pickerFrame)
        picker.backgroundColor = UIColor.white
        picker.alpha = 1
        picker.delegate = self
        picker.dataSource = self
        
        let btnAcept = UIBarButtonItem(title:"   ".appending("OK"),
                                       style: UIBarButtonItem.Style.done,
                                       target: self,
                                       action: #selector(self.selectItem))
        let toolbarFrame = CGRect(x: 0,
                                  y: screenSize.height,
                                  width: screenSize.width,
                                  height: Keys.toolbarHeight)
        
        toolBar = UIToolbar(frame: toolbarFrame)
        toolBar.tintColor = UIColor.blue
        toolBar.setItems([btnAcept], animated: true)
        
        window.addSubview(backgroundView)
        window.addSubview(toolBar)
        window.addSubview(picker)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundView.alpha = 0.5
            self.toolBar.frame.origin.y = screenSize.height - (Keys.toolbarHeight + Keys.pickerHeight)
            self.picker.frame.origin.y = screenSize.height - Keys.pickerHeight
        })
    }
    
    @objc func selectItem(){
        selectedIndex.value = picker.selectedRow(inComponent: 0)
        backgroundView.removeFromSuperview()
        backgroundView = nil
        picker.removeFromSuperview()
        picker = nil
        toolBar.removeFromSuperview()
        toolBar = nil
        delegate?.pickerDataView(pickerView: self, selectedIndex: selectedIndex.value)
    }
    
    @objc func destroyPicker(){
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
            self.backgroundView.alpha = 0
        }, completion: { (finished) in
            self.backgroundView = nil
        })
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
            let screenSize = UIScreen.main.bounds.size
            self.picker.frame.origin.y = screenSize.height
            self.toolBar.frame.origin.y = screenSize.height
        }, completion: { [weak self] finished in
            self?.removeFromSuperview()
            self?.picker = nil
        })
    }
}
