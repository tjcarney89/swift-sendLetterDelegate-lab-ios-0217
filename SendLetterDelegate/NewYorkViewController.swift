//
//  ViewController.swift
//  SendPackageDelegate
//
//  Created by Joel Bell on 10/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class NewYorkViewController: UIViewController {
    
    // View elements
    @IBOutlet weak var receivedHeaderLabel: UILabel!
    @IBOutlet weak var packageImageView: UIImageView!
    @IBOutlet weak var letterTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    // Constraints for animation
    @IBOutlet weak var packageCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var packageCenterYConstraint: NSLayoutConstraint!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receivedHeaderLabel.isHidden = true
        letterTextView.isHidden = true
    }

    
    
    // MARK: Action
    
    @IBAction func sendButton(_ sender: UIButton) {
        animatePackage {
            self.performSegue(withIdentifier: "sentSegue", sender: nil)
            
            
        }
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sentSegue" {
            let destVC = segue.destination as! LondonViewController
            destVC.delegate = self
        }
        
    }
    
    // MARK: Animation
    
    func animatePackage(completion: @escaping ()->()) {
        
        UIView.animateKeyframes(withDuration: 0.7, delay: 0.0, options: [.calculationModeCubic], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1, animations: {
                
                self.packageCenterYConstraint.constant = 10
                self.packageCenterXConstraint.constant = 10
                self.view.layoutIfNeeded()
                
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4, animations: {
                
                self.packageCenterYConstraint.constant = -(self.view.frame.size.height/4)
                self.packageCenterXConstraint.constant = -(self.view.frame.size.width * 0.1)
                self.packageImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.view.layoutIfNeeded()
                
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                
                self.packageCenterXConstraint.constant = self.view.frame.size.width/2
                self.packageCenterYConstraint.constant = -self.view.frame.size.height/2
                self.packageImageView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                self.view.layoutIfNeeded()
                
            })
            
        }) { _ in
            
            completion()
        }
        
    }

}

extension NewYorkViewController: LondonViewControllerDelegate {
    func letterSent(from: LondonViewController, message: String) {
        letterTextView.text = message
        receivedHeaderLabel.isHidden = false
        letterTextView.isHidden = false
        packageImageView.isHidden = true
        sendButton.isHidden = true
    }
}

