//
//  ProductOverviewViewController.swift
//  Fitness eBook Marketplace
//
//  Created by Alek Matthiessen on 1/17/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FBSDKCoreKit
import StoreKit
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
import UXCam
import AVFoundation
import Purchases

var selectedreviews = String()
class ProductOverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Overview", for: indexPath) as! OverviewTableViewCell
        
        cell.a.addCharacterSpacing()
        cell.b.addCharacterSpacing()
        cell.c.addCharacterSpacing()
        cell.d.addCharacterSpacing()
        cell.e.addCharacterSpacing()
        cell.f.addCharacterSpacing()
 
        
        cell.authorlabel.text = selectedauthor
        cell.mainimage.image = selectedimage
        cell.titlelabel.text = selectedtitle
        cell.descriptionlabel.text = selecteddescription
        cell.reviews.text = "\(selectedreviews) reviews"

        cell.goal.text = goals
        cell.review1.text = review1s
        cell.review2.text = review2s
        cell.review3.text = review3s
        cell.date1.text = date1s
        cell.date2.text = date2s
        cell.date3.text = date3s
        cell.name1.text = name1s
        cell.name2.text = name2s
        cell.name3.text = name3s
        cell.weeks.text = weekss
        cell.days.text = dayss
        cell.minutes.text = minutess
        cell.level.text = levels
        return cell
    }
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var newprice: UILabel!
    
        var purchases = RCPurchases(apiKey: "jLMuZLatPMLmTSoFKkaVNnTyXyAqYuaP")
    
    @IBOutlet weak var oldprice: UILabel!
    @IBAction func tapBuy(_ sender: Any) {
        
        purchases.entitlements { entitlements in
            guard let pro = entitlements?["Plans"] else { return }
            guard let monthly = pro.offerings["Low"] else { return }
            guard let product = monthly.activeProduct else { return }
            self.purchases.makePurchase(product)
            
            
        }
        
    }
    
    func queryforreviewinfo() {
        
        var functioncounter = 0
            
            ref?.child("Plans").child(selectedgenre).child(selectedid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                
                
                if var author2 = value?["Level"] as? String {
                    levels = author2
                    
                }
          
                if var author2 = value?["Goal"] as? String {
                    goals = author2
                    
                }
                if var author2 = value?["Review1"] as? String {
                    review1s = author2
                    
                }
                if var author2 = value?["Review2"] as? String {
                    review2s = author2
                    
                }
                if var author2 = value?["Review3"] as? String {
                    review3s = author2
                    
                }
                if var author2 = value?["Date1"] as? String {
                    date1s = author2
                    
                }
                if var author2 = value?["Date2"] as? String {
                    date2s = author2
                    
                }
                if var author2 = value?["Date3"] as? String {
                    date3s = author2
                    
                }
                if var author2 = value?["Name1"] as? String {
                    name1s = author2
                    
                }
                
                if var author2 = value?["Name2"] as? String {
                    name2s = author2
                    
                }
                
                if var author2 = value?["Name3"] as? String {
                    name3s = author2
                    
                }
                
              
                
                if var author2 = value?["Weeks"] as? String {
                    weekss = author2
                    
                }
                
                if var author2 = value?["Days"] as? String {
                    dayss = author2
                    
                }
                
                if var author2 = value?["Minutes"] as? String {
                    minutess = author2
                    
                }
                
              
                self.tableView.reloadData()
                
        })
        
    }
                
    @IBOutlet weak var tapbuy: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        newprice.text = selectedprice
        tapbuy.layer.cornerRadius = 22.0
        tapbuy.layer.masksToBounds = true
        queryforreviewinfo()
        // Do any additional setup after loading the view.
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
