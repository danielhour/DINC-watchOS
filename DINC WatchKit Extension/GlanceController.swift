//
//  GlanceController.swift
//  DINC WatchKit Extension
//
//  Created by dhour on 4/14/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Money
import WatchKit
import Timepiece
import Foundation


/**
 * Object for watch glances
 */
struct GlanceObject {
    
    ///
    var date: NSDate
    ///
    var dateLabel: WKInterfaceLabel?
    ///
    var safeToSpend: Double
    ///
    var safeToSpendLabel: WKInterfaceLabel
    
    init(date: NSDate, dateLabel: WKInterfaceLabel?, safeToSpend: Double, safeToSpendLabel: WKInterfaceLabel) {
        
        self.date = date
        self.dateLabel = dateLabel
        self.safeToSpend = safeToSpend
        self.safeToSpendLabel = safeToSpendLabel
    }
}


/**
 * Controller for the watch glance
 */
class GlanceController: WKInterfaceController {

    
    //---------------------------------------------------------------------------------------------------------
    
    //MARK: - Properties
    
    ///
    var db: Int!
    
    ///
    @IBOutlet var dailyBudgetLabel: WKInterfaceLabel!
    
    ///
    @IBOutlet var futureGroup: WKInterfaceGroup!
    
    ///
    @IBOutlet var safeToSpendLabel: WKInterfaceLabel!
    ///
    @IBOutlet var currentSafeToSpendLabel: WKInterfaceLabel!
    
    ///
    @IBOutlet var dayPlusOneLabel: WKInterfaceLabel!
    ///
    @IBOutlet var safeToSpendPlusOneLabel: WKInterfaceLabel!
    
    ///
    @IBOutlet var dayPlusTwoLabel: WKInterfaceLabel!
    ///
    @IBOutlet var safeToSpendPlusTwoLabel: WKInterfaceLabel!
    
    ///
    @IBOutlet var dayPlusThreeLabel: WKInterfaceLabel!
    ///
    @IBOutlet var safeToSpendPlusThreeLabel: WKInterfaceLabel!
    
    
    //---------------------------------------------------------------------------------------------------------
    
    //MARK: - View Life Cycle
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }

    override func willActivate() {
        super.willActivate()
        
        self.configureUI()
    }

    override func didDeactivate() {
        super.didDeactivate()
        
    }
    
    
    //---------------------------------------------------------------------------------------------------------
    
    //MARK: - Helper Methods
    

    /**
     Configure the UI and if first time running the app, show "tap to get started". Otherwise, configure UI for today + next 3 day's `safeToSpend` data
     */
    private func configureUI() {
        db = NSUserDefaults.standardUserDefaults().integerForKey(userDefaults.dailyBudget)
        guard db > 0 else {
            let attributes = [NSFontAttributeName:UIFont.systemFontOfSize(25)]
            let attributedString = NSAttributedString(string: "Tap here to get started", attributes: attributes)
            currentSafeToSpendLabel.setAttributedText(attributedString)
            currentSafeToSpendLabel.setRelativeWidth(0.85, withAdjustment: 0)
            safeToSpendLabel.setHidden(true)
            futureGroup.setHidden(true)
            return
        }
        
        futureGroup.setHidden(false)
        safeToSpendLabel.setHidden(false)
        dailyBudgetLabel.setText("\(db)".currencyNoDecimals)
        
        self.configureGlanceObjects()
    }
    
    
    /**
     Configures the `GlanceObject` UI
     */
    private func configureGlanceObjects() {
        let all = glanceObjects()
        
        for object in all {
            object.dateLabel?.setText(object.date.dayOfWeek())
            
            if object.safeToSpendLabel == currentSafeToSpendLabel {
                object.safeToSpendLabel.setText("\(Money(object.safeToSpend))")
                if object.safeToSpend < 0 {
                    object.safeToSpendLabel.setTextColor(Theme.Colors.red)
                } else {
                    object.safeToSpendLabel.setTextColor(Theme.Colors.green)
                }
                
            } else {
                object.safeToSpendLabel.setText("\(object.safeToSpend)".currencyNoDecimals)
            }
        }
    }
    
    
    /**
     Creates `GlanceObjects` with date & forecasted `safeToSpend` figures for today and next 3 days
     
     - returns: [GlanceObject]
     */
    private func glanceObjects() -> [GlanceObject] {
        let currentMonthlyTotal = MonthlyBudgetManager.currentTotal()
        let moneySpent = WTransactionManager.moneySpent()
        let safeToSpend = currentMonthlyTotal-moneySpent
        
        let today = NSDate.today()
        let dplusOne = today + 1.day
        let dplusTwo = today + 2.day
        let dplusThree = today + 3.day
        
        let current = GlanceObject(date: today, dateLabel: nil,
                                   safeToSpend: safeToSpend, safeToSpendLabel: currentSafeToSpendLabel)
        
        let pOne = GlanceObject(date: dplusOne, dateLabel: dayPlusOneLabel,
                                safeToSpend: safeToSpend+Double(db), safeToSpendLabel: safeToSpendPlusOneLabel)
        
        let pTwo = GlanceObject(date: dplusTwo, dateLabel: dayPlusTwoLabel,
                                safeToSpend: safeToSpend+Double(db*2), safeToSpendLabel: safeToSpendPlusTwoLabel)
        
        let pThree = GlanceObject(date: dplusThree, dateLabel: dayPlusThreeLabel,
                                  safeToSpend: safeToSpend+Double(db*3), safeToSpendLabel: safeToSpendPlusThreeLabel)
        
        var all = [current, pOne, pTwo, pThree]
        
        if current.date.month != today.month {
            all[0].safeToSpend = Double(db)
            all[1].safeToSpend = Double(db*2)
            all[2].safeToSpend = Double(db*3)
            all[3].safeToSpend = Double(db*4)
            return all
        }
        
        if pOne.date.month != today.month {
            all[1].safeToSpend = Double(db)
            all[2].safeToSpend = Double(db*2)
            all[3].safeToSpend = Double(db*3)
            return all
        }
        
        if pTwo.date.month != today.month {
            all[2].safeToSpend = Double(db)
            all[3].safeToSpend = Double(db*2)
            return all
        }
        
        if pThree.date.month != today.month {
            all[3].safeToSpend = Double(db)
            return all
        }
        
        return all
    }

    
}
