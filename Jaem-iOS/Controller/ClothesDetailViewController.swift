//
//  ClothesDetailViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 12..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class ClothesDetailViewController: UIViewController {

    @IBOutlet weak var clothesBaseView: UIView!
    
    @IBOutlet weak var clothesImageView: UIImageView!
    @IBOutlet weak var leftCircleView: PopCircleView!
    @IBOutlet weak var rightCircleView: PopCircleView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addButtonView: AddButtonView!
    
    @IBOutlet weak var fitInfoView: FitInfoView!
    
    @IBOutlet weak var brandButton: UIButton!
    @IBOutlet weak var goStoreButton: BottomCardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clothesImageView.image = UIImage(named: "IMG_0272 Copy 2.png")
        
        // add gestrueRecognizer
        let tapGestrueRecognizer = UITapGestureRecognizer(target: self, action: #selector(ClothesDetailViewController.tapping(_:)))
        clothesBaseView.addGestureRecognizer(tapGestrueRecognizer)
        
        setFitInfoView()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: "유니클로")
        
        attributeString2.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, 4))
        brandButton.titleLabel!.attributedText = attributeString2
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setFitInfoView() {
        fitInfoView.tightFit = "100"
        fitInfoView.regularFit = "105"
        fitInfoView.overFit = "110"
        
        fitInfoView.tightExplain = "아 시발 껴"
        fitInfoView.regularExplain = "굿굿굿굿"
        fitInfoView.overExplain = "개 커"
    }
    
    //MARK: ACTION
    
    func tapping(recognizer : UITapGestureRecognizer)  {
        let location = recognizer.locationInView(view)
        
        if CGRectContainsPoint(CGRectOffset(leftCircleView.frame, 0, clothesBaseView.frame.origin.y ), location) {
            performSegueWithIdentifier("GoFit", sender: self)
            
        }
        
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
