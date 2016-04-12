//
//  SearchViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 11..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import HidingNavigationBar

struct Result {
    var brand : String
    var name : String
    var image : UIImage
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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var numberOfResult: UILabel!
    
    var searchResults = [Result]()
    var hasSearched = false
    var categorys = [CategoryButton]()
    var currentCategory = Category.ALL
    var categoryView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //set tableview contentInset
        tableView.contentInset = UIEdgeInsets(top: 104, left: 0, bottom: 0, right: 0)
        
        //set delegate
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        categoryView = addExtensionView()
        view.addSubview(categoryView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        //set action
        for button in categorys {
            button.addTarget(self, action: #selector(SearchViewController.tapButton(_:)), forControlEvents: .TouchUpInside)
        }
        
        
        
        return extensionView
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK : ACTION
    
    func tapButton(sender : AnyObject) {
        for button in categorys {
            button.changeFillAlpha(false)
            
        }
        sender.changeFillAlpha(true)
        currentCategory = Category(rawValue: categorys.indexOf(sender as! CategoryButton)!)!
        print(currentCategory)
    }
    
}

extension SearchViewController : UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        for _ in 0...2 {
            searchResults.append(Result(brand: "유니클로", name: "개 멋진 티셔츠", image: UIImage(named: "IMG_0272 Copy 2.png")!))
        }
        
        tableView.reloadData()
    }
    
    //MARK : TABLE VIEW Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchResults.count == 0 {
            return 0
        } else {
            return searchResults.count

        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchResultCell", forIndexPath: indexPath) as! SearchResultCell
        cell.brandLabel.text = searchResults[indexPath.row].brand
        cell.nameLabel.text = searchResults[indexPath.row].name
        cell.clothesImage.image = searchResults[indexPath.row].image
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print("didselect")
    }
    
}









