//
//  PickerViewDelegate.swift
//  Closet
//
//  Created by chila on 6/20/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

extension PickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        if let title = dataSource?.titleFor(pickerView: self, atIndex: row) {
            return title
        } else if let items = items {
            return items[row]
        }
        return "- Seleccionar -"
    }
}
