//
//  ClothesHeaderView.swift
//
//
//  Created by 임태근 on 2016. 4. 22..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

protocol ClothesHeaderViewDelegate : class {
    func clothesHeaderView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    func tapCategoryButton(currentCategory: Category)
}

class ClothesHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var coordiCollectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var coordiCollectionView: UICollectionView!
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var categoryView: UIView!
    
    var delegate : ClothesHeaderViewDelegate?
    var categorys : [CategoryButton]!
    var currentCategory = Category.ALL
    
    var coordiSet = [Clothes]()
    
    var saveCoordi : Clothes {
        get {
            return coordiSet[0]
        }
        set(newVal) {
            if coordiSet.count != 0 {
                coordiSet[0] = newVal
            } else {
                coordiSet.append(newVal)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        coordiCollectionView.delegate = self
        coordiCollectionView.dataSource = self
        infoTableView.delegate = self
        infoTableView.dataSource = self
        
    }
    
    func addExtensionView() {
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
        
        categoryView.backgroundColor = UIColor.whiteColor()
        let offsetX = (categoryView.frame.width - 335) / 7
        let midY = categoryView.bounds.height/2
        var stackX : CGFloat = 0.0
        for i in 0...5 {
            categoryView.addSubview(categorys[i])
            
            categorys[i].center = CGPoint(x: stackX + offsetX * CGFloat(i + 1) + categorys[i].bounds.width/2, y: midY)
            stackX += categorys[i].bounds.width
        }
        
        categorys[0].changeFillAlpha(true)
        
        //set action
        for button in categorys {
            button.addTarget(self, action: #selector(self.tapButton(_:)), forControlEvents: .TouchUpInside)
        }
        
        
        
        
    }
    
    func tapButton(sender : CategoryButton) {
        for button in categorys {
            button.changeFillAlpha(false)
            
        }
        
        sender.changeFillAlpha(true)
        currentCategory = Category(rawValue: categorys.indexOf(sender)!)!
        print(currentCategory)
        delegate?.tapCategoryButton(currentCategory)
    }
 
    
    
}

extension ClothesHeaderView : UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    //MARK : UICollectionViewDelegate , UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coordiSet.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CoordiCell", forIndexPath: indexPath) as! CoordiCell
        cell.imageView.image = UIImage(data: coordiSet[indexPath.row].image )
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate?.clothesHeaderView(collectionView, didSelectItemAtIndexPath: indexPath)
    }
    
    
    //MARK : UITableViewDelegate, UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return coordiSet.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordiSet.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ClosetClothesInfoCell", forIndexPath: indexPath) as! ClosetClothesInfoCell
        cell.brandLabel.text = coordiSet[indexPath.row].brand
        cell.nameLabel.text = coordiSet[indexPath.row].name
        let category = coordiSet[indexPath.row].category
        cell.categoryLabel.text = category
        
        return cell
    }
    
}
