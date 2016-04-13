//
//  PreSearchViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 13..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class PreSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var fromNowView: UIView!
    @IBOutlet weak var myFavoriteBrandView: UIView!
    
    private var fromNowSet = [String]()
    private var favoriteBrandSet = [String]()
    
    private var tableView : UITableView!
    private var relatedSearch = [String]()
    private var recentlySearch = [String]()
    
    private var typeSearchText = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromNowSet = dummySet()
        favoriteBrandSet = dummySet()
        recentlySearch = dummySet()
        relatedSearch = dummySet()
        relatedSearch.append("dododod")
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        
    }

    override func viewDidAppear(animated: Bool) {
        setButtons(fromNowSet, view: fromNowView, action: #selector(PreSearchViewController.tapping(_:)))
        setButtons(favoriteBrandSet, view: myFavoriteBrandView, action: #selector(PreSearchViewController.tapping(_:)))
        
        setSearchTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    
    func dummySet() -> [String] {
        var set = [String]()
        set.append("헨리넥 셔츠")
        set.append("유니클로 조거팬츠")
        set.append("뉴욕 후드")
        set.append("에잇세컨즈 데미지팬츠")
        set.append("에이치엔엠 체크셔츠")
        set.append("링스샾 맨투맨")
        
        return set
    
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
    
    @IBAction func tapExit(sender: AnyObject) {
        
    }

    @IBAction func tapBarcode(sender: AnyObject) {
        
    }
    
    func tapping (sender: AnyObject) {
        let button = sender as! UIButton
        searchBar.text = button.titleLabel?.text
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
    
    //MARK: d
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        //
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        tableView.hidden = false
        
        UIView.animateWithDuration(0.3, animations: {
            self.tableView.alpha = 1
        })
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        UIView.animateWithDuration(0.3, animations: { 
            self.tableView.alpha = 0
            }) { (_) in
                self.tableView.hidden = true
                searchBar.resignFirstResponder()
        }
    }
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            
            typeSearchText = true
            tableView.reloadData()
        } else {
            
            typeSearchText = false
            tableView.reloadData()
        }
    }
}
