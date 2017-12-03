//
//  StatisticsController.swift
//  DINC
//
//  Created by dhour on 4/15/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import WatchKit
import Foundation


/**
 * Controller that displays the over/under projection of what a user's monthly total in disposable income spent will be.
 */
class ProjectionController: WKInterfaceController {
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - Properties

    var monthlyGoal: Double!
    var moneySpent: Double!
    var daysLeft: Int!
    var items = [WKPickerItem]()
    
    @IBOutlet var moneySpentLabel: WKInterfaceLabel!
    @IBOutlet var daysLeftInMonthLabel: WKInterfaceLabel!
    @IBOutlet var dailyBudgetPicker: WKInterfacePicker!
    @IBOutlet var projectedMoneySpentLabel: WKInterfaceLabel!
    @IBOutlet var overUnderTitleLabel: WKInterfaceLabel!
    @IBOutlet var overUnderAmountLabel: WKInterfaceLabel!
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - View Life Cycle
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
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
    @IBAction func dailyBudgetPickerAction(_ value: Int) {
        let projected = Double(daysLeft * value)
        let overUnder = monthlyGoal - moneySpent - projected
        projectedMoneySpentLabel.setText("\(projected)".currencyNoDecimals)
        overUnderAmountLabel.setText("\(overUnder)".currencyFromString)
        
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
    fileprivate func configureStaticLabelsUI() {
        monthlyGoal = MonthlyBudgetManager.fullMonth()
        moneySpent = WTransactionManager.moneySpent()
        daysLeft = Date.today().endOfMonth.day - Date.today().day
        
        moneySpentLabel.setText("\(moneySpent!)".currencyFromString)
        daysLeftInMonthLabel.setText("\(daysLeft!) Days Left")
    }
    
    /**
     Configures the number picker & sets the default number as the currently set daily budget
     */
    fileprivate func configurePickerUI() {
        self.dailyBudgetPicker.focus()
        
        guard items.isEmpty else { return }
        for index in 0...99 {
            let item = WKPickerItem()
            item.title = "\(index)".currencyNoDecimals
            items.append(item)
        }
        
        dailyBudgetPicker.setItems(items)
        let db = UserDefaults.standard.integer(forKey: userDefaults.dailyBudget)
        dailyBudgetPicker.setSelectedItemIndex(db)
    }
    
    
}
