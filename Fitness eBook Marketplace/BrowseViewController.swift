//
//  BrowseViewController.swift
//  Fitness eBook Marketplace
//
//  Created by Alek Matthiessen on 1/11/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage

var planids = [String]()
var names = [String:String]()
var products = [String:String]()
var productlinks = [String:String]()
var titles = [String:String]()
var reviews = [String:String]()
var authors = [String:String]()
var images = [String:UIImage]()
var times = [String:String]()
var links = [String:String]()
var prices = [String:String]()
var imagelinks = [String:String]()

var selectedid = String()
var selectedprice = String()
var selecteddescription = String()
var selectedtitle = String()
var selectedimage = UIImage()
var selectedauthor = String()
var ref: DatabaseReference?
var selectedgenre = String()
var selectedlink = String()

var selectedimagelink = String()

class BrowseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    @IBOutlet weak var collectionView1: UICollectionView!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        var screenSize = collectionView.bounds
        var screenWidth = screenSize.width
        var screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/1)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        collectionView!.collectionViewLayout = layout
        
        genres.append("Featured")
        genres.append("Weight Loss")
        genres.append("Build Muscle")
        genres.append("Gain Strength")
        collectionView1.reloadData()
        selectedgenre = genres[0]

        queryforids { () -> () in
            
            self.queryforreviewinfo()
            
        }
        
   
        // Do any additional setup after loading the view.
    }
    
   
    func queryforids(completed: @escaping (() -> ()) ) {
        
        
        var functioncounter = 0
        
        images.removeAll()
        authors.removeAll()
        reviews.removeAll()
        products.removeAll()
        productlinks.removeAll()
        titles.removeAll()
        times.removeAll()
        planids.removeAll()
        links.removeAll()
        imagelinks.removeAll()
        prices.removeAll()
        
    ref?.child("Plans").child(selectedgenre).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                
                    planids.append(ids)
                    
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
        
        for each in planids {
            
            
            ref?.child("Plans").child(selectedgenre).child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                
                
                if var author2 = value?["Author"] as? String {
                    authors[each] = author2
                    
                }
                
                if var author2 = value?["Description"] as? String {
                    
                    self.descriptions[each] = author2
                }
                
                if var author2 = value?["New Price"] as? String {
                    prices[each] = author2
                    
                }
                
                if var author2 = value?["Reviews"] as? String {
                    reviews[each] = author2
                    
                }
                
                if var author2 = value?["Link"] as? String {
                    links[each] = author2
                    
                }
                if var author2 = value?["Title"] as? String {
                    titles[each] = author2
                    
                }
                
                if var profileUrl = value?["Image"] as? String {
                    // Create a storage reference from the URL
                    
                    let url = URL(string: profileUrl)
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    var selectedimage = UIImage(data: data!)!
                    imagelinks[each] = profileUrl
                    images[each] = selectedimage
                    
                    functioncounter += 1
                    
                }
                
                
                if functioncounter == planids.count {
                    
                    self.activityIndicator.alpha = 0
                    self.collectionView.reloadData()
                    
                }
                
            })
            
        }
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 1 {
            
            return genres.count
            
        } else {
            
            if images.count > 0 {
                
                return images.count
                
            } else {
                
                return 0
                
            }
            
        }
    }
    
    var selectedindex = Int()
    var genres = [String]()
  
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        if collectionView.tag == 1 {
            
            selectedindex = indexPath.row
            
            collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            
            
            
            if selectedindex == 0 {
                
                collectionView.alpha = 0
                
                activityIndicator.startAnimating()
                activityIndicator.alpha = 1
//                activityIndicator.color = mygreen
                
                queryforids { () -> () in
                    
                    self.queryforreviewinfo()
                    
                }
                
                collectionView.reloadData()
                
            } else {
                
                collectionView.alpha = 0
                
                selectedgenre = genres[indexPath.row]
                activityIndicator.startAnimating()
                activityIndicator.alpha = 1
//                activityIndicator.color = mygreen
                
                
                queryforids { () -> () in
                    
                    self.queryforreviewinfo()
                    
                }
                
                collectionView.reloadData()
                
            }
            
        } else {
            
            if images.count > 0 {
                
                selectedid = planids[indexPath.row]
                selectedgenre = genres[indexPath.row]
                selectedimage = images[planids[indexPath.row]]!
                selectedtitle = titles[planids[indexPath.row]]!
                selectedauthor = authors[planids[indexPath.row]]!
                selecteddescription = descriptions[planids[indexPath.row]]!
                selectedlink = links[planids[indexPath.row]]!
                selectedreviews = reviews[planids[indexPath.row]]!
                selectedprice = prices[planids[indexPath.row]]!
                selectedimagelink = imagelinks[planids[indexPath.row]]!
                DispatchQueue.main.async {
                    
                    
                    self.performSegue(withIdentifier: "BrowseToOverview", sender: self)
                    
                }
                
                
                
            } else {
                
            }
            
        }
    }
    
    var descriptions = [String:String]()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Plans", for: indexPath) as! PlansCollectionViewCell
            
            cell.plancover.image = images[planids[indexPath.row]]
            cell.titlelabel.text = titles[planids[indexPath.row]]
            cell.reviewcount.text = "(\(reviews[planids[indexPath.row]]!))"
            cell.authorname.text = authors[planids[indexPath.row]]
            cell.newprice.text = prices[planids[indexPath.row]]
            let attributeString : NSMutableAttributedString =  NSMutableAttributedString(string: "$199.99")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            
            cell.oldprice.attributedText = attributeString
            
            return cell
            
        } else {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Categories", for: indexPath) as! GenreCollectionViewCell

        collectionView.alpha = 1
        cell.titlelabel.text = genres[indexPath.row]
        //            cell.titlelabel.sizeToFit()
        
        cell.selectedimage.layer.cornerRadius = 5.0
        cell.selectedimage.layer.masksToBounds = true
        collectionView1.alpha = 1
        
        if selectedindex == 0 {
            
            if indexPath.row == 0 {
                
                cell.titlelabel.alpha = 1
                cell.selectedimage.alpha = 1
                
            } else {
                
                cell.titlelabel.alpha = 0.25
                cell.selectedimage.alpha = 0
                
            }
            
        }
        
        if selectedindex == 1 {
            
            if indexPath.row == 1 {
                
                cell.titlelabel.alpha = 1
                cell.selectedimage.alpha = 1
                
            } else {
                
                cell.titlelabel.alpha = 0.25
                cell.selectedimage.alpha = 0
                
            }
            
        }
        
        if selectedindex == 2 {
            
            if indexPath.row == 2 {
                
                cell.titlelabel.alpha = 1
                cell.selectedimage.alpha = 1
                
            } else {
                
                cell.titlelabel.alpha = 0.25
                cell.selectedimage.alpha = 0
                
            }
            
        }
        
        if selectedindex == 3 {
            
            if indexPath.row == 3 {
                
                cell.titlelabel.alpha = 1
                cell.selectedimage.alpha = 1
                
            } else {
                
                cell.titlelabel.alpha = 0.25
                cell.selectedimage.alpha = 0
                
            }
            
        }
        
        if selectedindex == 4 {
            
            if indexPath.row == 4 {
                
                cell.titlelabel.alpha = 1
                cell.selectedimage.alpha = 1
                
            } else {
                
                cell.titlelabel.alpha = 0.25
                cell.selectedimage.alpha = 0
                
            }
            
        }
        
        if selectedindex == 5 {
            
            if indexPath.row == 5 {
                
                cell.titlelabel.alpha = 1
                cell.selectedimage.alpha = 1
                
            } else {
                
                cell.titlelabel.alpha = 0.25
                cell.selectedimage.alpha = 0
                
            }
            
        }
        
        if selectedindex == 6 {
            
            if indexPath.row == 6 {
                
                cell.titlelabel.alpha = 1
                cell.selectedimage.alpha = 1
                
            } else {
                
                cell.titlelabel.alpha = 0.25
                cell.selectedimage.alpha = 0
                
            }
            
        }
        
        if selectedindex == 7 {
            
            if indexPath.row == 7 {
                
                cell.titlelabel.alpha = 1
                cell.selectedimage.alpha = 1
                
            } else {
                
                cell.titlelabel.alpha = 0.25
                cell.selectedimage.alpha = 0
                
            }
            
        }
        
        return cell
        
    }
        
    }
}

extension UILabel {
    func addCharacterSpacing() {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: 1.2, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}


extension Date {
    
    func timeAgoSinceDate() -> String {
        
        // From Time
        let fromDate = self
        
        // To Time
        let toDate = Date()
        
        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "y" : "\(interval)" + " " + "y"
        }
        
        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "m" : "\(interval)" + " " + "m"
        }
        
        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "d" : "\(interval)" + " " + "d"
        }
        
        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "h" : "\(interval)" + " " + "h"
        }
        
        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "m" : "\(interval)" + " " + "m"
        }
        
        return "25s"
    }
}
