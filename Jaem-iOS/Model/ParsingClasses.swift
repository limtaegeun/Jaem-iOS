//
//  ParsingClasses.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 5. 4..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class Parse {
    var requiredBodySize = ["ShoulderWidth","BreastPeripheral","WaistCircumference","HipCircumference","ThighCircumference"]
    var optionalBodySize = ["head","neck","pelvis","upperArm","calf","reach","legLength"]
    
    
    class func parseIntToClothesCategory(int : Int) -> ClothesCategory {
        switch int {
        case 1:
            return ClothesCategory.OUTER
        case 2:
            return ClothesCategory.TOP
        case 3:
            return ClothesCategory.BOTTOM
        case 4:
            return ClothesCategory.SUIT
        case 5:
            return ClothesCategory.DRESS
        case 6:
            return ClothesCategory.ACC
        default:
            return ClothesCategory.ACC
        }
    }
    
    class func parseJSONToDictionary(json:AnyObject) -> [String:AnyObject]? {
        if let dic = json as? [String:AnyObject] {
            return dic
        } else {
            return nil
        }
    }
    
    class func parseToObjectWithImageURL(array : [Dictionary<String,AnyObject>]) -> [ClothesWithImageURL] {
        var set = [ClothesWithImageURL]()
        for data in array {
            let object = Clothes()
            let objectWithURL = ClothesWithImageURL()
            
            object.serverKey = data["c_key"] as! Int
            let category = data["cloth_code"] as! Int
            object.category = Parse.parseIntToClothesCategory(category).rawValue
            let gender = data["gender"] as! String
            object.gender = self.parseGender(gender).rawValue
            object.brand = data["brand_name_ko"] as! String
            object.name = data["title"] as! String
            object.cost = data["price"] as! String
            
            object.typicalSize = data["size"] as! String
            object.requiredSizeKey = data["main_size_key"] as! Int
            object.optionalSizeKey = data["sub_size_key"] as! Int
            //get size
            if let value = data["ShoulderWidth"] as? Double {
                if value != 0{
                    let size = Size()
                    size.title = "어깨너비"
                    size.value = value
                    
                    object.sizeRequired.append(size)
                    
                }
                
                
            }
            if let value = data["BreastSide"] as? Double {
                if value != 0{
                    let size = Size()
                    size.title = "가슴단면"
                    size.value = value
                    
                    object.sizeRequired.append(size)
                }
                
            }
            if let value = data["BreastPeripheral"] as? Double {
                if value != 0{
                    let size = Size()
                    size.title = "가슴둘레"
                    size.value = value
                    
                    object.sizeRequired.append(size)
                }
                
            }
            if let value = data["SleeveLength"] as? Double {
                if value != 0{
                    let size = Size()
                    size.title = "소매길이"
                    size.value = value
                    
                    object.sizeRequired.append(size)
                }
                
            }
            if let value = data["WaistSection"] as? Double {
                if value != 0{
                    let size = Size()
                    size.title = "허리단면"
                    size.value = value
                    
                    object.sizeRequired.append(size)
                }
                
            }
            if let value = data["WaistCircumference"] as? Double {
                if value != 0{
                    let size = Size()
                    size.title = "허리둘레"
                    size.value = value
                    
                    object.sizeRequired.append(size)
                }
                
            }
            if let value = data["HipSection"] as? Double {
                if value != 0{
                    let size = Size()
                    size.title = "엉덩이단면"
                    size.value = value
                    
                    object.sizeRequired.append(size)
                }
                
            }
            if let value = data["HipCircumference"] as? Double {
                if value != 0{
                    let size = Size()
                    size.title = "엉덩이둘레"
                    size.value = value
                    
                    object.sizeRequired.append(size)
                }
                
            }
            if let value = data["Thighsection"] as? Double {
                if value != 0{
                    let size = Size()
                    size.title = "허벅지단면"
                    size.value = value
                    
                    object.sizeRequired.append(size)
                }
                
            }
            if let value = data["ThighCircumference"] as? Double {
                if value != 0{
                    let size = Size()
                    size.title = "허벅지둘레"
                    size.value = value
                    
                    object.sizeRequired.append(size)
                }
                
            }
            if let value = data["Rise"] as? Double {
                if value != 0{
                    let size = Size()
                    size.title = "밑위"
                    size.value = value
                    
                    object.sizeRequired.append(size)
                }
                
            }
            if let value = data["TotalLength"] as? Double {
                if value != 0{
                    let size = Size()
                    size.title = "총기장"
                    size.value = value
                    
                    object.sizeRequired.append(size)
                }
                
            }
            objectWithURL.clothes = object
            objectWithURL.imageURLPath = data["color_front"] as! String
            
            set.append(objectWithURL)
            print(objectWithURL)
        }
        
        return set
    }
    
    class func parseGender(string : String) -> Gender {
        switch string {
        case "all":
            return Gender.Unisex
        case "men":
            return Gender.Male
        case "girl":
            return Gender.Female
        default:
            return Gender.Unisex
        }
    }
}
