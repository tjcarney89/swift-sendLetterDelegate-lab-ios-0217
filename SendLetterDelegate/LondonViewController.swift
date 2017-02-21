//
//  ViewController.swift
//  SendPackageDelegate
//
//  Created by Joel Bell on 10/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

protocol LondonViewControllerDelegate: class {
    func letterSent(from: LondonViewController, message: String)
}

class LondonViewController: UIViewController, UITextViewDelegate {
    
    // View elements
    @IBOutlet weak var letterTextView: UITextView!
    @IBOutlet weak var letterHeaderLabel: UILabel!
    @IBOutlet weak var containerViewCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    
    // Constraints for animation
    @IBOutlet weak var letterTextViewCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var letterImageViewCenterXConstraint: NSLayoutConstraint!
    
    weak var delegate: LondonViewControllerDelegate?
    
    // Keyboard height for adjusting view elements
    var keyboardHeight: CGFloat = 0
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendButton.isHidden = true
        addKeyboardNotificationObservers()
        letterTextView.layer.cornerRadius = 8
    }
    
    // MARK: Actions
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        delegate?.letterSent(from: self, message: letterTextView.text)
        animateLetter {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        validateTextView()
        letterTextView.resignFirstResponder()
    }
    
    // MARK: Animation
    
    func animateLetter(completion: @escaping ()->()) {
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1, animations: {
                
                self.letterImageViewCenterXConstraint.constant = 30
                self.letterTextViewCenterXConstraint.constant = 15
                self.view.layoutIfNeeded()
                
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.9, animations: {
                
                self.letterTextViewCenterXConstraint.constant = -self.view.frame.width
                self.view.layoutIfNeeded()
                
            })
            
        }) { _ in
            
            completion()
            
        }
    }
    
    // MARK: Notifications
    
    func addKeyboardNotificationObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func adjustForKeyboard(notification: Notification) {
        
        switch notification.name.rawValue {
        case "UIKeyboardWillChangeFrameNotification":
            let userInfo = notification.userInfo! as NSDictionary
            let keyboardFrame = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        case "UIKeyboardWillShowNotification":
            self.containerViewCenterYConstraint.constant = -self.keyboardHeight/2
            self.view.layoutIfNeeded()
        case "UIKeyboardWillHideNotification":
            letterHeaderLabel.text = ""
            self.containerViewCenterYConstraint.constant = 0
            self.view.layoutIfNeeded()
        default:
            break
        }
        
    }
    
    // MARK: Validation
    
    func validateTextView() {
        
        if letterTextView.text.isEmpty {
            
            let alertController = UIAlertController(title: "How Rude!", message: "Be a decent human being and send a thank you letter", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            
        } else {
            sendButton.isHidden = false
            letterTextView.resignFirstResponder()
        }
    }
    
    // MARK: TextView Delegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
        if text == "\n" {
            validateTextView()
        }
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "Write a thank you letter..." {
            textView.text = ""
        }
        return true
    }

}

