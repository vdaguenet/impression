//
//  DualCircleButton.swift
//  impression
//
//  Created by DAGUENET Valentin on 06/01/16.
//  Copyright © 2016 Arthur Valentin. All rights reserved.
//

import UIKit

class BigCircle: UIView {
    var autoplay = false
    var animating = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func draw() {
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.layer.cornerRadius = 0.5 * self.frame.width;
        
        if (self.autoplay) {
            self.animate()
        } else {
            let delay = 0.1 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.animate()
            }
        }
    }
    
    func animate() {
        if (self.animating == true) { return }
        
        self.animating = true

        UIView.animateWithDuration(1.4, delay: 0.0, options: [ .Repeat, .Autoreverse, .CurveEaseInOut, .AllowUserInteraction ], animations: {
            self.transform = CGAffineTransformMakeScale(0.5, 0.5)
            }, completion: nil)

        
        
    }
}



class SmallCircle: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func draw() {
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.15)
        self.layer.cornerRadius = 0.5 * self.frame.width;
    }
}



class DualCircleButton: UIButton {
    var circleBig = BigCircle(frame: CGRectZero)
    var circleSmall = SmallCircle(frame: CGRectZero)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.circleBig.autoplay = true;
        self.addSubview(self.circleBig)
        self.addSubview(self.circleSmall)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.circleBig)
        self.addSubview(self.circleSmall)
    }
    
    override func drawRect(rect: CGRect) {
        self.setTitle("", forState: UIControlState.Normal)
        
        self.circleBig.frame = rect
        self.circleBig.draw()
        self.circleSmall.frame = CGRectInset(rect, rect.width * 0.25, rect.height * 0.25)
        self.circleSmall.draw()
    }
    
    func move(rect: CGRect) {
        self.frame.origin.x = rect.origin.x + 0.5 * rect.width
        self.frame.origin.y = rect.origin.y + 0.28 * rect.height
    }
}
