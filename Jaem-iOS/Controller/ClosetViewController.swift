//
//  ClosetViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 24..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

struct MyClothes {
    var category : String
    var brand : String
    var name : String
    var image : UIImage
}

class ClosetViewController: UIViewController {

    @IBOutlet weak var closetCollectionView: UICollectionView!
    
    var clothesSet = [MyClothes]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closetCollectionView.delegate = self
        closetCollectionView.dataSource = self
        
        clothesSet = dummy()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let width = CGRectGetWidth(closetCollectionView!.frame) / 3
        let layout = closetCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        layout.headerReferenceSize  = CGSize(width: closetCollectionView.frame.width, height: 50)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dummy() -> [MyClothes] {
        var set = [MyClothes]()
        set.append( MyClothes(category: ClothesCategory.TOP.rawValue, brand: "8세컨즈", name: "흰색 후드", image: UIImage(named: "1.png" )!))
        set.append( MyClothes(category: ClothesCategory.BOTTOM.rawValue, brand: "8세컨즈", name: "찢어진 청바지", image: UIImage(named: "2.png" )!))
        set.append( MyClothes(category: ClothesCategory.OUTER.rawValue, brand: "동대문", name: "검은색 바람막이", image: UIImage(named: "3.png" )!))
        set.append( MyClothes(category: ClothesCategory.ACC.rawValue, brand: "컨버스", name: "청 스니컬즈", image: UIImage(named: "4.png" )!))
        set.append( MyClothes(category: ClothesCategory.TOP.rawValue, brand: "8세컨즈", name: "빨간 맨투맨", image: UIImage(named: "5.png" )!))
        set.append( MyClothes(category: ClothesCategory.TOP.rawValue, brand: "8세컨즈", name: "남색 맨투맨", image: UIImage(named: "6.png" )!))
        set.append( MyClothes(category: ClothesCategory.TOP.rawValue, brand: "8세컨즈", name: "검은색 맨투맨", image: UIImage(named: "7.png" )!))
        set.append( MyClothes(category: ClothesCategory.TOP.rawValue, brand: "8세컨즈", name: "회색 S 긴팔", image: UIImage(named: "8.png" )!))
        set.append( MyClothes(category: ClothesCategory.TOP.rawValue, brand: "8세컨즈", name: "검은색 S 긴팔", image: UIImage(named: "9.png" )!))
        set.append( MyClothes(category: ClothesCategory.TOP.rawValue, brand: "삼성물산 화이팅", name: "검정 긴팔", image: UIImage(named: "10.png" )!))
        
        return set
    }
    
    
    
    //MARK : ACTION
    @IBAction func tapCancel(sender: AnyObject) {
        
        
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

extension ClosetViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothesSet.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ClosetCell", forIndexPath: indexPath) as! ClosetCell
        
        cell.imageView.image = clothesSet[indexPath.row].image
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ClothesHeaderView", forIndexPath: indexPath) as! ClothesHeaderView
        
        return sectionHeaderView
    }
    
    
    
}