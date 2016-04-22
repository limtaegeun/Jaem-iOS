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
    case shortsleevedTshirts, runningShirt, longsleevedTshirts, sweater, shirts, vest, jacket, jumper, cardigan, coats, heavyOuter, pants, shorts, skirt
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
    dynamic var index = 0
    dynamic var date = NSDate()
    dynamic var shoulder = 0.0
    dynamic var chest = 0.0
    dynamic var waist = 0.0
    dynamic var hips = 0.0
    dynamic var thigh = 0.0
    
    dynamic var head = 0.0
    dynamic var neck = 0.0
    dynamic var pelvis = 0.0
    dynamic var upperArm = 0.0
    dynamic var calf = 0.0
    dynamic var reach = 0.0
    dynamic var legLength = 0.0
    
    dynamic var height  = 0.0
    dynamic var weight = 0.0
    
    
    
    override static func primaryKey() -> String? {
        return "index"
    }
}

class SizeRecommend: Object {
    dynamic var category : String = ""
    dynamic var type : String = ""
    dynamic var shoulderWidth = 0.0 // 어께너비
    dynamic var chestSize = 0.0 // 가슴둘레
    dynamic var chestLength = 0.0 //가슴단면
    dynamic var armHole = 0.0  // 암홀
    dynamic var waistSize = 0.0 // 허리둘레
    dynamic var waistLength = 0.0 // 허리단면
    dynamic var hipSize = 0.0 // 엉덩이둘레
    dynamic var hipLength = 0.0 // 엉덩이 단면
    dynamic var thighSize = 0.0 // 허벅지둘레
    dynamic var thighLength = 0.0 // 허벅지단면
    
    
}

class TopAndOuter: Object {
    dynamic var code = 0
    dynamic var category : String = ""
    dynamic var type : String = ""
    dynamic var gender = ""
    dynamic var brand = ""
    dynamic var name  = ""
    dynamic var cost = ""
    dynamic var image = NSData()
    dynamic var sizeRequired : TopSizeRequired?
    dynamic var siseOption : TopSizeOption?
    let anotherColor = List<TopAndOuter>()
    override static func primaryKey() -> String? {
        return "code"
    }
}

class Bottom: Object {
    dynamic var code = 0
    dynamic var category : String = ""
    dynamic var type : String = ""
    dynamic var gender = ""
    dynamic var brand = ""
    dynamic var name  = ""
    dynamic var cost = ""
    dynamic var image = NSData()
    dynamic var sizeRequired : BottomSizeRequired?
    dynamic var siseOption : BottomSizeOption?
    let anotherColor = List<Bottom>()
    override static func primaryKey() -> String? {
        return "code"
    }
}

class SuitTop: Object {
    dynamic var code = 0
    dynamic var category : String = ""
    dynamic var type : String = ""
    dynamic var gender = ""
    dynamic var brand = ""
    dynamic var name  = ""
    dynamic var cost = ""
    dynamic var image = NSData()
    dynamic var sizeRequired : SuitTopSizeRequired?
    dynamic var siseOption : SuitTopSizeOption?
    let anotherColor = List<SuitTop>()
    override static func primaryKey() -> String? {
        return "code"
    }
}

class SuitBottom: Object {
    dynamic var code = 0
    dynamic var category : String = ""
    dynamic var type : String = ""
    dynamic var gender = ""
    dynamic var brand = ""
    dynamic var name  = ""
    dynamic var cost = ""
    dynamic var image = NSData()
    dynamic var sizeRequired : BottomSizeRequired?
    dynamic var siseOption : SuitBottomSizeOption?
    let anotherColor = List<SuitBottom>()
    override static func primaryKey() -> String? {
        return "code"
    }
}

class TopSizeRequired : Object {
    dynamic var shoulderWidth = 0.0 // 어께너비
    dynamic var chestSize = 0.0 // 가슴둘레
    dynamic var chestLength = 0.0 //가슴단면
    dynamic var sleeveLength = 0.0 // 소매길이
    dynamic var totalLength = 0.0 //총기장
    
    
}

