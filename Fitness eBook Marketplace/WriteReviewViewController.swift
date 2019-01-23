//
//  WriteReviewViewController.swift
//  Fitness eBook Marketplace
//
//  Created by Alek Matthiessen on 1/22/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManager

class WriteReviewViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var tv: UITextView!
    
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func tapShare(_ sender: Any) {
        
        if tv.text != "" {
           
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM-dd-yyyy"
            let thisdamndate = dateFormatter.string(from: date)
           
            var intreviews = Int(selectedreviews)
            intreviews = intreviews! + 1
            var stringreviews = String(intreviews!)
            
            ref?.child("Plans").child(selectedgenre).child(selectedid).child("ReviewsAll").childByAutoId().updateChildValues(   ["Name" : thisdamnname, "Date" : thisdamndate, "Review" : tv.text! ])
            ref?.child("Plans").child(selectedgenre).child(selectedid).updateChildValues(   ["Reviews" : stringreviews])

            self.performSegue(withIdentifier: "ReviewToOverview", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        tv.delegate = self
        
        queryforinfo()

        
        tv.layer.cornerRadius = 2.0
        tv.layer.masksToBounds = true
        tv.text = "Write your review"
        tv.textColor = UIColor.lightGray
        
        // Do any additional setup after loading the view.
    }
    
    func queryforinfo() {
        
        var functioncounter = 0
        
        ref?.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var purchased = value?["Name"] as? String {
                
                thisdamnname = purchased
                
            }
            
   
            
        })
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write your review"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
