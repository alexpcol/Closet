//
//  PickerViewDataSource.swift
//  Closet
//
//  Created by chila on 6/20/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

extension PickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let total = dataSource?.numberOfRowsFor(pickerView: self) else {
            guard let items = items else { return 0 }
            return items.count
        }
        return total
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel? = view as? UILabel
        if label == nil {
            label = UILabel()
            label?.font = UIFont.systemFont(ofSize: 16.0)
            label?.textAlignment = .center
            label?.adjustsFontSizeToFitWidth = true
        }
        
        label?.textColor = UIColor.black
        
        if let title = dataSource?.titleFor(pickerView: self, atIndex: row) {
            label?.text = title
        } else if let items = items {
            label?.text = items[row]
        } else {
            label?.text = " - "
        }
        return label!
    }
}
