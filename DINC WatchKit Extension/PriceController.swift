//
//  InterfaceController.swift
//  DINC WatchKit Extension
//
//  Created by dhour on 4/14/16.
//  Copyright © 2016 DHour. All rights reserved.
//


import WatchKit
import ClockKit
import Foundation
import RealmSwift
import Timepiece
import Money


/**
 * Controller that displays the 90s throwback casio calculator watch layout that allows a user to manually input their new transactions.
 */
class PriceController: WKInterfaceController {
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - Properties
    
    ///
    var currentMonthlyTotal: Double!
    ///
    var moneySpent: Double!
    
    ///
    var rawNumberEntry = String()
    
    ///
    @IBOutlet var safeToSpendLabel: WKInterfaceLabel!
    ///
    @IBOutlet var purchaseLabel: WKInterfaceLabel!
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - View Life Cycle
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.configureForceTouchMenu()
    }
    
    override func didAppear() {
        super.didAppear()
        
        self.checkForUserCreatedDailyBudget()
    }

    override func willActivate() {
        super.willActivate()
        
        self.configureUI()
    }

    override func didDeactivate() {
        super.didDeactivate()
        
    }
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - IBActions
    
    @IBAction func purchaseButtonAction() {
        if rawNumberEntry.isEmpty {
            DBAlert.denied(self, message: "A purchase of $0.00 is not allowed.")
            return
        }
        
        let amount = Double(rawNumberEntry)!/100
        WTransactionManager.addNewPurchase(NSDate(), amount: amount)
        ComplicationManager.reloadComplications()
        self.presentControllerWithName("UpdatedSavingsController", context: self)
        self.resetPurchaseLabel()
    }
    
    @IBAction func oneTapped() {
        self.appendNumber(1)
    }
    
    @IBAction func twoTapped() {
        self.appendNumber(2)
    }
    
    @IBAction func threeTapped() {
        self.appendNumber(3)
    }
    
    @IBAction func fourTapped() {
        self.appendNumber(4)
    }
    
    @IBAction func fiveTapped() {
        self.appendNumber(5)
    }
    
    @IBAction func sixTapped() {
        self.appendNumber(6)
    }
    
    @IBAction func sevenTapped() {
        self.appendNumber(7)
    }
    
    @IBAction func eightTapped() {
        self.appendNumber(8)
    }
    
    @IBAction func nineTapped() {
        self.appendNumber(9)
    }
    
    @IBAction func zeroTapped() {
        self.appendNumber(0)
    }
    
    @IBAction func backSpaceTapped() {
        rawNumberEntry = String(rawNumberEntry.characters.dropLast())
        purchaseLabel.setText(rawNumberEntry.currencyFromString)
        
        if rawNumberEntry.isEmpty {
            purchaseLabel.setText("$0.00")
        }
    }
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - Force Touch Methods

    
    /**
     Configures the Force Touch Menu
     
     - returns: Void
     */
    func configureForceTouchMenu() {
        self.addMenuItemWithImageNamed("Calendar", title: "Today Summary", action: #selector(PriceController.presentUpdatedSavingsController))
        self.addMenuItemWithImageNamed("Dollar_Sign", title: "Edit Daily $", action: #selector(PriceController.presentSetBugetController))
    }
    
    
    /**
     Presents the `UpdatedSavingsController`
     */
    func presentUpdatedSavingsController() {
        self.presentControllerWithName("UpdatedSavingsController", context: self)
    }
    
    
    /**
     Presents the `SetBudgetController`
     */
    func presentSetBugetController() {
        self.presentControllerWithName("SetBudgetController", context: self)
    }

    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - Helper Methods
    
    /**
     Checks to see if a user has created a daily budget. If not, presents the `SetBudgetController`
     */
    private func checkForUserCreatedDailyBudget() {
        let db = NSUserDefaults.standardUserDefaults().integerForKey(userDefaults.dailyBudget)
        guard db > 0 else {
            NSUserDefaults.standardUserDefaults().setInteger(NSDate.today().month, forKey: userDefaults.currentMonth)
            Utilities.delay(0.5, closure: { () in
                self.presentSetBugetController()
            })
            return
        }
    }
    
    
    /**
     Configures the UI
     */
    private func configureUI() {
        let db = NSUserDefaults.standardUserDefaults().integerForKey(userDefaults.dailyBudget)
        guard db > 0 else { return }
        
        currentMonthlyTotal = MonthlyBudgetManager.currentTotal()
        moneySpent = WTransactionManager.moneySpent()
        let safeToSpend = currentMonthlyTotal-moneySpent
        if safeToSpend < 0 {
            safeToSpendLabel.setTextColor(Theme.Colors.red)
        } else {
            safeToSpendLabel.setTextColor(Theme.Colors.green)
        }
        
        safeToSpendLabel.setText("\(Money(safeToSpend))")        
    }
    
    
    /**
     Converts user number entry into currency & updates the label display
     
     - parameter number:Int
     
     - returns: Void
     */
    private func appendNumber(number: Int) {
        let numberAsString = String(number)
        rawNumberEntry = rawNumberEntry.stringByAppendingString(numberAsString)
        purchaseLabel.setText(rawNumberEntry.currencyFromString)
    }

    
    /**
     Clears purchase label
     
     - returns: Void
     */
    private func resetPurchaseLabel() {
        rawNumberEntry.removeAll()
        purchaseLabel.setText("$0.00")
    }
}




