//
//  RegisterViewController.swift
//  Fitness eBook Marketplace
//
//  Created by Alek Matthiessen on 1/11/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FBSDKCoreKit
import IQKeyboardManager

class RegisterViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func tapTerms(_ sender: Any) {
        
        if let url = NSURL(string: "http://www.joinmyfam.com/terms"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    @IBOutlet weak var tapterms: UIButton!
    var mypropic = UIImage()
    @IBAction func tapSignUp(_ sender: Any) {
        
        self.view.endEditing(true)

        if myfuckingcode == "" {
            
            if fn.text != "" && emailtf.text  != "" && passwordtf.text != "" && selected {

                signup()

            } else {
                
                errorlabel.alpha = 1
            }
            
        } else {
        if fn.text != "" && emailtf.text  != "" && passwordtf.text != "" && codetf.text != "" && selected {
            
            signup()
            
        } else {
            
            
            errorlabel.alpha = 1
            
            }
        
        }
    }
    
    func loadthumbnail() {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let currentUser = Auth.auth().currentUser
        
        //        let metaData = StorageMetadata()
        //
        //        metaData.contentType = "image/jpg"
        
        uid = (currentUser?.uid)!
        
        
        
        
        
//        var whatthough = UIImageJPEGRepresentation(mypropic, 1.0)
        var whatthough = mypropic.jpegData(compressionQuality: 1.0)
        
        var metaData = StorageMetadata()
        
        metaData.contentType = "image/jpg"
        
        // Create a reference to the file you want to upload
        let randomString = UUID().uuidString
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child(randomString)
        
        
        let uploadTask = riversRef.putData(whatthough!, metadata: metaData) { metadata, error in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                print(error?.localizedDescription)
                
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            // You can also access to download URL after upload.
            
            //            metadata.download
            
            
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    print(error?.localizedDescription)
                    return
                }
                
                print(downloadURL)
                
                self.mystring2 = downloadURL.absoluteString
                
                
                ref!.child("Users").child(uid).updateChildValues(["Full Name" : self.fn.text!, "Email" : self.emailtf.text!, "Password" : self.passwordtf.text!, "Code" : self.codetf.text!, "ProPic" : self.mystring2])
                
                didpurchase = true
                
                DispatchQueue.main.async {
                    
                    //                    purchased = true
                    
                    self.performSegue(withIdentifier: "LoginToExplore", sender: self)
                }
                
            }
        }
    }
    
    var mystring2 = String()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadinglabel: UILabel!
    @IBOutlet weak var errorlabel: UILabel!
    @IBOutlet weak var passwordtf: UITextField!
    @IBOutlet weak var emailtf: UITextField!
    var selected = Bool()
    @IBOutlet weak var propic: UIImageView!
    func signup() {
        
        view.bringSubviewToFront(activityIndicator)
        
        loadinglabel.alpha = 0.5
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
        
        var email = "\(emailtf.text!)"
        var password = "\(passwordtf.text!)"
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                
                self.errorlabel.alpha = 1
                self.errorlabel.text = error.localizedDescription
                return
                
            } else {
                
                uid = (Auth.auth().currentUser?.uid)!
                
                //                ref!.child("Users").child(uid).child("Purchased").child(selectedid).updateChildValues(["Title": "x"])
                
                let date = Date()
                let calendar = Calendar.current
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yy"
                var todaysdate =  dateFormatter.string(from: date)
                let thirtyDaysAfterToday = Calendar.current.date(byAdding: .day, value: +30, to: date)!
                let thirty = dateFormatter.string(from: thirtyDaysAfterToday)
                
                //                self.addstaticbooks()
                
//                ref!.child("Users").child(uid).child("Purchased").child(selectedid).updateChildValues(["Title" : selectedtitle, "Author" : selectedauthor, "Price" : selectedprice])
                
                self.loadthumbnail()
            }
            
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    @IBAction func tapAddPhoto(_ sender: Any) {
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        
        present(imagePickerController, animated: true, completion: nil)

    }
    
    var imagePickerController = UIImagePickerController()


      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let image = info[.originalImage] as? UIImage else {
                      fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
                  }
        
        mypropic = image
        propic.image = image
        selected = true
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
    @IBOutlet weak var codetf: UITextField!
    @IBOutlet weak var tapcreate: UIButton!
    @IBOutlet weak var header: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        propic.layer.cornerRadius = propic.frame.height/2
selected = false
        propic.clipsToBounds = true
        
        loadinglabel.alpha = 0
        activityIndicator.alpha = 0
        
        // Do any additional setup after loading the view.
        
        //        emailtf.layer.borderColor = UIColor.gray.cgColor
        //        emailtf.layer.borderWidth = 0.5
        //        passwordtf.layer.borderColor = UIColor.gray.cgColor
        //        passwordtf.layer.borderWidth = 0.5
        
    
        imagePickerController.delegate = self

        
        ref = Database.database().reference()
        
        emailtf.delegate = self
        codetf.delegate = self
        fn.delegate = self
        passwordtf.delegate = self
        fn.becomeFirstResponder()
        //        tapcreate.layer.cornerRadius = 22.0
        //        tapcreate.layer.masksToBounds = true
        
        errorlabel.alpha = 0
      
        ref = Database.database().reference()

        ref?.child("Code").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            
            
            if var author2 = value?["Code"] as? String {
                self.myfuckingcode = author2
                
            }
            
        })
        
        // Do any additional setup after loading the view.
    }

    var myfuckingcode = String()
    
    @IBAction func fullname(_ sender: Any) {
    }
    
    @IBOutlet weak var fn: UITextField!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
