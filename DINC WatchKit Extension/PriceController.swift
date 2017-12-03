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


/**
 * Controller that displays the 90s throwback casio calculator watch layout that allows a user to manually input their new transactions.
 */
class PriceController: WKInterfaceController {
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - Properties
    
    var currentMonthlyTotal: Double!
    var moneySpent: Double!
    
    var rawNumberEntry = String()
    
    @IBOutlet var safeToSpendLabel: WKInterfaceLabel!
    @IBOutlet var purchaseLabel: WKInterfaceLabel!
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - View Life Cycle
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
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
        WTransactionManager.addNewPurchase(Date(), amount: amount)
        ComplicationManager.reloadComplications()
        self.presentController(withName: "UpdatedSavingsController", context: self)
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
        purchaseLabel.setText(rawNumberEntry.currencyAppend)
        
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
        self.addMenuItem(withImageNamed: "Calendar", title: "Today Summary", action: #selector(PriceController.presentUpdatedSavingsController))
        self.addMenuItem(withImageNamed: "Dollar_Sign", title: "Edit Daily $", action: #selector(PriceController.presentSetBugetController))
    }
    
    /**
     Presents the `UpdatedSavingsController`
     */
    func presentUpdatedSavingsController() {
        self.presentController(withName: "UpdatedSavingsController", context: self)
    }
    
    /**
     Presents the `SetBudgetController`
     */
    func presentSetBugetController() {
        self.presentController(withName: "SetBudgetController", context: self)
    }
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - Helper Methods
    
    /**
     Checks to see if a user has created a daily budget. If not, presents the `SetBudgetController`
     */
    fileprivate func checkForUserCreatedDailyBudget() {
        let db = UserDefaults.standard.integer(forKey: userDefaults.dailyBudget)
        guard db > 0 else {
            UserDefaults.standard.set(Date.today().month, forKey: userDefaults.currentMonth)
            Utilities.delay(0.5, closure: { () in
                self.presentSetBugetController()
            })
            return
        }
    }
    
    /**
     Configures the UI
     */
    fileprivate func configureUI() {
        let db = UserDefaults.standard.integer(forKey: userDefaults.dailyBudget)
        guard db > 0 else { return }
        
        currentMonthlyTotal = MonthlyBudgetManager.currentTotal()
        moneySpent = WTransactionManager.moneySpent()
        let safeToSpend = currentMonthlyTotal-moneySpent
        if safeToSpend < 0 {
            safeToSpendLabel.setTextColor(Theme.Colors.red)
        } else {
            safeToSpendLabel.setTextColor(Theme.Colors.green)
        }
        
        safeToSpendLabel.setText("\(safeToSpend)".currencyFromString)        
    }
    
    /**
     Converts user number entry into currency & updates the label display
     
     - parameter number:Int
     
     - returns: Void
     */
    fileprivate func appendNumber(_ number: Int) {
        let numberAsString = String(number)
        rawNumberEntry = rawNumberEntry + numberAsString
        purchaseLabel.setText(rawNumberEntry.currencyAppend)
    }
    
    /**
     Clears purchase label
     
     - returns: Void
     */
    fileprivate func resetPurchaseLabel() {
        rawNumberEntry.removeAll()
        purchaseLabel.setText("$0.00")
    }
}
