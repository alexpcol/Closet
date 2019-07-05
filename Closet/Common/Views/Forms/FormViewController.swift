//
//  FormViewController.swift
//  Closet
//
//  Created by chila on 6/20/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class GenericFormVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewKeyboardMask: UIView!
    
    var activeField: UITextField!
    var activeTextView: UITextView!
    var isScrollEnabled = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isScrollEnabled = scrollView.isScrollEnabled
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
        hideKeyboardOnViewTouch(viewKeyboardMask)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let center = NotificationCenter.default
        center.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        center.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func registerForKeyboardNotifications(){
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(self.keyboardWasShown(_:)),
                           name: UIResponder.keyboardDidShowNotification,
                           object: nil)
        center.addObserver(self,
                           selector: #selector(self.keyboardWillBeHidden(_:)),
                           name: UIResponder.keyboardWillHideNotification,
                           object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification){
        guard activeField != nil || activeTextView != nil else{return}
        
        scrollView.isScrollEnabled = true
        
        let info = notification.userInfo
        let kbSize = (info?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        let kbToolbarHeight: CGFloat = 40 //we always add a toolbar to the keyboard
        
        guard kbSize != nil else {return}
        let screenHeight = UIScreen.main.bounds.size.height
        let Ymax = screenHeight - (kbSize!.height + kbToolbarHeight)

        var txtFieldYpos = Ymax
        if activeField != nil {
            txtFieldYpos = activeField.convert(activeField.bounds, to: view).origin.y
            txtFieldYpos = txtFieldYpos + activeField.frame.size.height
        } else if activeTextView != nil {
            txtFieldYpos = activeTextView.convert(activeTextView.bounds, to: view).origin.y
            txtFieldYpos = txtFieldYpos + activeTextView.frame.size.height
        } else {
            return
        }
        
        var txtFrame: CGRect!
        if activeField != nil {
            txtFrame = activeField.frame
        } else if activeTextView != nil {
            txtFrame = activeTextView.frame
        }
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize!.height + 20, right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        let rect = CGRect(x: txtFrame.origin.x,
                          y: txtFrame.origin.y + 20,
                          width: txtFrame.size.width,
                          height: txtFrame.size.height)
        scrollView.scrollRectToVisible(rect, animated: true)
    }

    @objc func keyboardWillBeHidden(_ notification: NSNotification){
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        scrollView.isScrollEnabled = isScrollEnabled
    }
}

//MARK:- UITextFieldDelegate
extension GenericFormVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
        activeTextView = nil
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
        activeTextView = nil
    }
}

//MARK:- UITextViewDelegate
extension GenericFormVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        activeTextView = textView
        activeField = nil
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        activeTextView = nil
        activeField = nil
    }
}

//MARK:- Keyboard related methods
public extension UIViewController {
    
    func hideKeyboardOnViewTouch(_ view: UIView? = nil) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        
        if let targetView = view {
            targetView.addGestureRecognizer(tapGesture)
        } else {
            self.view.addGestureRecognizer(tapGesture)
        }
    }
    
    func removeGestures(_ subview: UIView){
        subview.gestureRecognizers?.forEach(subview.removeGestureRecognizer)
    }
    
    @IBAction func hideKeyboard(){
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
    }
}
