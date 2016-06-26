//
//  StatisticsController.swift
//  DINC
//
//  Created by dhour on 4/15/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Money
import WatchKit
import Timepiece
import Foundation


/**
 * Controller that displays the over/under projection of what a user's monthly total in disposable income spent will be.
 */
class ProjectionController: WKInterfaceController {
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - Properties

    ///
    var monthlyGoal: Double!
    ///
    var moneySpent: Double!
    ///
    var daysLeft: Int!
    ///
    var items = [WKPickerItem]()
    
    ///
    @IBOutlet var moneySpentLabel: WKInterfaceLabel!
    ///
    @IBOutlet var daysLeftInMonthLabel: WKInterfaceLabel!
    ///
    @IBOutlet var dailyBudgetPicker: WKInterfacePicker!
    ///
    @IBOutlet var projectedMoneySpentLabel: WKInterfaceLabel!
    ///
    @IBOutlet var overUnderTitleLabel: WKInterfaceLabel!
    ///
    @IBOutlet var overUnderAmountLabel: WKInterfaceLabel!
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - View Life Cycle
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }

    override func willActivate() {
        super.willActivate()
        
        self.configureStaticLabelsUI()
    }
    
    override func didAppear() {
        super.didAppear()
        
        self.configurePickerUI()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - IBActions
    
    ///
    @IBAction func dailyBudgetPickerAction(value: Int) {
        let projected = Double(daysLeft * value)
        let overUnder = monthlyGoal - moneySpent - projected
        projectedMoneySpentLabel.setText("\(projected)".currencyNoDecimals)
        overUnderAmountLabel.setText("\(Money(overUnder))")
        
        if overUnder < 0 {
            overUnderAmountLabel.setTextColor(Theme.Colors.red)
            overUnderTitleLabel.setTextColor(Theme.Colors.red)
        } else {
            overUnderAmountLabel.setTextColor(Theme.Colors.green)
            overUnderTitleLabel.setTextColor(Theme.Colors.green)
        }
    }
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - Helper Methods
    
    /**
     Configures the static labels UI
     */
    private func configureStaticLabelsUI() {
        monthlyGoal = MonthlyBudgetManager.fullMonth()
        moneySpent = WTransactionManager.moneySpent()
        daysLeft = NSDate.today().endOfMonth.day - NSDate.today().day
        
        moneySpentLabel.setText("\(Money(moneySpent))")
        daysLeftInMonthLabel.setText("\(daysLeft) Days Left")
    }
    
    /**
     Configures the number picker & sets the default number as the currently set daily budget
     */
    private func configurePickerUI() {
        self.dailyBudgetPicker.focus()
        
        guard items.isEmpty else { return }
        for index in 0...99 {
            let item = WKPickerItem()
            item.title = "\(index)".currencyNoDecimals
            items.append(item)
        }
        
        dailyBudgetPicker.setItems(items)
        let db = NSUserDefaults.standardUserDefaults().integerForKey(userDefaults.dailyBudget)
        dailyBudgetPicker.setSelectedItemIndex(db)
    }
    
    
}
