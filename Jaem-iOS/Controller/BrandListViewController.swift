//
//  BrandListViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 29..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class BrandListViewController: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var brandList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exitButton.setImage(JaemIconStyleKit.imageOfExitButton, forState: .Normal)
        brandList = dummyList()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .Custom
        transitioningDelegate = self
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dummyList() -> [String] {
        var set = [String]()
        set.append("8SECONDS")
        set.append("가나샵")
        set.append("나나스타일")
        set.append("다도쇼핑몰")
        set.append("라스베가스의 그녀 옷장 쇼핑몰")
        set.append("마마무 스타일 샵")
        set.append("유니클로")
        set.append("ALICE SHOP")
        set.append("BECHAM STYLE")
        
        return set
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    //MARK: ACTION
    
    @IBAction func tapExit(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
}

extension BrandListViewController : UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brandList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BrandListCell", forIndexPath: indexPath) as! BrandListCell
        cell.nameLabel.text = brandList[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let presentingVC = presentingViewController as! UINavigationController
        let topVC = presentingVC.topViewController as! PreSearchViewController
        topVC.searchBar.text = brandList[indexPath.row]
        dismissViewControllerAnimated(true, completion: {_ in
            topVC.searchedText = self.brandList[indexPath.row]
            topVC.performSegueWithIdentifier("GoSearchResult", sender: self)
        })
    }
    
    
    //MARK: UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AppearAnimationController()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimationController()
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return DimmingPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
}