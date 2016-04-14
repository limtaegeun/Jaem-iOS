//
//  NetworkModule.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 14..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

struct MyHost {
    var AmazonMainHost : String =  "http://ec2-52-193-85-231.ap-northeast-1.compute.amazonaws.com:9000"
    
    func urlWithPathName(PathName: String, host : String) -> NSURL? {
        let path = NSString(string: PathName)
        let newPath = path.stringByReplacingOccurrencesOfString(" ", withString: "+")
        let url = NSURL(string: host + "/" + newPath)
        return url
    }
    
    func urlWtihPathNameAboutMainServer(PathName: String) -> NSURL? {
        let path = NSString(string: PathName)
        let newPath = path.stringByReplacingOccurrencesOfString(" ", withString: "+")
        let url = NSURL(string: AmazonMainHost + "/" + newPath)
        return url
    }
}

class MySessionTask : NSObject {
    let host : String
    var sender : UIViewController
    var uploadTask : NSURLSessionUploadTask?
    
    init(sender:UIViewController) {
        self.sender = sender
        self.host = MyHost().AmazonMainHost
        
    }
    
    func dataTask(url :NSURL, complete: ((data : AnyObject?) -> Void)?, errorHandler : (() -> Void)?)  {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            if let httpResponse = response as? NSHTTPURLResponse,  let fields = httpResponse.allHeaderFields as? [String : String] {
                let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(fields, forURL: response!.URL!)
                NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookies(cookies, forURL: response!.URL!, mainDocumentURL: nil)
                /*
                 for cookie in cookies {
                 var cookieProperties = [String: AnyObject]()
                 cookieProperties[NSHTTPCookieName] = cookie.name
                 cookieProperties[NSHTTPCookieValue] = cookie.value
                 cookieProperties[NSHTTPCookieDomain] = cookie.domain
                 cookieProperties[NSHTTPCookiePath] = cookie.path
                 cookieProperties[NSHTTPCookieVersion] = NSNumber(integer: cookie.version)
                 cookieProperties[NSHTTPCookieExpires] = NSDate().dateByAddingTimeInterval(31536000)
                 
                 let newCookie = NSHTTPCookie(properties: cookieProperties)
                 NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(newCookie!)
                 }
                 */
                
            }
            
            
            if let error = error {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    print("Faile! \(error)")
                    self.showNetworkError()
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    if errorHandler != nil {
                        errorHandler!()
                    }
                })
                
                return
                
            } else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    print("success! \(response)")
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                })
                
            }
            let jsonData: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
            print("receiveData: \(jsonData)")
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if complete != nil {
                    complete!(data: jsonData)
                }
            })
        }
        dataTask.resume()
    }
    
    func uploadTask(dataToSend : Dictionary<String,AnyObject>,url :NSURL, complete:((data : AnyObject?) -> Void)?, errorHandler : (() -> Void)?)  {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        var receiveData : AnyObject?
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = NSURLSession.sharedSession()
        
        
        if NSJSONSerialization.isValidJSONObject(dataToSend) {
            let data = try? NSJSONSerialization.dataWithJSONObject(dataToSend, options: NSJSONWritingOptions())
            let result = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
            print("json:" + result )
            
            let task = session.uploadTaskWithRequest(request, fromData: data) {(data, response, error) -> Void in
                
                if let httpResponse = response as? NSHTTPURLResponse,  let fields = httpResponse.allHeaderFields as? [String : String] {
                    let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(fields, forURL: response!.URL!)
                    NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookies(cookies, forURL: response!.URL!, mainDocumentURL: nil)
                    /*
                     for cookie in cookies {
                     var cookieProperties = [String: AnyObject]()
                     cookieProperties[NSHTTPCookieName] = cookie.name
                     cookieProperties[NSHTTPCookieValue] = cookie.value
                     cookieProperties[NSHTTPCookieDomain] = cookie.domain
                     cookieProperties[NSHTTPCookiePath] = cookie.path
                     cookieProperties[NSHTTPCookieVersion] = NSNumber(integer: cookie.version)
                     cookieProperties[NSHTTPCookieExpires] = NSDate().dateByAddingTimeInterval(31536000)
                     
                     let newCookie = NSHTTPCookie(properties: cookieProperties)
                     NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(newCookie!)
                     }
                     */
                }
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                if error != nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        print("error")
                        self.showNetworkError()
                        if errorHandler != nil {
                            errorHandler!()
                        }
                    })
                    return
                }
                let jsonData: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
                print("receiveData: \(jsonData)")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    receiveData = jsonData
                    
                    if (complete != nil) {
                        complete!(data: jsonData) //complete closer
                    }
                })
                
                
                
            }
            task.resume()
        }
        
    }
    
    func showNetworkError() {
        let alert = UIAlertController(title: "Network Error", message: "There was an error reading from the Server. Please try again.", preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        
        sender.presentViewController(alert, animated: true, completion: nil)
    }
}