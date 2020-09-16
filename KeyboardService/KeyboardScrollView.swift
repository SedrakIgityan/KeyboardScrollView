//
//  KeyboardScrollView.swift
// 
//
//  Created by Sedrak Igityan on 9/16/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit


// MARK: - KeyboardNotifying -

/// Responsible for setting keyboard notifiers.
protocol KeyboardNotifying {
    func start()
}


// MARK: - KeyboardHandling -

/// Responsible for setting textfields to scroll them
protocol KeyboardHandling {
    
    /// Use function to set textfields, which will be scrolled
    /// - parameter textFields: Textfields to scroll
    func setTextFields(textFields: [UITextField])
}


// MARK: - KeyboardScrollView -

/// Responsible to scroll for textfields to handle keyboard events
/// `Extend` your scroll view to KeyboardScrollView
final class KeyboardScrollView: UIScrollView, KeyboardHandling {
    
    
    // MARK: - Properties -
    
    /// Textfields, which will be scored
    var textFields: [UITextField] = []
    
    
    // MARK: - Functions -
    
    /// See KeyboardHandling `setTextFields(textFields: [UITextField])` method interface for more info.
    func setTextFields(textFields: [UITextField]) {
        self.textFields = textFields
    }

        
    // MARK: - Private Functions -
    
    
    // MARK: - Keyboard Selectors -
    
    /// Action when keyboard hides
    @objc private func keyboardWillHide(notification: Notification) {
        let info = notification.userInfo
        
        /// Get keyboard size
        guard let keyboardSize = (info?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else {
            /// Failed
            debugPrint("Can not get keyboard size")
            
            return
        }
        
        /// Set content inset to initial
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardSize.height, right: 0.0)
        
        self.contentInset = contentInsets
        self.scrollIndicatorInsets = contentInsets
    }

    /// Action when keyboard shows
    @objc private func keyboardWasShown(notification: Notification) {
        for textField in self.textFields {
            /// Check which textfield is currently active
            guard textField.isFirstResponder else {
                /// Is not active
                continue
            }
            
            /// Than
            let userInfo = notification.userInfo
            
            /// Get keyboard size
            guard let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                /// Failed
                debugPrint("Can not get keyboard size")
                
                return
            }
            
            /// Get keyboard size relate to screen
            let screenBounds: CGRect = UIScreen.main.bounds
            let keyboardSizeComparedWithScreen: CGSize = CGSize(width: screenBounds.width, height: screenBounds.height - keyboardSize.height)
            let keyboarsRect = CGRect(origin: screenBounds.origin, size: keyboardSizeComparedWithScreen)
            
            /// Fetch content inset from keyboard size
            let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)

            /// Set inset to scroll view
            self.contentInset = contentInsets
            self.scrollIndicatorInsets = contentInsets
            
            /// Scroll to be visible
            if keyboarsRect.contains(textField.frame.origin) {
                self.scrollRectToVisible(textField.frame, animated: true)
            }
        }
    }
}


// MARK: - KeyboardNotifying IMPL -

extension KeyboardScrollView: KeyboardNotifying {

    
    /// Responsible for set observer to keyboard actions
    func start() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
