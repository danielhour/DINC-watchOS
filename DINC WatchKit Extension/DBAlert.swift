//
//  DBAlert.swift
//  DailyBudget
//
//  Created by dhour on 10/27/15.
//  Copyright © 2015 DHour. All rights reserved.
//

import WatchKit
import WatchConnectivity


class DBAlert {

    
    /**
    Presents an error alert controller
    
    - parameter controller:WKInterfaceController
    - parameter errorMessage: NSError
    
    - returns: Void
    */
    class func error(controller: WKInterfaceController, errorMessage: NSError) {
        let action = WKAlertAction(title: "OK", style: WKAlertActionStyle.Default) { () -> Void in
            controller.dismissController()
        }
        
        controller.presentAlertControllerWithTitle("Error", message: "Apologies but we are having difficulty connecting to your iOS device. Please restart the app and try again.", preferredStyle: .ActionSheet, actions: [action])
        
        //"\(errorMessage.debugDescription)"
    }
    
    
    /**
     Presents a denied alert controller
     
     - parameter controller: WKInterfaceController
     - parameter message: String
     
     - returns: Void
     */
    class func denied(controller: WKInterfaceController, message: String) {
        let action = WKAlertAction(title: "OK", style: WKAlertActionStyle.Default) { () -> Void in
            controller.dismissController()
        }
        
        controller.presentAlertControllerWithTitle("Sorry", message: message, preferredStyle: .ActionSheet, actions: [action])
    }


    /**
     Presents a Yes, Change, or Cancel Controller
     
     - parameter controller: WKInterfaceController
     - parameter category: String
     - parameter handler: Void
     
     - returns: Void
     */
    class func yesOrCancel(controller: WKInterfaceController, category: String, handler: ()->()) {
        
        let yes = WKAlertAction(title: "Yes", style: WKAlertActionStyle.Default) { () -> Void in
            handler()
        }
        
        let cancel = WKAlertAction(title: "Cancel", style: WKAlertActionStyle.Default) { () }

        controller.presentAlertControllerWithTitle("Add \(category)?", message: nil, preferredStyle: .Alert, actions: [yes, cancel])
    }

    
    /**
     Deletes object from Database
     
     - parameter controller:WKInterfaceController
     - parameter handler: WKAlertActionHandler
     */
    class func deletePurchase(controller: WKInterfaceController, deleteHandler: WKAlertActionHandler) {
        
        let cancel = WKAlertAction(title: "Cancel", style: WKAlertActionStyle.Cancel, handler: { })
        let delete = WKAlertAction(title: "DELETE", style: WKAlertActionStyle.Destructive) { () -> Void in
            deleteHandler()
        }
        
        controller.presentAlertControllerWithTitle("Delete this purchase?", message: nil, preferredStyle: .ActionSheet, actions: [delete, cancel])
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}