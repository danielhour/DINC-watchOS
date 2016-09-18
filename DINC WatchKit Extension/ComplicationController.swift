//
//  ComplicationController.swift
//  DINC WatchKit Extension
//
//  Created by dhour on 4/14/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import ClockKit


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
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date.today())
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    //---------------------------------------------------------------------------------------------------------
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: (@escaping (CLKComplicationTimelineEntry?) -> Void)) {
        magic("getCurrentTimeline")
        
        let currentMonth = UserDefaults.standard.integer(forKey: userDefaults.currentMonth)
        if currentMonth != Date.today().month {
            WTransactionManager.resetDataForNewMonth()
            UserDefaults.standard.set(Date.today().month, forKey: userDefaults.currentMonth)
        }
        
        currentMonthlyTotal = MonthlyBudgetManager.currentTotal()
        moneySpent = WTransactionManager.moneySpent()
        
        let template = configureTemplates(complication, safeToSpend: currentMonthlyTotal-moneySpent)
        let timelineEntry = CLKComplicationTimelineEntry(date: Date.today(), complicationTemplate: template)
        handler(timelineEntry)
        
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
        
        let tomorrow = Date.tomorrow().beginningOfDay
        let db = UserDefaults.standard.integer(forKey: userDefaults.dailyBudget)
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
    
    func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
        let endOfDay = Date().endOfDay
        magic("nextRequestedUpdateDate\(endOfDay)")
        
        handler(endOfDay)
    }
    
    func requestedUpdateDidBegin() {
        magic("requestedUpdateDidBegin")
        
        let server = CLKComplicationServer.sharedInstance()
        for complication in server.activeComplications! {
            server.reloadTimeline(for: complication)
        }
    }
    
    //---------------------------------------------------------------------------------------------------------
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        var template: CLKComplicationTemplate!
        switch complication.family {
            
        case .modularSmall:
            template = ComplicationConfigurations.modularSmallSimpleText("$--", textShort: nil, textColor: Theme.Colors.green)
            
        case .modularLarge:
            template = ComplicationConfigurations.modularLargeTallBody("Safe-to-Spend", body: "$-.--", bodyShort: nil)
            
        case .utilitarianSmall:
            template = ComplicationConfigurations.utilitarianSmallFlat("nil", text: "$-.--", textShort: nil)
            
        case .utilitarianLarge:
            template = ComplicationConfigurations.utilitarianLargeFlat("nil", text: "Safe-to-Spend: $-.--", textShort: nil)
            
        case .circularSmall:
            template = ComplicationConfigurations.circularSmallSimpleText("$--", textShort: nil)
            
        //TODO: exhaustive?
        default:
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
    fileprivate func configureTemplates(_ complication: CLKComplication, safeToSpend: Double) -> CLKComplicationTemplate {
        
        var savingsColor: UIColor!
        if safeToSpend < 0 {
            savingsColor = Theme.Colors.red
        } else {
            savingsColor = Theme.Colors.green
        }
        
        var template: CLKComplicationTemplate!
        switch complication.family {
            
        case .modularSmall:
            template = ComplicationConfigurations.modularSmallSimpleText("\(safeToSpend)".currencyFromString, textShort: "\(safeToSpend)".currencyNoDecimals, textColor: savingsColor)
            
        case .modularLarge:
            template = ComplicationConfigurations.modularLargeTallBody("Safe-to-Spend", body: "\(safeToSpend)".currencyFromString, bodyShort: "\(safeToSpend)".currencyNoDecimals)
            
        case .utilitarianSmall:
            template = ComplicationConfigurations.utilitarianSmallFlat("nil", text: "\(safeToSpend)".currencyFromString, textShort: "\(safeToSpend)".currencyFromString)
            
        case .utilitarianLarge:
            template = ComplicationConfigurations.utilitarianLargeFlat("nil", text: "Safe-to-Spend: " + "\(safeToSpend)".currencyFromString, textShort: "Safe-to-Spend: " + "\(safeToSpend)".currencyNoDecimals)
            
        case .circularSmall:
            template = ComplicationConfigurations.circularSmallSimpleText("\(safeToSpend)".currencyFromString, textShort: "\(safeToSpend)".currencyNoDecimals)
            
        //TODO: exhaustive?
        default:
            template = ComplicationConfigurations.circularSmallSimpleText("\(safeToSpend)".currencyFromString, textShort: "\(safeToSpend)".currencyNoDecimals)
        }
        
        return template
    }

}
