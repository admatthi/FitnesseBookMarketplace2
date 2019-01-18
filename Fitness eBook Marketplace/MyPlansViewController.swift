//
//  MyPlansViewController.swift
//  Fitness eBook Marketplace
//
//  Created by Alek Matthiessen on 1/11/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore

var myplanids = [String]()
var myplanimages = [String:UIImage]()
var mytitles = [String:String]()
var myprices = [String:String]()
var myauthor = [String:String]()
var myplanlinks = [String:String]()

var uid = String()

class MyPlansViewController: UIViewController, UITableViewDataSource, UITableViewDelegate    {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myplanimages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPlans", for: indexPath) as! MyPlansTableViewCell
        if myplanimages.count > indexPath.row {
            
        errorlabel.alpha = 0
        cell.price.text = myprices[myplanids[indexPath.row]]
        cell.author.text = myauthor[myplanids[indexPath.row]]
        cell.name.text = mytitles[myplanids[indexPath.row]]
        cell.mainimage.image = myplanimages[myplanids[indexPath.row]]
        cell.tapdownload.addTarget(self, action: #selector(MyPlansViewController.tapNext(_:)), for: UIControl.Event.touchUpInside)

        cell.selectionStyle = .none

            
        cell.tapdownload.tag = indexPath.row
            
        }
        return cell
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!

    
    @IBAction func tapNext(_ sender: AnyObject?) {
        
        var selected = sender!.tag
      
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        DispatchQueue.main.async {
            let url = URL(string: myplanlinks[myplanids[selected!]]!)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "\(selectedtitle).pdf"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("pdf successfully saved!")
            } catch {
                print("Pdf could not be saved")
            }
        
        }
    }
    
    
    @IBOutlet weak var errorlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        if Auth.auth().currentUser == nil {
            
            errorlabel.alpha = 1
            
        } else {
            
        queryforids { () -> () in
            
            self.queryforreviewinfo()
            
        }
        
        }
        // Do any additional setup after loading the view.
    }
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        
        var functioncounter = 0
        
        myplanids.removeAll()
        myprices.removeAll()
        myauthor.removeAll()
        mytitles.removeAll()
        myplanlinks.removeAll()
        
        ref?.child("Users").child(uid).child("Purchased").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    myplanids.append(ids)
                    
                    functioncounter += 1
                    if functioncounter == snapDict.count {
                        
                        
                        completed()
                        
                    }

                }
                
            }
            
        })
        
    }
    
    
    func queryforreviewinfo() {
        
        var functioncounter = 0
        
        for each in myplanids {
            
            
            ref?.child("Users").child(uid).child("Purchased").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                
                
                if var author2 = value?["Title"] as? String {
                    mytitles[each] = author2
                    
                }
                
                if var author2 = value?["Link"] as? String {
                    myplanlinks[each] = author2
                    
                }
                
                if var author2 = value?["Author"] as? String {
                    myauthor[each] = author2
                    
                }
                
                if var author2 = value?["Price"] as? String {
                    myprices[each] = author2
                    
                }
                
                if var profileUrl = value?["Image"] as? String {
                    // Create a storage reference from the URL
                    
                    let url = URL(string: profileUrl)
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    var selectedimage = UIImage(data: data!)!
                    
                    myplanimages[each] = selectedimage
                    
                    functioncounter += 1
                    
                }
                
                
                if functioncounter == myplanids.count {
                    
                    self.tableView.reloadData()
                    
                }
                
            })
            
        }
        
    }
    
}
