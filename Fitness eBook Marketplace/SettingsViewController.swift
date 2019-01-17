//
//  SettingsViewController.swift
//  Fitness eBook Marketplace
//
//  Created by Alek Matthiessen on 1/11/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore

class SettingsViewController: UIViewController {

    
    
 
@IBAction func tapAbout(_ sender: Any) {
    
    if let url = NSURL(string: "https://www.snippetsla.com"
        ) {
        UIApplication.shared.openURL(url as URL)
    }
}

@IBAction func tapLogout(_ sender: Any) {
    
    try! Auth.auth().signOut()
    
    self.performSegue(withIdentifier: "SettingsToOverview", sender: self)
}
@IBAction func tapSubscription(_ sender: Any) {
    
    if let url = NSURL(string: "https://www.snippetsla.com/subscription.html"
        ) {
        UIApplication.shared.openURL(url as URL)
    }
}

@IBAction func tapTerms(_ sender: Any) {
    
    if let url = NSURL(string: "https://www.snippetsla.com/terms.html"
        ) {
        UIApplication.shared.openURL(url as URL)
    }
}

    @IBAction func tapLogin(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SettingsToLogin", sender: self)
    }
    @IBAction func tapBack(_ sender: Any) {
    
    self.dismiss(animated: true, completion: nil)
}
@IBAction func tapGives(_ sender: Any) {
    
    if let url = NSURL(string: "https://www.snippetsla.com/gives.html"
        ) {
        UIApplication.shared.openURL(url as URL)
    }
}

@IBAction func tapPrivacy(_ sender: Any) {
    
    if let url = NSURL(string: "https://www.snippetsla.com/privacy-policy.html"
        ) {
        UIApplication.shared.openURL(url as URL)
    }
}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if Auth.auth().currentUser != nil {
            
            taplogin.alpha = 0
            taplogout.alpha = 1
            
        } else {
            taplogin.alpha = 1
            taplogout.alpha = 0
            
        }
    }
    

    @IBOutlet weak var taplogout: UIButton!
    @IBOutlet weak var taplogin: UIButton!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
