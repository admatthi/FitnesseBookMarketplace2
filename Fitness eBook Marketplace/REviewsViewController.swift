//
//  REviewsViewController.swift
//  Fitness eBook Marketplace
//
//  Created by Alek Matthiessen on 1/11/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore

var reviews4 = [String:String]()
var reviewids = [String]()
var dates = [String:String]()
var reviewnames = [String:String]()
var stars = [String:String]()

class REviewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return reviews4.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Review", for: indexPath) as! ReviewTableViewCell
        
        cell.review.text = reviews4[reviewids[indexPath.row]]
        cell.date.text = dates[reviewids[indexPath.row]]
        cell.name.text = reviewnames[reviewids[indexPath.row]]
        
        return cell
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        queryforids { () -> () in
            
            self.queryforreviewinfo()
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        
        var functioncounter = 0

        
        ref?.child("Plans").child(selectedid).child("Reviews").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    planids.append(ids)
                    
                    
                }
                
            }
            
        })
        
    }
    
    
    func queryforreviewinfo() {
        
        var functioncounter = 0
        
        for each in reviewids {
            
            
            ref?.child("Plans").child(selectedid).child("Reviews").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                
                
                if var author2 = value?["Date"] as? String {
                    dates[each] = author2
                    
                }
                
                if var author2 = value?["Review"] as? String {
                    reviews4[each] = author2
                    
                }
                
                if var author2 = value?["Name"] as? String {
                    reviewnames[each] = author2
                    
                }
             
        
                
                if functioncounter == reviewids.count {
                    
                    self.tableView.reloadData()
                    
                }
                
            })
            
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
