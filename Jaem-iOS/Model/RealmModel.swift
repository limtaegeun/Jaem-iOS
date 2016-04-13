//
//  RealmModel.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 13..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import RealmSwift

class UserInfo: Object {
    dynamic var userName = ""
    dynamic var email = ""
    override static func primaryKey() -> String? {
        return "userName"
    }
}


class MyBodySize: Object {
    dynamic var key = 0
    dynamic var date = NSDate()
    dynamic var height = 0
    dynamic var weight = 0
    dynamic var head = 0
    dynamic var neck = 0
    dynamic var shoulder = 0
    dynamic var chest = 0
    dynamic var upperArm = 0
    dynamic var waist = 0
    dynamic var hips = 0
    dynamic var thigh = 0
    dynamic var rise = 0
    dynamic var cuff = 0
    dynamic var legLength = 0
    
    override static func primaryKey() -> String? {
        return "key"
    }
}

