//
//  SelectGenderViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 25..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import RealmSwift

class SelectGenderViewController: UIViewController {

    @IBOutlet weak var maleImageView: UIImageView!
    
    @IBOutlet weak var femaleImageView: UIImageView!
   
    @IBOutlet weak var exitButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationBar background clearColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.translucent = true
        
        exitButton.image = JaemIconStyleKit.imageOfExit_black
        
        maleImageView.image = UIImage(named: "BasicMale")
        femaleImageView.image = UIImage(named: "BasicFemale")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectGenderViewController.tapping(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapping(recognizer : UITapGestureRecognizer) {
        let location = recognizer.locationInView(view)
        
        let realm = try! Realm()
        let me = realm.objects(UserInfo).first
        
        if CGRectContainsPoint(maleImageView.frame, location) {
            try! realm.write({ 
                me?.gender = Gender.Male.rawValue
            })
            performSegueWithIdentifier("NextStep", sender: self)
        } else if CGRectContainsPoint(femaleImageView.frame, location) {
            try! realm.write({
                me?.gender = Gender.Female.rawValue
            })
            performSegueWithIdentifier("NextStep", sender: self)
        }
    }
    
    @IBAction func tapExit(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
