//
//  RealmModel.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 13..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import RealmSwift

enum ClothesType : String {
    case runningShirt, Tshirts, sweater, shirts, vest, jacket, jumper, coats, padding, pants, shorts, skirt
}
enum Gender : String {
    case Male , Female, Unisex
}
enum ClothesCategory : String {
    case TOP,OUTER, BOTTOM, SUIT, DRESS, ACC
}


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
    dynamic var height  = 0.0
    dynamic var weight = 0.0
    dynamic var head = 0.0
    dynamic var neck = 0.0
    dynamic var shoulder = 0.0
    dynamic var chest = 0.0
    dynamic var upperArm = 0.0
    dynamic var wrist = 0.0
    dynamic var stomach = 0.0
    dynamic var shirtLength = 0.0
    dynamic var waist = 0.0
    dynamic var hips = 0.0
    dynamic var thigh = 0.0
    dynamic var rise = 0.0
    dynamic var cuff = 0.0
    dynamic var legLength = 0.0
    
    override static func primaryKey() -> String? {
        return "key"
    }
}

