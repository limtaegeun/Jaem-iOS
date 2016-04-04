//
//  SelectGenderViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 25..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class SelectGenderViewController: UIViewController {

    @IBOutlet weak var maleImageView: UIImageView!
    
    @IBOutlet weak var femaleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        if CGRectContainsPoint(maleImageView.frame, location) {
            performSegueWithIdentifier("NextStep", sender: self)
        } else if CGRectContainsPoint(femaleImageView.frame, location) {
            performSegueWithIdentifier("NextStep", sender: self)
        }
    }
    
    @IBAction func tapBackButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
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
