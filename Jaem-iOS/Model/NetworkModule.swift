//
//  NetworkModule.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 14..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class ParseJSON {
    class func parseJSONToDictionary(json:AnyObject) -> [String:AnyObject]? {
        if let dic = json as? [String:AnyObject] {
            return dic
        } else {
            return nil
        }
    }
}

class Alert {
    class func networkErrorAlertPresent(sender:UIViewController , title : String, message: String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "다시시도", style: .Default, handler: nil)
        alert.addAction(action)
        
        sender.presentViewController(alert, animated: true, completion: nil)
    }
}