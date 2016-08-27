//
//  Plaid.swift
//  Plaid Swift Wrapper
//
//  Created by Cameron Smith on 4/20/15.
//  Copyright (c) 2015 Cameron Smith. All rights reserved.
//


//import Foundation
//import Alamofire
//import SwiftyJSON
//
//
///**
// *
// */
//class PlaidService {
//    
//    ///
//    var currentRequest:Request?
//    ///
//    var allRequests:[Request]?
//    
//    
//    init(){
//        self.currentRequest = nil
//        self.allRequests = [Request]()
//    }
//    
//    
//    ///
//    enum Router: URLRequestConvertible {
//        
//        ///
//        case FetchTransactions([String: AnyObject])
//        
//        
//        ///
//        var method: Alamofire.Method {
//            switch self {
//            case .FetchTransactions:
//                return .POST
//            }
//        }
//        
//        ///
//        var path: String {
//            switch self {
//            case .FetchTransactions:
//                return "connect/get"
//            }
//        }
//        
//        ///
//        var URLRequest: NSMutableURLRequest {
//            let URL = NSURL(string: Constants.Plaid.baseURLString)!
//            let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
//            mutableURLRequest.HTTPMethod = method.rawValue
//            
//            switch self {
//            case .FetchTransactions(let parameters):
//                return ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
//            }
//        }
//    }
//    
//    
//    /**
//     Performs an API request
//     
//     ***.Success:*** convert value to JSON & pass it through the completion block
//     
//     ***.Failure:*** pass error through the completion block
//     
//     - parameter URLRequest: URLRequestConvertible
//     - parameter completion: ((error:NSError?, json: JSON?) ->())?)
//     
//     - returns: Void
//     */
//    func makeAPIRequest(URLRequest: URLRequestConvertible, completion: ((error:NSError?, json: JSON?) -> ())?) {
//        
//        currentRequest = request(URLRequest).responseJSON { (response) -> Void in
//            switch response.result {
//                
//            case .Success:
//                guard let value = response.result.value else {
//                    let userInfo = [NSLocalizedFailureReasonErrorKey : "Value could not be found."]
//                    let error = NSError(domain: "APIErrorWithJsonValueDomain", code: 404, userInfo: userInfo)
//                    completion!(error: error, json: nil)
//                    return
//                }
//                
//                let json = JSON(value)
//                completion!(error: nil, json: json)
//                
//            case .Failure(let error):
//                completion!(error: error, json: nil)
//            }
//        }
//        
//        allRequests!.append(self.currentRequest!)
//    }
//
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    //---------------------------------------------------------------------------------------------------------
//    
//    //MARK: - Properties
//    
//    let baseURL = Constants.Plaid.baseURLString
//    let clientId = Constants.Plaid.clientID
//    let secret = Constants.Plaid.secret
//    
//    
//    
//    //
//    func PS_addUser(userType: Type, username: String, password: String, pin: String?, institution: Institution, completion: (response: NSURLResponse?, accessToken:String, mfaType:String?, mfa:[[String:AnyObject]]?, accounts: [Account]?, transactions: [Transaction]?, error:NSError?) -> ()) {
//        
//        let institutionStr = institution.rawValue
//        let optionsDict: [String:AnyObject] = ["list":true]
//        let optionsDictStr = dictToString(optionsDict)
//        
//        var urlString:String?
//        if pin != nil {
//            urlString = "\(baseURL)connect?client_id=\(clientId)&secret=\(secret)&username=\(username)&password=\(password.encodValue)&pin=\(pin!)&type=\(institutionStr)&\(optionsDictStr.encodValue)"
//        }
//        else {
//            urlString = "\(baseURL)connect?client_id=\(clientId)&secret=\(secret)&username=\(username)&password=\(password.encodValue)&type=\(institutionStr)&options=\(optionsDictStr.encodValue)"
//        }
//        
//        let url:NSURL! = NSURL(string: urlString!)
//        let request = NSMutableURLRequest(URL: url)
//        request.HTTPMethod = "POST"
//        
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
//            data, response, error in
//            var mfaDict:[[String:AnyObject]]?
//            var type:String?
//            
//            do {
//                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
//                guard jsonResult?.valueForKey("code") as? Int != 1303 else { throw PlaidError.InstitutionNotAvailable }
//                guard jsonResult!.valueForKey("code") as? Int != 1200 else {throw PlaidError.InvalidCredentials(jsonResult!.valueForKey("resolve") as! String)}
//                guard jsonResult!.valueForKey("code") as? Int != 1005 else {throw PlaidError.CredentialsMissing(jsonResult!.valueForKey("resolve") as! String)}
//                guard jsonResult!.valueForKey("code") as? Int != 1601 else {throw PlaidError.InstitutionNotAvailable}
//                
//                if let token:String = jsonResult?.valueForKey("access_token") as? String {
//                    if let mfaResponse = jsonResult!.valueForKey("mfa") as? [[String:AnyObject]] {
//                        mfaDict = mfaResponse
//                        if let typeMfa = jsonResult!.valueForKey("type") as? String {
//                            type = typeMfa
//                        }
//                        completion(response: response, accessToken: token, mfaType: type, mfa: mfaDict, accounts: nil, transactions: nil, error: error)
//                    } else {
//                        let acctsArray:[[String:AnyObject]] = jsonResult?.valueForKey("accounts") as! [[String:AnyObject]]
//                        let accts = acctsArray.map{Account(account: $0)}
//                        let trxnArray:[[String:AnyObject]] = jsonResult?.valueForKey("transactions") as! [[String:AnyObject]]
//                        let trxns = trxnArray.map{Transaction(transaction: $0)}
//                        
//                        completion(response: response, accessToken: token, mfaType: nil, mfa: nil, accounts: accts, transactions: trxns, error: error)
//                    }
//                } else {
//                    //Handle invalid cred login
//                }
//                
//            } catch {
//                magic("Error \(error)")
//            }
//            
//        })
//        task.resume()
//    }
//    
//    
//    
//    func PS_submitMFAResponse(accessToken: String, code:Bool?, response: String, completion: (response: NSURLResponse?, accounts: [Account]?, transactions: [Transaction]?, error: NSError?) -> ()) {
//        var urlString:String?
//        
//        let optionsDict: [String:AnyObject] = ["send_method": ["type":response]]
//        let optionsDictStr = dictToString(optionsDict)
//        
//        if code == true {
//            urlString = "\(baseURL)connect/step?client_id=\(clientId)&secret=\(secret)&access_token=\(accessToken)&options=\(optionsDictStr.encodValue)"
//            magic("urlString: \(urlString!)")
//        } else {
//            urlString = "\(baseURL)connect/step?client_id=\(clientId)&secret=\(secret)&access_token=\(accessToken)&mfa=\(response.encodValue)"
//            magic("urlString: \(urlString!)")
//        }
//        
//        let url:NSURL! = NSURL(string: urlString!)
//        let request = NSMutableURLRequest(URL: url)
//        request.HTTPMethod = "POST"
//        
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
//            data, response, error in
//            
//            do {
//                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
//                
//                magic(jsonResult)
//                
//                guard jsonResult?.valueForKey("code") as? Int != 1303 else { throw PlaidError.InstitutionNotAvailable }
//                guard jsonResult?.valueForKey("code") as? Int != 1203 else { throw PlaidError.IncorrectMfa(jsonResult!.valueForKey("resolve") as! String)}
//                guard jsonResult?.valueForKey("accounts") != nil else { throw JsonError.Empty }
//                
//                let acctsArray:[[String:AnyObject]] = jsonResult?.valueForKey("accounts") as! [[String:AnyObject]]
//                let accts = acctsArray.map{Account(account: $0)}
//                let trxnArray:[[String:AnyObject]] = jsonResult?.valueForKey("transactions") as! [[String:AnyObject]]
//                let trxns = trxnArray.map{Transaction(transaction: $0)}
//                
//                completion(response: response, accounts: accts, transactions: trxns, error: error)
//                
//            } catch {
//                magic("error: \(error)")
//            }
//        })
//        
//        task.resume()
//    }
//    
//    
//    //MARK: Get balance
//    func PS_getUserBalance(accessToken: String, completion: (response: NSURLResponse?, accounts:[Account], error:NSError?) -> ()) {
//        
//        let urlString:String = "\(baseURL)balance?client_id=\(clientId)&secret=\(secret)&access_token=\(accessToken)"
//        let url:NSURL! = NSURL(string: urlString)
//        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
//            data, response, error in
//            
//            do {
//                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
//                magic("jsonResult: \(jsonResult!)")
//                guard jsonResult?.valueForKey("code") as? Int != 1303 else { throw PlaidError.InstitutionNotAvailable }
//                guard jsonResult?.valueForKey("code") as? Int != 1105 else { throw PlaidError.BadAccessToken }
//                guard let dataArray:[[String:AnyObject]] = jsonResult?.valueForKey("accounts") as? [[String : AnyObject]] else { throw JsonError.Empty }
//                let userAccounts = dataArray.map{Account(account: $0)}
//                completion(response: response, accounts: userAccounts, error: error)
//                
//            } catch {
//                magic("JSON parsing error (PS_getUserBalance): \(error)")
//            }
//        }
//        task.resume()
//    }
//
//    
//    //---------------------------------------------------------------------------------------------------------
//    
//    //MARK: - Private Helper Methods
//    
//    
//    private func dictToString(value: AnyObject) -> NSString {
//        if NSJSONSerialization.isValidJSONObject(value) {
//            
//            do {
//                let data = try NSJSONSerialization.dataWithJSONObject(value, options: NSJSONWritingOptions.PrettyPrinted)
//                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
//                    return string
//                }
//            } catch _ as NSError {
//                print("JSON Parsing error")
//            }
//        }
//        return ""
//    }
//    
//}
//
//
//
//
//
//
//
//
