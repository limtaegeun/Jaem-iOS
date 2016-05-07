//
//  SearchResultCell.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 11..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import Alamofire

class SearchResultCell: UICollectionViewCell {

    @IBOutlet weak var clothesImage: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    var result : Result!
    var dataToAdd = [Clothes]()
    var downloadTask : NSURLSessionDownloadTask?

    override func awakeFromNib() {
        super.awakeFromNib()
        addButton.setImage(JaemIconStyleKit.imageOfAddButton2(), forState: .Normal)
        // Initialization code
    }
    
    func configureForImageResult(urlPath : String)  {
        if let url = NSURL(string: urlPath) {
            downloadTask = clothesImage.loadImageWithURL(url, saveData: nil)
        }
        
    }

    @IBAction func tapAddToCloset(sender: AnyObject) {
        
        networkRequest()
        
    }
   

    func networkRequest() {
        let url = MyHost().urlWtihPathNameAboutMainServer("user/product/size?clothing_key=\(result.code)")
        Alamofire.request(.GET, url!, encoding: .JSON).responseJSON { (response) in
            debugPrint(response)
            
            switch response.result {
            case .Success(let json):
                if let dic = self.parseJSONToDictionary(json) {
                    if dic["stat"]  as! String == "success" {
                        if let array = dic["result"] as? [Dictionary<String,AnyObject>] {
                            self.dataToAdd  = self.parseToObject(array)
                            
                            var sizes = [String]()
                            for object in self.dataToAdd {
                                sizes.append(object.typicalSize)
                            }
                            
                            let sizeView = ClothesSaveView(frame: CGRect(x: 0, y: 0 ,width: self.frame.width, height: 52 )  , sizes: sizes, clothesSet : self.dataToAdd)
                            sizeView.center = CGPoint(x: CGRectGetMidX(self.bounds), y: CGRectGetMidY(self.bounds))
                            
                            self.addSubview(sizeView)
                            
                        }
                        
                        
                    } else {
                        
                    }
                }
            case .Failure(_): break
                
                
                
                
            }
        }
    }
    
    func parseJSONToDictionary(json:AnyObject) -> [String:AnyObject]? {
        if let dic = json as? [String:AnyObject] {
            return dic
        } else {
            return nil
        }
    }
    
    func parseClothesCategory(int : Int) -> ClothesCategory {
        switch int {
        case 0:
            return ClothesCategory.OUTER
        case 1:
            return ClothesCategory.TOP
        case 2:
            return ClothesCategory.BOTTOM
        case 3:
            return ClothesCategory.SUIT
        case 4:
            return ClothesCategory.DRESS
        case 5:
            return ClothesCategory.ACC
        default:
            return ClothesCategory.ACC
        }
    }
    
    func parseGender(string : String) -> Gender {
        switch string {
        case "all":
            return Gender.Unisex
        case "male":
            return Gender.Male
        case "female":
            return Gender.Female
        default:
            return Gender.Unisex
        }
    }
    
    func parseToObject(array : [Dictionary<String,AnyObject>]) -> [Clothes] {
        var set = [Clothes]()
        for data in array {
            let object = Clothes()
            object.serverKey = data["c_key"] as! Int
            let category = data["cloth_code"] as! Int
            object.category = parseClothesCategory(category).rawValue
            let gender = data["gender"] as! String
            object.gender = parseGender(gender).rawValue
            object.brand = result.brandKo
            object.name = result.name
            object.cost = data["price"] as! String
            object.image = UIImagePNGRepresentation(clothesImage.image!)!
            object.typicalSize = data["size"] as! String
            object.requiredSizeKey = data["main_size_key"] as! Int
            object.optionalSizeKey = data["sub_size_key"] as! Int
            
            //get size 
            if let value = data["ShoulderWidth"] as? Double {
                let size = Size()
                size.title = "shoulderWidth"
                size.value = value
                
                object.sizeRequired.append(size)
            }
            if let value = data["BreastSide"] as? Double {
                let size = Size()
                size.title = "chestLength"
                size.value = value
                
                object.sizeRequired.append(size)
            }
            if let value = data["BreastPeripheral"] as? Double {
                let size = Size()
                size.title = "bottomSize"
                size.value = value
                
                object.sizeRequired.append(size)
            }
            if let value = data["SleeveLength"] as? Double {
                let size = Size()
                size.title = "sleeveLength"
                size.value = value
                
                object.sizeRequired.append(size)
            }
            if let value = data["WaistSection"] as? Double {
                let size = Size()
                size.title = "waistLength"
                size.value = value
                
                object.sizeRequired.append(size)
            }
            if let value = data["WaistCircumference"] as? Double {
                let size = Size()
                size.title = "waistSize"
                size.value = value
                
                object.sizeRequired.append(size)
            }
            if let value = data["HipSection"] as? Double {
                let size = Size()
                size.title = "hipLength"
                size.value = value
                
                object.sizeRequired.append(size)
            }
            if let value = data["HipCircumference"] as? Double {
                let size = Size()
                size.title = "hipSize"
                size.value = value
                
                object.sizeRequired.append(size)
            }
            if let value = data["Thighsection"] as? Double {
                let size = Size()
                size.title = "thighLength"
                size.value = value
                
                object.sizeRequired.append(size)
            }
            if let value = data["ThighCircumference"] as? Double {
                let size = Size()
                size.title = "thighSize"
                size.value = value
                
                object.sizeRequired.append(size)
            }
            if let value = data["Rise"] as? Double {
                let size = Size()
                size.title = "rise"
                size.value = value
                
                object.sizeRequired.append(size)
            }
            if let value = data["TotalLength"] as? Double {
                let size = Size()
                size.title = "totalLength"
                size.value = value
                
                object.sizeRequired.append(size)
            }
            set.append(object)
        }
        return set
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        if downloadTask != nil {
            downloadTask?.cancel()
            downloadTask = nil
            
        }
        
        clothesImage.image = nil
        brandLabel.text = nil
        nameLabel.text = nil
    }
    
}
