//
//  MakeURL.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 15..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

struct MyHost {
    var AmazonMainHost : String =  "http://www.jaemurbody.com"
    
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