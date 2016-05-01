//
//  ClothesDetailViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 12..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class ClothesDetailViewController: UIViewController {

    @IBOutlet weak var clothesBaseView: UIView!
    
    @IBOutlet weak var clothesImageView: UIImageView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addButtonView: AddButtonView!
    
    @IBOutlet weak var fitInfoView: FitInfoView!
    
    @IBOutlet weak var brandButton: UIButton!
    @IBOutlet weak var goStoreButton: BottomCardView!
    @IBOutlet weak var checkOtherButton: UIButton!
    
    var result : Result!
    var image : UIImage!
    var dataToAdd = [Clothes]()
    var userName : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        userName = realm.objects(UserInfo).first?.userName
        
        requestNetwork()
        clothesImageView.image = image
        
        // add gestrueRecognizer
        let tapGestrueRecognizer = UITapGestureRecognizer(target: self, action: #selector(ClothesDetailViewController.tapping(_:)))
        clothesBaseView.addGestureRecognizer(tapGestrueRecognizer)
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "유니클로")
        
        attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, 4))
        brandButton.titleLabel!.attributedText = attributeString
        
        let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: "CHECK OTHER PEOPLE'S CHOICE")
        
        attributeString2.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, 4))
        brandButton.titleLabel!.attributedText = attributeString2
        
        setFitInfoView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setFitInfoView() {
        fitInfoView.sizes = ["S","M","L","XL"]
        fitInfoView.setLabel()
    }
    
    //MARK: ACTION
    
    func tapping(recognizer : UITapGestureRecognizer)  {
        
        
        
    }
    
    func requestNetwork() {
        let url = MyHost().urlWtihPathNameAboutMainServer("user/recomend?name=" + userName + "&clothing_key=203")
        Alamofire.request(.GET, url!, encoding: .JSON).responseJSON { (response) in
            debugPrint(response)
            
            switch response.result {
            case .Success(let json):
                if json["stat"] as! String == "success" {
                    let array = json["result"] as![Dictionary<String,AnyObject>]
                    self.dataToAdd  = self.parseToObject(array)
                    
                } else {
                    
                }
            case .Failure(_): break
                
                
                
                
            }
        }
    }
    
    func parseToObject(array : [Dictionary<String,AnyObject>]) -> [Clothes] {
        var set = [Clothes]()
        for data in array {
            let object = Clothes()
            object.code = data["c_key"] as! Int
            let category = data["cloth_code"] as! Int
            object.category = parseClothesCategory(category).rawValue
            let gender = data["gender"] as! String
            object.gender = parseGender(gender).rawValue
            object.brand = result.brandKo
            object.name = result.name
            object.cost = data["price"] as! String
            object.image = UIImagePNGRepresentation(clothesImageView.image!)!
            object.typicalSize = data["size"] as! String
            
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
            print(object)
        }
        
        return set
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
