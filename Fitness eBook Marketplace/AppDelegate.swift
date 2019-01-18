//
//  AppDelegate.swift
//  Fitness eBook Marketplace
//
//  Created by Alek Matthiessen on 1/11/19.
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

var didpurchase = Bool()
var tryingtopurchase = Bool()

protocol SnippetsPurchasesDelegate: AnyObject {
    
    func purchaseCompleted(product: String)
    
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var purchases: RCPurchases?
    weak var purchasesdelegate : SnippetsPurchasesDelegate?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        ref = Database.database().reference()
        purchases = RCPurchases(apiKey: "jLMuZLatPMLmTSoFKkaVNnTyXyAqYuaP")
        
        purchases!.delegate = self
        if Auth.auth().currentUser == nil {
            
//            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//
//            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Overview") as UIViewController
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            self.window?.rootViewController = initialViewControlleripad
//            self.window?.makeKeyAndVisible()//
//
            
        }  else {
            
            uid = (Auth.auth().currentUser?.uid)!
//            
//            queryforinfo()
//            
//            var tabBar: UITabBarController = self.window?.rootViewController as! UITabBarController
//            
//            
//            tabBar.selectedIndex = 0
//            
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func letsgo() {
        
        
        if Auth.auth().currentUser != nil {
            
            ref!.child("Users").child(uid).child("Purchased").child(selectedid).updateChildValues(["Title" : selectedtitle, "Author" : selectedauthor, "Price" : selectedprice, "Link" : selectedlink, "Image" : selectedimagelink])
            
            
            var tabBar: UITabBarController = self.window?.rootViewController as! UITabBarController
            
            
            
            tabBar.selectedIndex = 0
            
           

        } else {
            
           
            
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            
            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Register") as UIViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
        }
        
    }
    
    func queryforinfo() {
        
        var functioncounter = 0
        
        ref?.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var purchased = value?["Full Name"] as? String {
                
                thisdamnname = purchased
                
            }
            
            if var profileUrl = value?["ProPic"] as? String {
                // Create a storage reference from the URL
                
                let url = URL(string: profileUrl)
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                var selectedimage = UIImage(data: data!)!
                thisdamnphotourl = profileUrl
                thisdamnphoto = selectedimage
                
                
            }
            
        })
    }
        


}

extension AppDelegate: RCPurchasesDelegate {
    func purchases(_ purchases: RCPurchases, completedTransaction transaction: SKPaymentTransaction, withUpdatedInfo purchaserInfo: RCPurchaserInfo) {
        
        self.purchasesdelegate?.purchaseCompleted(product: transaction.payment.productIdentifier)
        
        didpurchase = true
        
        print("purchased")
        tryingtopurchase  = true
        letsgo()
        
    }
    
    func purchases(_ purchases: RCPurchases, receivedUpdatedPurchaserInfo purchaserInfo: RCPurchaserInfo) {
        //        handlePurchaserInfo(purchaserInfo)
        
        print(purchaserInfo)
        
    }
    
    func purchases(_ purchases: RCPurchases, failedToUpdatePurchaserInfoWithError error: Error) {
        print(error)
        
        tryingtopurchase = false
    }
    
    func purchases(_ purchases: RCPurchases, failedTransaction transaction: SKPaymentTransaction, withReason failureReason: Error) {
        print(failureReason)
        
        tryingtopurchase = false
    }
    
    func purchases(_ purchases: RCPurchases, restoredTransactionsWith purchaserInfo: RCPurchaserInfo) {
        //        handlePurchaserInfo(purchaserInfo)
        
        print("restored")
        tryingtopurchase  = true
        letsgo()
        
        
    }
    
    func purchases(_ purchases: RCPurchases, failedToRestoreTransactionsWithError error: Error) {
        print(error)
    }
}


