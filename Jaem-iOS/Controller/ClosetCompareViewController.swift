//
//  ClosetCompareViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 5. 2..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import RealmSwift

class ClosetCompareViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var subView: UIView!
    
    var categorys = [CategoryButton]()
    var currentCategory = Category.ALL
    var categoryView : UIView!

    var clothesSet : Results<(Clothes)>!
    
    var loaded = false
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        exitButton.setImage(JaemIconStyleKit.imageOfExit_black, forState: .Normal)
        
        let realm = try! Realm()
        clothesSet = realm.objects(Clothes)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if loaded == false {
            
            //collectionView layout
            let width = CGRectGetWidth(collectionView!.frame) / 3
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: width, height: width)
            layout.headerReferenceSize = CGSize(width: collectionView.frame.width, height: 40)
            
            categoryView = addExtensionView()
            subView.addSubview(categoryView)
            
            loaded = true
        }
        
        
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
        let extensionView = UIView(frame: CGRect(x: 0, y: 60 , width: subView.frame.width , height: 40))
        extensionView.backgroundColor = UIColor.clearColor()
        let offsetX = (subView.frame.width - 335) / 7
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
            button.addTarget(self, action: #selector(self.tapButton(_:)), forControlEvents: .TouchUpInside)
        }
        
        
        
        return extensionView
    }
    
    //MARK: ACTION

    func tapButton(sender : CategoryButton) {
        for button in categorys {
            button.changeFillAlpha(false)
            
        }
        
        sender.changeFillAlpha(true)
        currentCategory = Category(rawValue: categorys.indexOf(sender)!)!
        print(currentCategory)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func tapExitButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension ClosetCompareViewController : UICollectionViewDelegate, UICollectionViewDataSource, UIViewControllerTransitioningDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothesSet.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ClosetCell", forIndexPath: indexPath) as! ClosetCell
        cell.imageView.image = UIImage(data: clothesSet[indexPath.row].image)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let presentingVC = presentingViewController as! FitSearchViewController
        presentingVC.clothesFromCloset.append(clothesSet[indexPath.row])
        presentingVC.fitCollectionView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK : UIViewControllerTransitioningDelegate
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
