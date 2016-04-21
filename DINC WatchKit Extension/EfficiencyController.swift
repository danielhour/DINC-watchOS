//
//  SpendRateController.swift
//  DINC
//
//  Created by dhour on 4/18/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Money
import WatchKit
import Timepiece
import Foundation


enum EfficiencyRatings: String {
    case Max = "SCROOGE MCDUCK" //0.0...0.4
    case High = "HIGH" //0.4...0.8
    case Normal = "NORMAL" //0.8...1.0
    case Bad = "NOT GREAT" //1.0...1.3
    case Poor = "POOR" //1.3...1.6
    case Awful = "JOHNNY FOOTBALL" //1.6 +
}


/**
 * Controller that displays a user's spending efficiency rating
 */
class EfficiencyController: WKInterfaceController {
    
    
    //---------------------------------------------------------------------------------------------------------
    
    //MARK: - Properties
    
    var averageDailySpend: Double!
    
    @IBOutlet var averageDailySpendLabel: WKInterfaceLabel!
    @IBOutlet var multiplierLabel: WKInterfaceLabel!
    @IBOutlet var efficiencyLabel: WKInterfaceLabel!
    
    
    //---------------------------------------------------------------------------------------------------------
    
    //MARK: - View Life Cycle
    

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }
    
    override func willActivate() {
        super.willActivate()
        
        self.configureDailySpendLabelUI()
        self.configureMultiplierAndEfficiencyUI()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        
    }
    
    
    //---------------------------------------------------------------------------------------------------------
    
    //MARK: - Helper Methods
    
    
    /**
     Configure the `averageDailySpendLabel` UI
     */
    private func configureDailySpendLabelUI() {
        let moneySpent = WTransactionManager.moneySpent()
        let numberOfDaysSoFar = NSDate.today().day
        averageDailySpend = moneySpent / Double(numberOfDaysSoFar)
        averageDailySpendLabel.setText("\(Money(averageDailySpend))")
    }
    
    
    /**
     Configure the `multiplierLabel` & `efficiencyLabel` UI
     */
    private func configureMultiplierAndEfficiencyUI() {
        let db = NSUserDefaults.standardUserDefaults().integerForKey(userDefaults.dailyBudget)
        let multiplierRaw = averageDailySpend / Double(db)
        let multiplier = Double(round(10*multiplierRaw)/10)
        multiplierLabel.setText("\(multiplier)X")
        
        switch multiplier {
        case 0...0.4:
            self.configureEfficiencyRatingLabel(.Max, color: colors.green)
        case 0.4...0.8:
            self.configureEfficiencyRatingLabel(.High, color: colors.lightGreen)
        case 0.8...1.0:
            self.configureEfficiencyRatingLabel(.Normal, color: colors.burntYellow)
        case 1.0...1.3:
            self.configureEfficiencyRatingLabel(.Bad, color: colors.orange)
        case 1.3...1.6:
            self.configureEfficiencyRatingLabel(.Poor, color: colors.darkOrange)
        case 1.6...Double.infinity:
            self.configureEfficiencyRatingLabel(.Awful, color: colors.red)
            
        default: magic("default firing")
        }
    }
    
    
    /**
     Configures the UI for the `EfficiencyLabel`
     
     - parameter rating: `EfficiencyRatings`
     - parameter color:  `UIColor`
     */
    private func configureEfficiencyRatingLabel(rating: EfficiencyRatings, color: UIColor) {
        efficiencyLabel.setText(rating.rawValue)
        efficiencyLabel.setTextColor(color)
        multiplierLabel.setTextColor(color)
    }
}





