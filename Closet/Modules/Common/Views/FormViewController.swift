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
    
    /// To keep track which textfield is begin edited and move the view properly
    var activeField: UITextField!
    var activeTextView: UITextView!
    var isScrollEnabled = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isScrollEnabled = scrollView.isScrollEnabled
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// Set the configuration to move the view properly every time the
        /// Keyboard is shown, also configures the view to hide the keyboard when
        /// the user touches the screen outside any textfield
        registerForKeyboardNotifications()
        hideKeyboardOnViewTouch(viewKeyboardMask)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let center = NotificationCenter.default
        center.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        center.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Configures the Keyboard notifications to keep track the keyboard behaviour
    func registerForKeyboardNotifications(){
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(self.keyboardWasShown(_:)),
                           name: UIResponder.keyboardDidShowNotification,
                           object: nil)
        center.addObserver(self,
                           selector: #selector(self.keyboardWasShown(_:)),
                           name:  UIResponder.keyboardDidChangeFrameNotification,
                           object: nil)
        center.addObserver(self,
                           selector: #selector(self.keyboardWillBeHidden(_:)),
                           name: UIResponder.keyboardWillHideNotification,
                           object: nil)
    }
    
    /// Called when the UIKeyboardDidShowNotification is sent.
    @objc func keyboardWasShown(_ notification: NSNotification){
        guard activeField != nil || activeTextView != nil else{return}
        
        scrollView.isScrollEnabled = true
        
        let info = notification.userInfo
        let kbSize = (info?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        let kbToolbarHeight: CGFloat = 40 //we always add a toolbar to the keyboard
        
        guard kbSize != nil else {return}
        let screenHeight = UIScreen.main.bounds.size.height
        let Ymax = screenHeight - (kbSize!.height + kbToolbarHeight)
        
        //Get the textField Y position according to main view
        var txtFieldYpos = Ymax // Temp value just to calculate the real one
        if activeField != nil {
            txtFieldYpos = activeField.convert(activeField.bounds, to: view).origin.y
            txtFieldYpos = txtFieldYpos + activeField.frame.size.height
        } else if activeTextView != nil {
            txtFieldYpos = activeTextView.convert(activeTextView.bounds, to: view).origin.y
            txtFieldYpos = txtFieldYpos + activeTextView.frame.size.height
        } else {
            return
        }
        
        //guard txtFieldYpos > Ymax else{return} not sure if this part is necessary
        
        //Active text field is hidden by keyboard, scroll it so it's visible
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
    
    /// Called when the UIKeyboardWillHideNotification is sent
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
    
    /// Dismisses the keyboard when touching anywhere outside UITextField
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
    
    /// Causes the view (or one of its embedded text fields) to resign the 1st responder status
    /// - note: if you want to dismiss the keyboard when touching outside UITextField use
    /// 'hideKeyboardOnViewTouch' method instead
    @IBAction func hideKeyboard(){
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
    }
}
