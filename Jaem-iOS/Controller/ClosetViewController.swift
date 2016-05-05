//
//  ClosetViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 24..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import HidingNavigationBar
import RealmSwift

let coordiCVHeight : CGFloat = 175
let infoTableViewCellHeight : CGFloat = 44
let categoryHeight : CGFloat = 50

class ClosetViewController: UIViewController {

    @IBOutlet weak var closetCollectionView: UICollectionView!
    
    var noClothesLabel : UILabel!
    var hidingNavBarManager: HidingNavigationBarManager?
    
    var clothesSet : Results<(Clothes)>!
    var header : ClothesHeaderView!
    var headerHeight : CGFloat = coordiCVHeight + infoTableViewCellHeight + categoryHeight
    
    var loaded = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //navigationBar background clearColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.translucent = true
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.tintColor = UIColor.blackColor()

        
        closetCollectionView.delegate = self
        closetCollectionView.dataSource = self
        
        //set hidingNavBar
        hidingNavBarManager = HidingNavigationBarManager(viewController: self, scrollView: closetCollectionView)
        
        //set label
        noClothesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120 , height: 17))
        noClothesLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!
        noClothesLabel.text = "등록된 옷이 없어요!"
        noClothesLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        noClothesLabel.hidden =  true
        view.addSubview(noClothesLabel)
        
        let realm = try! Realm()
                
        clothesSet = realm.objects(Clothes)
        
        /*
         기준
         coordiCV height = 175
         tableView Cell height = 44
         category height = 50
         */
        closetCollectionView.contentInset = UIEdgeInsets(top: -coordiCVHeight - infoTableViewCellHeight , left: 0, bottom: 0, right: 0)
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hidingNavBarManager?.viewWillAppear(animated)
        
        
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        hidingNavBarManager?.viewWillDisappear(animated)
        navigationItem.title = ""
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if loaded == false {
            let width = CGRectGetWidth(closetCollectionView!.frame) / 3
            let layout = closetCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: width, height: width)
            
            noClothesLabel.center = closetCollectionView.center
            
            header.addExtensionView()
            header.delegate = self
            loaded = true
        }
        self.closetCollectionView.contentOffset.y = -(-coordiCVHeight - infoTableViewCellHeight) - 64
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    func dummy() -> [JaemClothes] {
        var set = [JaemClothes]()
        let sizeTest =  JaemClothes(category: ClothesCategory.TOP, type: ClothesType.shortsleevedTshirts ,brand: "8세컨즈", name: "흰색 후드", image: UIImage(named: "1.png" )!)
        /*
        let require = TopSizeRequired()
        require.shoulderWidth = 45.5
        require.chestLength = 52
        require.sleeveLength = 65
        require.totalLength = 18
        let option = TopSizeOption()
        option.armHole = 20
        option.bottomSize = 14
        sizeTest.requiredSizeData = require
        sizeTest.optionSizeData = option
        sizeTest.typicalSize = "L"*/
        set.append(sizeTest)
        set.append( JaemClothes(category: ClothesCategory.BOTTOM, type: ClothesType.pants, brand: "8세컨즈", name: "찢어진 청바지", image: UIImage(named: "2.png" )!))
        set.append( JaemClothes(category: ClothesCategory.OUTER, type: ClothesType.jacket, brand: "동대문", name: "검은색 바람막이", image: UIImage(named: "3.png" )!))
        set.append( JaemClothes(category: ClothesCategory.ACC, type: ClothesType.acc, brand: "컨버스", name: "청 스니컬즈", image: UIImage(named: "4.png" )!))
        set.append( JaemClothes(category: ClothesCategory.TOP, type: ClothesType.longsleevedTshirts, brand: "8세컨즈", name: "빨간 맨투맨", image: UIImage(named: "5.png" )!))
        set.append( JaemClothes(category: ClothesCategory.TOP, type: ClothesType.longsleevedTshirts, brand: "8세컨즈", name: "남색 맨투맨", image: UIImage(named: "6.png" )!))
        set.append( JaemClothes(category: ClothesCategory.TOP, type: ClothesType.longsleevedTshirts, brand: "8세컨즈", name: "검은색 맨투맨", image: UIImage(named: "7.png" )!))
        set.append( JaemClothes(category: ClothesCategory.TOP, type: ClothesType.longsleevedTshirts, brand: "8세컨즈", name: "회색 S 긴팔", image: UIImage(named: "8.png" )!))
        set.append( JaemClothes(category: ClothesCategory.TOP, type: ClothesType.longsleevedTshirts, brand: "8세컨즈", name: "검은색 S 긴팔", image: UIImage(named: "9.png" )!))
        set.append( JaemClothes(category: ClothesCategory.TOP, type: ClothesType.longsleevedTshirts, brand: "삼성물산 화이팅", name: "검정 긴팔", image: UIImage(named: "10.png" )!))
        
        return set
    }
    */
    
    
    //MARK : ACTION
    @IBAction func tapCancel(sender: AnyObject) {
        header.coordiSet.removeAll()
        header.coordiCollectionView.reloadData()
        header.infoTableView.reloadData()
        UIView.animateWithDuration(0.3, animations: {
            self.closetCollectionView.contentInset = UIEdgeInsets(top: -coordiCVHeight - infoTableViewCellHeight , left: 0, bottom: 0, right: 0)
            self.closetCollectionView.contentOffset.y = -(-coordiCVHeight - infoTableViewCellHeight) - 64
        }) { (complete) in
            //
        }
        
    }
    @IBAction func tapSearch(sender: AnyObject) {
        performSegueWithIdentifier("GoSearchFromCloset", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "GoDetail" {
            let dv = segue.destinationViewController as! ClosetDetailViewController
            
            dv.targetClothes = header.saveCoordi
        }
    }
    

}

extension ClosetViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ClothesHeaderViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if clothesSet.count == 0 {
            noClothesLabel.hidden = false
        } else {
            noClothesLabel.hidden = true
        }
        return clothesSet.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ClosetCell", forIndexPath: indexPath) as! ClosetCell
        
        cell.imageView.image = UIImage(data: clothesSet[indexPath.row].image )
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        header.saveCoordi = clothesSet[indexPath.row]
        header.coordiCollectionView.reloadData()
        header.infoTableView.reloadData()
        UIView.animateWithDuration(0.3, animations: { 
            self.closetCollectionView.contentInset = UIEdgeInsets(top: 64 , left: 0, bottom: 0, right: 0)
            self.closetCollectionView.contentOffset.y = -64
            }) { (complete) in
                //
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ClothesHeaderView", forIndexPath: indexPath) as! ClothesHeaderView
        header = sectionHeaderView
        
        return sectionHeaderView
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: headerHeight)
    }
    
    //MARK : ClothesHeaderViewDelegate
    func clothesHeaderView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("GoDetail", sender: self)
    }
    
    func tapCategoryButton(currentCategory: Category) {
        let realm = try! Realm()
        if currentCategory == Category.ALL {
            clothesSet = realm.objects(Clothes)
            closetCollectionView.reloadData()
        } else {
            clothesSet = realm.objects(Clothes).filter("category = %@", Parse().parseIntToClothesCategory(currentCategory.rawValue).rawValue )
            closetCollectionView.reloadData()
        }
        
    }
 
}