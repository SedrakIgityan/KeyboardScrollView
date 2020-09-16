//
//  KeyboardScrollView.swift
//  Zro_iOS
//
//  Created by Vardan Gevorgyan on 9/16/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit

protocol KeyboardNotifying {
    func start()
}

protocol KeyboardHandling {
    func setTextFields(textFields: [UITextField])
}

final class KeyboardScrollView: UIScrollView, KeyboardHandling {
    
    var textFields: [UITextField] = []
    
    func setTextFields(textFields: [UITextField]) {
        self.textFields = textFields
    }

        
    // MARK: - Private Functions -
    
    
    // MARK: - Keyboard Selectors -
    
    @objc private func keyboardWillHide(notification: Notification) {
        let info = notification.userInfo
        
        guard let keyboardSize = (info?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else {
            debugPrint("Can not get keyboard size")
            
            return
        }
        
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardSize.height, right: 0.0)
        
        self.contentInset = contentInsets
        self.scrollIndicatorInsets = contentInsets
    }

    @objc private func keyboardWasShown(notification: Notification) {
        for textField in self.textFields {
            guard textField.isFirstResponder else {
                continue
            }
            
            
            let userInfo = notification.userInfo
            
            guard let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                debugPrint("Can not get keyboard size")
                
                return
            }
            
            let screenBounds: CGRect = UIScreen.main.bounds
            let keyboardSizeComparedWithScreen: CGSize = CGSize(width: screenBounds.width, height: screenBounds.height - keyboardSize.height)
            let keyboarsRect = CGRect(origin: screenBounds.origin, size: keyboardSizeComparedWithScreen)
            
            let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)

            self.contentInset = contentInsets
            self.scrollIndicatorInsets = contentInsets
            
            
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
