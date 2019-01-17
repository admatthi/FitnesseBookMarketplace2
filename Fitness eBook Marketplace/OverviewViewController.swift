//
//  OverviewViewController.swift
//  Fitness eBook Marketplace
//
//  Created by Alek Matthiessen on 1/16/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {

    
    @IBOutlet weak var taps: UIButton!
    @IBOutlet weak var tapr: UIButton!
    @IBOutlet weak var TAPJOIN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        images.removeAll()
        
        tapr.addTextSpacing(2.0)
        taps.addTextSpacing(2.0)
        
        //        TAPJOIN.frame = CGRect(x: 0, y: TAPJOIN.frame.minY, width: self.view.frame.width/2, height: 76)
        //        self.view.addSubview(TAPJOIN)
        
        images.append(UIImage(named: "CC1 Copy")!)
        images.append(UIImage(named: "CC4 Copy")!)
        
        
        images.append(UIImage(named: "CC2 Copy")!)
        images.append(UIImage(named: "CC3 Copy")!)
        
        mainimage.image = images[counter]
        
        setupimage.image = UIImage(named: "Setup\(counter)")
        let swipeRightRec = UISwipeGestureRecognizer()
        let swipeLeftRec = UISwipeGestureRecognizer()
        let swipeUpRec = UISwipeGestureRecognizer()
        let swipeDownRec = UISwipeGestureRecognizer()
        
        swipeRightRec.addTarget(self, action: #selector(self.swipeR) )
        swipeRightRec.direction = .right
        self.view!.addGestureRecognizer(swipeRightRec)
        
        
        swipeLeftRec.addTarget(self, action: #selector(self.swipeL) )
        swipeLeftRec.direction = .left
        self.view!.addGestureRecognizer(swipeLeftRec)
        
    }
    
    @objc func swipeR() {
        
        self.tapPrevious(nil)
        
    }
    
    @objc func swipeL() {
        
        
        self.tapNext(nil)
        
        
    }
    var counter = 0
    @IBOutlet weak var mainimage: UIImageView!
    @IBOutlet weak var setupimage: UIImageView!
    @IBAction func tapNext(_ sender: AnyObject?) {
        
        
        if counter < images.count-1 {
            
            counter += 1
            
            setupimage.image = UIImage(named: "Setup\(counter)")
            print(counter)
            mainimage.image = images[counter]
            mainimage.slideInFromRight()
            
        }
        
        if counter == 0 {
            
            
            
        } else {
            
        }
        
    }
    
    @IBAction func tapPrevious(_ sender: AnyObject?) {
        
        
        if counter > 0  {
            
            counter -= 1
            
            setupimage.image = UIImage(named: "Setup\(counter)")
            print(counter)
            mainimage.image = images[counter]
            mainimage.slideInFromLeft()
            
        }
        
        if counter == 0 {
            
            
            
        } else {
            
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                self.tapNext(nil)
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                self.tapPrevious(nil)
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    var images = [UIImage]()
 
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as! CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    func slideInFromRight(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromRightTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromRightTransition.delegate = delegate as! CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromRightTransition.type = CATransitionType.push
        slideInFromRightTransition.subtype = CATransitionSubtype.fromRight
        slideInFromRightTransition.duration = duration
        slideInFromRightTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromRightTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromRightTransition, forKey: "slideInFromRightTransition")
    }
}
extension UIButton{
    
    func addTextSpacing(_ letterSpacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
}
