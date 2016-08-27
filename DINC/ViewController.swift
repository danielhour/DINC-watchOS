//
//  ViewController.swift
//  Disposable
//
//  Created by dhour on 4/10/16.
//  Copyright © 2016 DHour. All rights reserved.
//

//import UIKit
//import Timepiece
//
//
//class ViewController: UIViewController {
//    
//    
//    //---------------------------------------------------------------------------------------------------------
//    
//    //MARK: - Properties
//    
//    let dailyBudget = 25
//    var totalMonthlyBudget: Int!
//    var currentMonthlyBudget: Int!
//    
//    let beginningOfMonth = NSDate.today().beginningOfMonth
//    let today = NSDate.today()
//    
//    let plaidService = PlaidService()
//    var transactions = [Transaction]()
//    
//    
//    //---------------------------------------------------------------------------------------------------------
//    
//    //MARK: - View Life Cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //self.addUser("", password: "", pin: nil)
//        
//        //self.submitMFAResponse(token, code: false, response: "")
//        
//        
//        totalMonthlyBudget = today.endOfMonth.day * dailyBudget
//        currentMonthlyBudget = today.day * dailyBudget
//        
//        
//        //self.getTransactionsStarting(beginningOfMonth.formatForPlaid, endDate: today.formatForPlaid)
//        
//        
//        //self.getBalance(token)
//        
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        
//    }
//    
//    
//    //---------------------------------------------------------------------------------------------------------
//    
//    //MARK: - Helper Methods
//    
//    
//    private func addUser(username: String, password: String, pin: String?) {
//        plaidService.PS_addUser(Type.Connect, username: username, password: password, pin: pin, institution: .chase) { (response, accessToken, mfaType, mfa, accounts, transactions, error) in
//            
//            magic(error)
//            magic(accessToken)
//            magic(response)
//            magic(mfaType)
//            magic(mfa)
//            magic(accounts)
//            magic(transactions)
//            
//            
//            
//            self.submitMFAResponse(accessToken, code: true, response: "phone")
//            
//            //add user
//            //get MFA response code
//            //use MFA code to send response "MFA" (?)
//            //get transactions
//            
//            
//            //store accesstoken?
//            
//            
//            //organization
//            //-- separate the Plaid file
//            //-- create github repository
//            //-- commit it empty and move all this to a dev branch?
//            
//            //git ignore
//            //-- KEYS
//            
//                        
//        }
//    }
//    
//    
//    private func submitMFAResponse(accessToken: String, code: Bool, response: String) {
//        plaidService.PS_submitMFAResponse(accessToken, code: code, response: response) { (response, accounts, transactions, error) in
//            
//            
//            magic(error)
//            magic(response)
//            magic(accounts)
//            magic(transactions)
//            
//            
//        }
//    }
//    
//    
//    /**
//     Fetches a user's transactions between the two dates provided
//     
//     - parameter beginDate: date with `String` format `yyyy-MM-dd`
//     - parameter endDate:   date with `String` format `yyyy-MM-dd`
//     */
//    private func getTransactionsStarting(beginDate: String, endDate: String) {
//        let params = Parameters.addTransactionParams(beginDate, endDate: endDate)
//        let request = PlaidService.Router.FetchTransactions(params.body)
//        
//        PlaidManager.fetchTransactions(request) { (fetchedTransactions) in
//            guard let transactions = fetchedTransactions else { return }
//            
//            
//            let fixedCosts = ["iTunes"]
//            let disposableTransactions = transactions.filter{!fixedCosts.contains($0.name)}
//            
//            for t in disposableTransactions {
//                if t.pending == true {
//                    magic("\(t.name) / \(t.date): $\(t.amount) (pending)")
//                } else {
//                    magic("\(t.name) / \(t.date): $\(t.amount)")
//                }
//            }
//            
//            
//            let disposableAmounts = disposableTransactions.map{$0.amount}.filter{$0 > 0}
//            let currentMonthlyExpenditures = disposableAmounts.reduce(0, combine: +)
//            
//            
//            magic("DINC monthly goal: $\(self.totalMonthlyBudget)")
//            magic("DINC spent so far this month: $\(currentMonthlyExpenditures)")
//            magic("DINC allotted so far this month: $\(self.currentMonthlyBudget)")
//            magic("current daily spend rate: $\(currentMonthlyExpenditures / Double(self.today.day))")
//            
//            
//            magic("DINC + FIXED = $\(transactions.map{$0.amount}.filter{$0 > 0}.reduce(0, combine: +))")
//        }
//    }
//    
//    
//    private func getBalance(accessToken: String) {
//        plaidService.PS_getUserBalance(accessToken) { (response, accounts, error) in
//            
//            magic(error)
//            magic(response)
//            magic(accounts)
//            
//        }
//        
//    }
//
//    
//}
//
