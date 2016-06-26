//
//  UpdatedSavingsController.swift
//  DINC
//
//  Created by dhour on 4/15/16.
//  Copyright © 2016 DHour. All rights reserved.
//


import Money
import WatchKit
import Foundation


/**
 * Controller that displays the updated "Safe-to-spend" amount and a list of today's transactions
 */
class UpdatedSavingsController: WKInterfaceController {
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - Properties
    
    ///
    var todaysTransactions = [WTransaction]()
    
    ///
    var currentMonthlyTotal: Double!
    ///
    var moneySpent: Double!
    ///
    var safeToSpend: Double!
    
    ///
    @IBOutlet var savingsLabel: WKInterfaceLabel!
    ///
    @IBOutlet var todayTotalLabel: WKInterfaceLabel!
    ///
    @IBOutlet var todaysTransactionsTable: WKInterfaceTable!
    
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - View Life Cycle
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.setTitle("Close")
        self.configureSavingsUI()
        self.configureTodaysTransactionsTable()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - WKInterfaceTable Methods
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        DBAlert.deletePurchase(self) {
            WTransactionManager.deletePurchase(rowIndex)
            let indexSet = NSIndexSet(index: rowIndex)
            self.todaysTransactionsTable.removeRowsAtIndexes(indexSet)
            ComplicationManager.reloadComplications()
            self.configureSavingsUI()
            
            if self.todaysTransactionsTable.numberOfRows == 0 {
                self.todayTotalLabel.setHidden(true)
            }
        }
    }
    
    
    //---------------------------------------------------------------------------------------------------------
    //MARK: - Helper Methods
    
    /**
     Configures the Savings Label UI
     */
    private func configureSavingsUI() {
        currentMonthlyTotal = MonthlyBudgetManager.currentTotal()
        moneySpent = WTransactionManager.moneySpent()
        safeToSpend = currentMonthlyTotal-moneySpent
        
        if safeToSpend < 0 {
            savingsLabel.setTextColor(Theme.Colors.red)
        } else {
            savingsLabel.setTextColor(Theme.Colors.green)
        }
        
        savingsLabel.setText("\(Money(safeToSpend))")
        savingsLabel.sizeToFitWidth()
    }
    
    
    /**
     Configures the Purchase Table by...
     
     1 - sends an interactive message asking to fetch all purchases made from a specific date
     
     2 - populates the categories and cost of each purchase
     
     - returns: Void
     */
    private func configureTodaysTransactionsTable() {
        todayTotalLabel.setHidden(true)
       
        todaysTransactions = WTransactionManager.todaysTransactions()
        guard todaysTransactions.count > 0 else {
            todayTotalLabel.setHidden(true)
            return
        }
        
        todayTotalLabel.setHidden(false)
        
        //determine number of rows
        let indexes = NSIndexSet(indexesInRange: NSRange(0...todaysTransactions.count-1))
        todaysTransactionsTable.insertRowsAtIndexes(indexes, withRowType: "TransactionRow")
        
        //populate rows
        for (index, transaction) in todaysTransactions.enumerate() {
            let row = todaysTransactionsTable.rowControllerAtIndex(index) as! TransactionRow
            row.transactionAmountLabel.setText("\(Money(transaction.amount))")
        }
        
        //calculate today's total
        if !todaysTransactions.isEmpty {
            let sum = todaysTransactions.map{$0.amount}.reduce(0, combine: +)
            todayTotalLabel.setText("\(Money(sum))")
        }
    }
    
}
