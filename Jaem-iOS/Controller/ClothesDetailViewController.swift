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
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var fitInfoView: FitInfoView!
    
    @IBOutlet weak var brandButton: UIButton!
    @IBOutlet weak var goStoreButton: BottomCardView!
    @IBOutlet weak var checkOtherButton: UIButton!
    @IBOutlet weak var homeButton: UIBarButtonItem!
    
    
    var result : Result!
    var image : UIImage!
    var dataToAdd = [Clothes]()
    var userName : String!
    var recommendSize : String!
    var loaded = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        userName = realm.objects(UserInfo).last?.userName
        
        requestNetwork()
        clothesImageView.image = image
        
        
        addButton.setImage(JaemIconStyleKit.imageOfAddButton2(), forState: .Normal)
        homeButton.image = JaemIconStyleKit.imageOfHome
        
        brandLabel.text = dataToAdd.first?.brand
        categoryLabel.text = dataToAdd.first?.category
        nameLabel.text = dataToAdd.first?.name
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapping(_:)))
        tapGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        if loaded == false {
            loaded = true
            
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: dataToAdd.first!.brand)
            
            attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
            brandButton.setAttributedTitle(attributeString, forState: .Normal)
            
            let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: "CHECK OTHER PEOPLE'S CHOICE")
            
            attributeString2.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, 27))
            checkOtherButton.setAttributedTitle(attributeString2, forState: .Normal)
            
            setFitInfoView()
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setFitInfoView() {
        var sizes = [String]()
        for object in dataToAdd {
            sizes.append(object.typicalSize)
        }
        fitInfoView.sizes = sizes
        
        if let recommendIndex = sizes.indexOf(recommendSize) {
            fitInfoView.setLabel(recommendIndex + 1)
        }
        
        
    }
    
    func  setNamelabel() {
        brandLabel.text = dataToAdd.first?.brand
        categoryLabel.text = dataToAdd.first?.category
        nameLabel.text = dataToAdd.first?.name
    }
    
    func requestNetwork() {
        let url = MyHost().urlWtihPathNameAboutMainServer("user/recomend?name=" + "ori" + "&clothing_key=\(result.code)")
        Alamofire.request(.GET, url!, encoding: .JSON).responseJSON { (response) in
            debugPrint(response)
            
            switch response.result {
            case .Success(let json):
                if let dic = self.parseJSONToDictionary(json) {
                    if dic["stat"]  as! String == "success" {
                        if let array = dic["result"] as? [Dictionary<String,AnyObject>] {
                            self.dataToAdd  = self.parseToObject(array)
                            self.setNamelabel()
                        }
                        
                        self.recommendSize = dic["recomend"] as! String
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
    
    func parseToObject(array : [Dictionary<String,AnyObject>]) -> [Clothes] {
        var set = [Clothes]()
        for data in array {
            let object = Clothes()
            object.code = data["c_key"] as! Int
            let category = data["cloth_code"] as! Int
            object.category = Parse().parseIntToClothesCategory(category).rawValue
            let gender = data["gender"] as! String
            object.gender = parseGender(gender).rawValue
            object.brand = result.brandKo
            object.name = result.name
            object.cost = data["price"] as! String
            object.image = UIImagePNGRepresentation(clothesImageView.image!)!
            object.typicalSize = data["size"] as! String
            
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
            set.append(object)
            print(object)
        }
        
        return set
    }
    
    
    
    func parseGender(string : String) -> Gender {
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "GoCompare" {
            let dv = segue.destinationViewController as! FitSearchViewController
            dv.clothesSet = dataToAdd
            
            if sender === clothesImageView {
                dv.checkOtherClothes = false
            } else {
                dv.checkOtherClothes = true
            }
            
        }
            
        
    }
    
    
    //MARK : ACTION
    
    func tapping(recognizer : UITapGestureRecognizer)  {
        let location = recognizer.locationInView(view)
        let offSetY = clothesBaseView.frame.origin.y
        if CGRectContainsPoint(CGRectOffset(clothesImageView.frame, 0, offSetY), location) {
            
            performSegueWithIdentifier("GoCompare", sender: clothesImageView)
            
        }
    }
    
    @IBAction func tapAddButton(sender: AnyObject) {
        
        var sizes = [String]()
        for object in dataToAdd {
            sizes.append(object.typicalSize)
        }
        
        let saveView = ClothesSaveView(frame: CGRect(x: 0,y: 0,width: view.bounds.width, height: 50 ) , sizes: sizes, clothesSet: dataToAdd)
        let subView = view.viewWithTag(1)
        saveView.center.y = addButton.center.y + subView!.frame.origin.y
        
        view.addSubview(saveView)
    }
    
    @IBAction func tapCheckOther(sender: AnyObject) {
        performSegueWithIdentifier("GoCompare", sender: checkOtherButton)
        
    }

    
    @IBAction func tapHomeButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension ClothesDetailViewController : UIGestureRecognizerDelegate{
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        let offSetY = clothesBaseView.frame.origin.y

        if CGRectContainsPoint(CGRectOffset(clothesImageView.frame, 0, offSetY), touch.locationInView(view)) {
            return true
        } else {
            return false
        }
        
        
    
        
        
    }
}