//
//  ParsingClasses.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 5. 4..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class Parse {
    
    func parseIntToClothesCategory(int : Int) -> ClothesCategory {
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
}
