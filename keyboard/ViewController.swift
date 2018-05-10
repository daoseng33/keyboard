//
//  ViewController.swift
//  keyboard
//
//  Created by daoseng on 2018/5/10.
//  Copyright © 2018年 LikeABossApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.view.addGestureRecognizer(tap)
        self.bottomTextField.delegate = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.bottomTextField {
            print("text field should beging editing")
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(self.keyboardNotification(notification:)),
                                                   name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                                   object: nil)
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("text filed did end editing")
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.view.endEditing(true)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame: CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frame = self.view.frame
                frame.origin.y = keyboardFrame.minY - self.view.frame.height
                self.view.frame = frame
            })
        }
    }

}

