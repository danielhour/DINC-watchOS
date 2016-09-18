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
    class func error(_ controller: WKInterfaceController, errorMessage: NSError) {
        let action = WKAlertAction(title: "OK", style: WKAlertActionStyle.default) { () -> Void in
            controller.dismiss()
        }
        
        controller.presentAlert(withTitle: "Error", message: "Apologies but we are having difficulty connecting to your iOS device. Please restart the app and try again.", preferredStyle: .actionSheet, actions: [action])
        
        //"\(errorMessage.debugDescription)"
    }
    
    /**
     Presents a denied alert controller
     
     - parameter controller: WKInterfaceController
     - parameter message: String
     
     - returns: Void
     */
    class func denied(_ controller: WKInterfaceController, message: String) {
        let action = WKAlertAction(title: "OK", style: WKAlertActionStyle.default) { () -> Void in
            controller.dismiss()
        }
        
        controller.presentAlert(withTitle: "Sorry", message: message, preferredStyle: .actionSheet, actions: [action])
    }
    
    /**
     Presents a Yes, Change, or Cancel Controller
     
     - parameter controller: WKInterfaceController
     - parameter category: String
     - parameter handler: Void
     
     - returns: Void
     */
    class func yesOrCancel(_ controller: WKInterfaceController, category: String, handler: @escaping ()->()) {
        
        let yes = WKAlertAction(title: "Yes", style: WKAlertActionStyle.default) { () -> Void in
            handler()
        }
        
        let cancel = WKAlertAction(title: "Cancel", style: WKAlertActionStyle.default) { () }

        controller.presentAlert(withTitle: "Add \(category)?", message: nil, preferredStyle: .alert, actions: [yes, cancel])
    }

    /**
     Deletes object from Database
     
     - parameter controller:WKInterfaceController
     - parameter handler: WKAlertActionHandler
     */
    class func deletePurchase(_ controller: WKInterfaceController, deleteHandler: @escaping WKAlertActionHandler) {
        
        let cancel = WKAlertAction(title: "Cancel", style: WKAlertActionStyle.cancel, handler: { })
        let delete = WKAlertAction(title: "DELETE", style: WKAlertActionStyle.destructive) { () -> Void in
            deleteHandler()
        }
        
        controller.presentAlert(withTitle: "Delete this purchase?", message: nil, preferredStyle: .actionSheet, actions: [delete, cancel])
    }
}
