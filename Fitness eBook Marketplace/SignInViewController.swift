//
//  SignInViewController.swift
//  Fitness eBook Marketplace
//
//  Created by Alek Matthiessen on 1/11/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FBSDKCoreKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBAction func tapBack(_ sender: Any) {
        
//        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func tapSignIn(_ sender: Any) {
        
        login()
    }
    
    func login() {
        
        var email = "\(emailtf.text!)"
        var password = "\(passwordtf.text!)"
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                
                
                self.errorlabel.alpha = 1
                self.errorlabel.text = error.localizedDescription
                
                
                
                return
                
            } else {
                
                uid = (Auth.auth().currentUser?.uid)!
                
                let date = Date()
                let calendar = Calendar.current
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yy"
                var todaysdate =  dateFormatter.string(from: date)
                
                self.performSegue(withIdentifier: "SigninToExplore", sender: self)
                
                
            }
            
        }
        
    }
    

    
    @IBOutlet weak var header: UILabel!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    @IBOutlet weak var errorlabel: UILabel!
    @IBOutlet weak var passwordtf: UITextField!
    @IBOutlet weak var emailtf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header.addCharacterSpacing()
        // Do any additional setup after loading the view.
        
        
        
        //        emailtf.layer.borderColor = UIColor.gray.cgColor
        //        emailtf.layer.borderWidth = 0.5
        //        passwordtf.layer.borderColor = UIColor.gray.cgColor
        //        passwordtf.layer.borderWidth = 0.5
        //
        ref = Database.database().reference()
        
        emailtf.delegate = self
        passwordtf.delegate = self
        emailtf.becomeFirstResponder()
        //        tapcreate.layer.cornerRadius = 22.0
        //        tapcreate.layer.masksToBounds = true
        
        errorlabel.alpha = 0
        
    }
        // Do any additional setup after loading the view.
}