class TopSizeOption : Object {
    dynamic var armHole = 0.0  // 암홀
    dynamic var armSize = 0.0   //팔 둘레
    dynamic var armLength = 0.0 // 팔단면
    dynamic var bottomSize = 0.0 // 밑단둘레
    dynamic var bottomLength = 0.0 // 밑단단면 
    dynamic var sleeveSize = 0.0 //소매둘레
    dynamic var sleeveLength = 0.0 // 소매단면
    dynamic var neckDepth  = 0.0  //네크 깊이
    dynamic var neckWidth = 0.0   // 네크 넓이
    dynamic var frontTotalLength = 0.0 // 앞 총기장
    dynamic var backTotalLength = 0.0 // 뒷 총기장
    dynamic var neckHeight = 0.0 // 네크 높이
}

class BottomSizeRequired: Object {
    dynamic var waistSize = 0.0 // 허리둘레
    dynamic var waistLength = 0.0 // 허리단면
    dynamic var hipSize = 0.0 // 엉덩이둘레
    dynamic var hipLength = 0.0 // 엉덩이 단면
    dynamic var thighSize = 0.0 // 허벅지둘레
    dynamic var thighLength = 0.0 // 허벅지단면
    dynamic var rise = 0.0 // 밑위
    dynamic var totalLength = 0.0 // 총기장
    
}

class BottomSizeOption: Object {
    dynamic var bottomSize = 0.0 // 밑단둘레
    dynamic var bottomLength = 0.0 // 밑단단면
    dynamic var frontTotalLength = 0.0 // 앞 총기장
    dynamic var backTotalLength = 0.0 // 뒷 총기장
}

class SuitTopSizeRequired: Object {
    dynamic var shoulderWidth = 0.0 // 어께너비
    dynamic var chestSize = 0.0 // 가슴둘레
    dynamic var chestLength = 0.0 //가슴단면
    dynamic var waistSize = 0.0 // 허리둘레
    dynamic var waistLength = 0.0 // 허리단면
    dynamic var sleeveLength = 0.0 // 소매길이
    dynamic var totalLength = 0.0 //총기장
}

class SuitTopSizeOption: Object {
    dynamic var armHole = 0.0  // 암홀
    dynamic var armSize = 0.0   //팔 둘레
    dynamic var armLength = 0.0 // 팔단면
    dynamic var bottomSize = 0.0 // 밑단둘레
    dynamic var bottomLength = 0.0 // 밑단단면
    dynamic var sleeveSize = 0.0 //소매둘레
    dynamic var sleeveLength = 0.0 // 소매단면
    dynamic var frontTotalLength = 0.0 // 앞 총기장
    dynamic var backTotalLength = 0.0 // 뒷 총기장
    dynamic var lapelsWidth = 0.0 // 라펠폭
}

class SuitBottomSizeOption: Object {
    dynamic var bottomSize = 0.0 // 밑단둘레
    dynamic var bottomLength = 0.0 // 밑단단면
    dynamic var kneeSize = 0.0 // 무릎 둘레
    dynamic var kneeLength = 0.0 //무릎 단면
    dynamic var frontRiseLength = 0.0 // 앞밑위길이
    dynamic var backRiseLength = 0.0 // 뒷밑위길이
    dynamic var inseam = 0.0        // 인심
}

class DressSizeRequired: Object {
    dynamic var shoulderWidth = 0.0 // 어께너비
    dynamic var chestSize = 0.0 // 가슴둘레
    dynamic var chestLength = 0.0 //가슴단면
    dynamic var waistSize = 0.0 // 허리둘레
    dynamic var waistLength = 0.0 // 허리단면
    dynamic var hipSize = 0.0 // 엉덩이둘레
    dynamic var hipLength = 0.0 // 엉덩이 단면
    dynamic var sleeveLength = 0.0 // 소매길이
    dynamic var totalLength = 0.0 //총기장
}

class DressSizeOption: Object {
    dynamic var armHole = 0.0  // 암홀
    dynamic var armSize = 0.0   //팔 둘레
    dynamic var armLength = 0.0 // 팔단면
    dynamic var bottomSize = 0.0 // 밑단둘레
    dynamic var bottomLength = 0.0 // 밑단단면
    dynamic var sleeveSize = 0.0 //소매둘레
    dynamic var sleeveLength = 0.0 // 소매단면
    dynamic var neckDepth  = 0.0  //네크 깊이
    dynamic var neckWidth = 0.0   // 네크 넓이
    dynamic var frontTotalLength = 0.0 // 앞 총기장
    dynamic var backTotalLength = 0.0 // 뒷 총기장
    dynamic var neckHeight = 0.0 // 네크 높이

}




