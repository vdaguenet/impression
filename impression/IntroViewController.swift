//
//  ViewController.swift
//  impression
//
//  Created by DAGUENET Valentin on 02/11/15.
//  Copyright © 2015 Arthur Valentin. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    @IBOutlet weak var impression: UIImageView!
    @IBOutlet weak var bySisley: UIImageView!
    @IBOutlet weak var introText: UILabel!
    @IBOutlet weak var circleButton: DualCircleButton!
    @IBOutlet weak var btnStart: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        // prepare animations
        self.impression.center.y += 50
        self.impression.alpha = 0
        self.bySisley.center.y += 50
        self.bySisley.alpha = 0
        
        self.introText.center.y += 10
        self.introText.alpha = 0
        
        self.circleButton.alpha = 0
        self.btnStart.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        // animate
        UIView.animateWithDuration(1.0, delay: 0.0, options: [ .CurveEaseOut ], animations: {
            self.impression.center.y -= 50
            self.impression.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1.0, delay: 0.15, options: [ .CurveEaseOut ], animations: {
            self.bySisley.center.y -= 50
            self.bySisley.alpha = 1
            }, completion: nil)
        
        UIView.animateWithDuration(1.0, delay: 0.8, options: [ .CurveEaseOut ], animations: {
            self.introText.center.y -= 10
            self.introText.alpha = 1
            }, completion: nil)
        
        UIView.animateWithDuration(2.0, delay: 1.4, options: [ .CurveEaseOut ], animations: {
            self.btnStart.alpha = 1
            self.circleButton.alpha = 1
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

