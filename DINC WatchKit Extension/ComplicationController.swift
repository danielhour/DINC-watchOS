//
//  ComplicationController.swift
//  DINC WatchKit Extension
//
//  Created by dhour on 4/14/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Money
import ClockKit
import Timepiece


/**
 * Configurations for Watch Complications
 */
class ComplicationController: NSObject, CLKComplicationDataSource {
    
    
    //---------------------------------------------------------------------------------------------------------
    // MARK: - Properties
    
    var currentMonthlyTotal: Double!
    var moneySpent: Double!
    
    
    //---------------------------------------------------------------------------------------------------------
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(NSDate.today())
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    
    //---------------------------------------------------------------------------------------------------------
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        magic("getCurrentTimeline")
        
        let currentMonth = NSUserDefaults.standardUserDefaults().integerForKey(userDefaults.currentMonth)
        if currentMonth != NSDate.today().month {
            WTransactionManager.resetDataForNewMonth()
            NSUserDefaults.standardUserDefaults().setInteger(NSDate.today().month, forKey: userDefaults.currentMonth)
        }
        
        currentMonthlyTotal = MonthlyBudgetManager.currentTotal()
        moneySpent = WTransactionManager.moneySpent()
        
        let template = configureTemplates(complication, safeToSpend: currentMonthlyTotal-moneySpent)
        let timelineEntry = CLKComplicationTimelineEntry(date: NSDate.today(), complicationTemplate: template)
        handler(timelineEntry)
        
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        
        let tomorrow = NSDate.tomorrow().beginningOfDay
        let db = NSUserDefaults.standardUserDefaults().integerForKey(userDefaults.dailyBudget)
        var tomorrowTemplate = configureTemplates(complication, safeToSpend: currentMonthlyTotal-moneySpent + Double(db))
        
        //new month
        if tomorrow.day == 1 {
            tomorrowTemplate = configureTemplates(complication, safeToSpend: Double(db))
        }
        
        let timelineEntry = CLKComplicationTimelineEntry(date: tomorrow, complicationTemplate: tomorrowTemplate)
        handler([timelineEntry])
    }
    
    
    //---------------------------------------------------------------------------------------------------------
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        let endOfDay = NSDate().endOfDay
        magic("nextRequestedUpdateDate\(endOfDay)")
        
        handler(endOfDay)
    }
    
    func requestedUpdateDidBegin() {
        magic("requestedUpdateDidBegin")
        
        let server = CLKComplicationServer.sharedInstance()
        for complication in server.activeComplications! {
            server.reloadTimelineForComplication(complication)
        }
    }
    
    
    //---------------------------------------------------------------------------------------------------------
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        var template: CLKComplicationTemplate!
        switch complication.family {
            
        case .ModularSmall:
            template = ComplicationConfigurations.modularSmallSimpleText("$--", textShort: nil, textColor: Theme.Colors.green)
            
        case .ModularLarge:
            template = ComplicationConfigurations.modularLargeTallBody("Safe-to-Spend", body: "$-.--", bodyShort: nil)
            
        case .UtilitarianSmall:
            template = ComplicationConfigurations.utilitarianSmallFlat("nil", text: "$-.--", textShort: nil)
            
        case .UtilitarianLarge:
            template = ComplicationConfigurations.utilitarianLargeFlat("nil", text: "Safe-to-Spend: $-.--", textShort: nil)
            
        case .CircularSmall:
            template = ComplicationConfigurations.circularSmallSimpleText("$--", textShort: nil)
        }
        
        handler(template)
    }
    
    
    //---------------------------------------------------------------------------------------------------------
    // MARK: - Helper Methods

    /**
     Configures complication templates for it's real data
     
     - parameter complication: CLKComplication
     - parameter safeToSpend: Double
     
     - returns: CLKComplicationTemplate
     */
    private func configureTemplates(complication: CLKComplication, safeToSpend: Double) -> CLKComplicationTemplate {
        
        var savingsColor: UIColor!
        if safeToSpend < 0 {
            savingsColor = Theme.Colors.red
        } else {
            savingsColor = Theme.Colors.green
        }
        
        var template: CLKComplicationTemplate!
        switch complication.family {
            
        case .ModularSmall:
            template = ComplicationConfigurations.modularSmallSimpleText("\(Money(safeToSpend))", textShort: "\(safeToSpend)".currencyNoDecimals, textColor: savingsColor)
            
        case .ModularLarge:
            template = ComplicationConfigurations.modularLargeTallBody("Safe-to-Spend", body: "\(Money(safeToSpend))", bodyShort: "\(safeToSpend)".currencyNoDecimals)
            
        case .UtilitarianSmall:
            template = ComplicationConfigurations.utilitarianSmallFlat("nil", text: "\(Money(safeToSpend))", textShort: "\(Money(safeToSpend))")
            
        case .UtilitarianLarge:
            template = ComplicationConfigurations.utilitarianLargeFlat("nil", text: "Safe-to-Spend: " + "\(Money(safeToSpend))", textShort: "Safe-to-Spend: " + "\(safeToSpend)".currencyNoDecimals)
            
        case .CircularSmall:
            template = ComplicationConfigurations.circularSmallSimpleText("\(Money(safeToSpend))", textShort: "\(safeToSpend)".currencyNoDecimals)
        }
        
        return template
    }

}
