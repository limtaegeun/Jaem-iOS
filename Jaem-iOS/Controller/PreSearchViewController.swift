//
//  PreSearchViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 13..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import Alamofire

class PreSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var fromNowView: UIView!
    @IBOutlet weak var myFavoriteBrandView: UIView!
    @IBOutlet weak var barcodeButton: UIBarButtonItem!
    @IBOutlet weak var exitButton: UIBarButtonItem!
    
    private var fromNowSet = [String]()
    private var favoriteBrandSet = [String]()
    
    private var tableView : UITableView!
    private var relatedSearch = [String]()
    private var recentlySearch = [String]()
    
    private var typeSearchText = false
    private var searchedText : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteBrandSet = dummyBrand()
        
        //download keyword Ranking
        if let url = MyHost().urlWtihPathNameAboutMainServer("user/rank/keyword") {
            Alamofire.request(.GET, url, encoding: .JSON).responseJSON(completionHandler: { (response) in
                debugPrint(response)
                
                switch response.result {
                case .Success(let json):
                    if let dic = self.parseJSONToDictionary(json) {
                        if dic["stat"] as! String == "success" {
                            self.fromNowSet = self.parseToArray(dic["rank_keyword"]!)
                            self.setButtons(self.fromNowSet, view: self.fromNowView, action: #selector(PreSearchViewController.tapping(_:)))
                        } else {
                            self.alertPresent("서버에 문제가 있습니다.", message: "다시 시도해보세요")
                        }
                    }
                    
                case .Failure(_):
                    self.alertPresent("네트워크에 문제가 있습니다.", message: "다시 시도해보세요")
                    
                    
                    
                }
            })

        }
        
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        
        //navigationBar background clearColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.translucent = true
    }

    override func viewDidAppear(animated: Bool) {
        
        setButtons(favoriteBrandSet, view: myFavoriteBrandView, action: #selector(PreSearchViewController.tapping(_:)))
        
        setSearchTableView()
        
        barcodeButton.image = JaemIconStyleKit.imageOfBarcode
        exitButton.image = JaemIconStyleKit.imageOfExit_black
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    
    func dummyBrand() -> [String] {
        var set = [String]()
        set.append("유니클로")
        set.append("아베크롬비")
        set.append("디스이즈네버댓")
        set.append("립합")
        set.append("에이치엔엠")
        set.append("나이키")
        set.append("에잇세컨즈")
        set.append("나이키")
        
        return set
    
    }
    
    func tableViewAppear(appear : Bool) {
        if appear == true {
            tableView.hidden = false
            
            UIView.animateWithDuration(0.3, animations: {
                self.tableView.alpha = 1
            })
        } else {
            UIView.animateWithDuration(0.3, animations: {
                self.tableView.alpha = 0
            }) { (_) in
                self.tableView.hidden = true
                self.searchBar.resignFirstResponder()
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
    
    func parseToArray(data : AnyObject) -> [String] {
        var parsedArray = [String]()
        if let array = data as? [[String:String]] {
            for dictionary in array {
                if let keyword = dictionary["name"] {
                     parsedArray.append(keyword)
                } else if let keyword = dictionary["title"] {
                    parsedArray.append(keyword)
                }
               
            }
        }
        return parsedArray
    }
    
    func setSearchTableView()  {
        //init tableView
        tableView = UITableView(frame: CGRect(x: searchBar.frame.origin.x + 8, y: searchBar.frame.maxY - 8, width: searchBar.frame.width - 16, height: view.frame.height - searchBar.frame.maxY - 17)  , style: .Plain)
        tableView.layer.cornerRadius = 6
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.hidden = true
        tableView.alpha = 0
        
        let cellNib = UINib(nibName: "SearchTextCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: "SearchTextCell")
        view.addSubview(tableView)
    }
    
    func setButtons(array : [String], view: UIView, action : Selector) {
        var offsetX : CGFloat = 0
        var offsetY : CGFloat = 8
        let rightMax = view.frame.width - 76
        for title in array {
            //init button
            let button = UIButton()
            button.setTitle(title, forState: .Normal)
            button.addTarget(self, action: action, forControlEvents: .TouchUpInside)
            button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)!
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
            view.addSubview(button)
            
            //aligment button
            if offsetX < rightMax {
                button.frame = CGRect(x: offsetX, y: offsetY, width: CGFloat(title.characters.count) * 13.4, height: 16)
                offsetX += button.frame.width + 5
            } else {
                offsetX = 0
                offsetY += 31
                
                button.frame = CGRect(x: offsetX, y: offsetY, width: CGFloat(title.characters.count) * 13.4, height: 16)
                offsetX += button.frame.width + 5
            }
            
        }
    }
    
    func alertPresent(title : String, message: String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "다시시도", style: .Default, handler: nil)
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //MAKR : ACTION
    @IBAction func tapExit(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func tapBarcode(sender: AnyObject) {
        alertPresent("준비중", message: "서비스준비중입니다.")
        
        
    }
    
    func tapping (sender: AnyObject) {
        let button = sender as! UIButton
        searchBar.text = button.titleLabel?.text
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "GoSearchResult" {
            let dv = segue.destinationViewController as! SearchViewController
            dv.searchedText = searchedText
        }
    }
    

}
extension PreSearchViewController : UISearchBarDelegate , UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if typeSearchText == false {
            return recentlySearch.count
        } else {
            return relatedSearch.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 8, y: 10, width: 100, height: 16))
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 10)!
        label.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        if typeSearchText == false {
            label.text =  "RECENTLY SEARCH"
        } else {
            label.text =  "RELATED SEARCH"
        }
        let headerView = UIView()
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchTextCell", forIndexPath: indexPath) as! SearchTextCell
        if typeSearchText == false {
            cell.title.text = recentlySearch[indexPath.row]

        } else {
            cell.title.text = relatedSearch[indexPath.row]
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if typeSearchText == false {
            searchBar.text = recentlySearch[indexPath.row]
            
            
        } else {
            searchBar.text = relatedSearch[indexPath.row]
        }
    }
    
    //MARK: d
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if searchBar.text?.characters.count == 0 {
            tableViewAppear(false)
            
            
        } else {
            tableViewAppear(false)
            searchedText = searchBar.text
            performSegueWithIdentifier("GoSearchResult", sender: self)
        }
        
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        tableViewAppear(true)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        tableViewAppear(false)
        
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        tableViewAppear(false)
        
    }
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            let url_encoding = searchText.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            typeSearchText = true
            if let url = MyHost().urlWtihPathNameAboutMainServer("user/runtimesearch?keyword="+url_encoding!) {
                Alamofire.request(.GET, url, encoding: .JSON).responseJSON(completionHandler: { (response) in
                    debugPrint(response)
                    switch response.result {
                        
                    case .Success(let json):
                        if let dic = self.parseJSONToDictionary(json) {
                            if dic["stat"] as! String == "success" {
                                self.relatedSearch = self.parseToArray(dic["keyword"]!)
                                self.tableView.reloadData()
                            }
                        }
                    default: break
                    }
                    
                })
            }
            
            
            
        } else {
            
            typeSearchText = false
            tableView.reloadData()
        }
    }
}
