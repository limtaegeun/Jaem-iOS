//
//  JaemClothes.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 25..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class JaemClothes {
    var category : ClothesCategory
    var type : ClothesType
    var brand : String
    var name : String
    var image : UIImage
    var typicalSize = ""
    var requiredSizeData : AnyObject?
    var optionSizeData : AnyObject?
    
    init(category : ClothesCategory, type : ClothesType, brand : String, name : String, image : UIImage) {
        self.category = category
        self.type = type
        self.brand = brand
        self.name = name
        self.image = image
        
    }
    
    
    
}

class JaemCloshesDataSource {
    
    
    
}