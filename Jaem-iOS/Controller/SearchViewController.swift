//
//  SearchViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 11..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import HidingNavigationBar
import Alamofire

struct Result {
    var code : Int
    var name : String
    var brandKo : String
    var brandEn : String
    var ImageURLBack : String
    var ImageURLFront : String
    
}

enum Category : Int{
    case ALL = 0
    case OUTER
    case TOP
    case BOTTOM
    case SUIT
    case ACC
    
}

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    @IBOutlet weak var patternIcon: UIBarButtonItem!
    
    var hidingNavBarManager : HidingNavigationBarManager?
    var searchedText : String?
    
    var searchResults = [Result]()
    var hasSearched = false
    var categorys = [CategoryButton]()
    var currentCategory = Category.ALL
    var categoryView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //set tableview contentInset
        
        //set delegate
        searchBar.delegate = self
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        
        searchBar.text = searchedText
        /*
        //custom back button
        let backbuttonImage = JaemIconStyleKit.imageOfExitBlackArrow
        self.navigationController?.navigationBar.backIndicatorImage = backbuttonImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backbuttonImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
         */
        //hidingNavBarManager = HidingNavigationBarManager(viewController: self, scrollView: tableView)
        
        //search
        let url_encoding = searchedText!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        if let url = MyHost().urlWtihPathNameAboutMainServer("user/search?keyword="+url_encoding!+"&category=all&pagenation=0") {
            Alamofire.request(.GET, url, encoding:.JSON).responseJSON(completionHandler: { (response) in
                debugPrint(response)
                
                switch response.result {
                case .Success(let json):
                    if let dic = ParseJSON.parseJSONToDictionary(json) {
                        if dic["stat"] as! String == "success" {
                            self.parseToResultObject(dic)
                            self.searchCollectionView.reloadData()
                        } else {
                            Alert.networkErrorAlertPresent(self, title: "서버에 문제가 있습니다.", message: "다시 시도해보세요")
                        }
                    }
                    
                case .Failure(_):
                    Alert.networkErrorAlertPresent(self, title: "네트워크에 문제가 있습니다.", message: "다시 시도해보세요")
                    
                    
                    
                }
            })

        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hidingNavBarManager?.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //navigationBar background clearColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.translucent = true
        
        searchCollectionView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        let layout = UICollectionViewFlowLayout()
        let width = view.frame.width
        layout.itemSize = CGSize(width: width, height: 180)
        
        searchCollectionView.collectionViewLayout = layout
        
        categoryView = addExtensionView()
        view.addSubview(categoryView)
        
        patternIcon.image = JaemIconStyleKit.imageOfPattonIcon
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //hidingNavBarManager?.viewDidLayoutSubviews()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        hidingNavBarManager?.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseToResultObject(json :[String: AnyObject]) {
        searchResults.removeAll()
        if let array = json["result"] as? [AnyObject] {
            for data in array {
                let result = Result(code: data["c_key"]! as! Int,
                                    name: data["title"]! as! String,
                                    brandKo: data["brand_name_ko"] as! String,
                                    brandEn: data["brand_name_en"] as! String,
                                    ImageURLBack: data["color_back"] as! String,
                                    ImageURLFront: data["color_front"] as! String)
                searchResults.append(result)
            }
        }
        
        print(searchResults)
        
    }
    
    func addExtensionView() -> UIView {
        //init button
        let button1 = CategoryButton(frame: CGRect(x: 0, y: 0, width: 50, height: 22))
        button1.setTitle("ALL", forState: .Normal)
        let button2 = CategoryButton(frame: CGRect(x: 0, y: 0, width: 60, height: 22))
        button2.setTitle("OUTER", forState: .Normal)
        let button3 = CategoryButton(frame: CGRect(x: 0, y: 0, width: 50, height: 22))
        button3.setTitle("TOP", forState: .Normal)
        let button4 = CategoryButton(frame: CGRect(x: 0, y: 0, width: 70, height: 22))
        button4.setTitle("BOTTOM", forState: .Normal)
        let button5 = CategoryButton(frame: CGRect(x: 0, y: 0, width: 55, height: 22))
        button5.setTitle("SUIT", forState: .Normal)
        let button6 = CategoryButton(frame: CGRect(x: 0, y: 0, width: 50, height: 22))
        button6.setTitle("ACC", forState: .Normal)
        
        categorys = [button1,button2,button3,button4,button5,button6]
        
        //add to View
        let extensionView = UIView(frame: CGRect(x: 0, y: searchBar.frame.maxY , width: view.frame.width , height: 40))
        extensionView.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 236/255)
        let offsetX = (view.frame.width - 335) / 7
        let midY = extensionView.bounds.height/2
        var stackX : CGFloat = 0.0
        for i in 0...5 {
            extensionView.addSubview(categorys[i])
            
            categorys[i].center = CGPoint(x: stackX + offsetX * CGFloat(i + 1) + categorys[i].bounds.width/2, y: midY)
            stackX += categorys[i].bounds.width
        }
        
        categorys[0].changeFillAlpha(true)
        
        //set action
        for button in categorys {
            button.addTarget(self, action: #selector(SearchViewController.tapButton(_:)), forControlEvents: .TouchUpInside)
        }
        
        
        
        return extensionView
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "GoClothesDetail" {
            let dv = segue.destinationViewController as! ClothesDetailViewController
            let cell = sender as! SearchResultCell
            let indexRow = searchCollectionView.indexPathForCell(cell)
            dv.result = searchResults[indexRow!.row]
            dv.image = cell.clothesImage.image!
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

    //MARK : ACTION
    
    func tapButton(sender : CategoryButton) {
        for button in categorys {
            button.changeFillAlpha(false)
            
        }
        
        sender.changeFillAlpha(true)
        currentCategory = Category(rawValue: categorys.indexOf(sender)!)!
        print(currentCategory)
    }
    
    
    
    
}

extension SearchViewController : UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        
        let url_encoding = searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        if let url = MyHost().urlWtihPathNameAboutMainServer("user/search?keyword="+url_encoding!+"&category=all&pagenation=0") {
            Alamofire.request(.GET, url, encoding:.JSON).responseJSON(completionHandler: { (response) in
                debugPrint(response)
                
                switch response.result {
                case .Success(let json):
                    if let dic = ParseJSON.parseJSONToDictionary(json) {
                        if dic["stat"] as! String == "success" {
                            self.parseToResultObject(dic)
                            self.searchCollectionView.reloadData()
                        } else {
                            Alert.networkErrorAlertPresent(self, title: "서버에 문제가 있습니다.", message: "다시 시도해보세요")
                        }
                    }
                    
                case .Failure(_):
                    Alert.networkErrorAlertPresent(self, title: "네트워크에 문제가 있습니다.", message: "다시 시도해보세요")
                    
                }
            })
            
        }
        searchBar.resignFirstResponder()
    }
    
    //MARK : collectionView Delegate
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchResults.count == 0 {
            return 0
        } else {
            return searchResults.count
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SearchResultCell", forIndexPath: indexPath) as! SearchResultCell
        cell.brandLabel.text = searchResults[indexPath.row].brandKo
        cell.nameLabel.text = searchResults[indexPath.row].name
        cell.configureForImageResult(searchResults[indexPath.row].ImageURLFront)
        cell.result = searchResults[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        print("didSelect")
    }
    
    
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        hidingNavBarManager?.shouldScrollToTop()
        return true
    }
}










