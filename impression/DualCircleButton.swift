//
//  DualCircleButton.swift
//  impression
//
//  Created by DAGUENET Valentin on 06/01/16.
//  Copyright © 2016 Arthur Valentin. All rights reserved.
//

import UIKit

class BigCirle: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.layer.cornerRadius = 0.5 * frame.width;
        
        UIView.animateWithDuration(1.4, delay: 0.0, options: [ .Repeat, .Autoreverse, .CurveEaseInOut, .AllowUserInteraction ], animations: {
            self.transform = CGAffineTransformMakeScale(0.5, 0.5)
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



class SmallCirle: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        self.layer.cornerRadius = 0.5 * frame.width;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



class DualCircleButton: UIButton {
    override func drawRect(rect: CGRect) {
        self.setTitle("", forState: UIControlState.Normal)
        
        self.addSubview(BigCirle(frame: rect))
        self.addSubview(SmallCirle(frame: CGRectInset(rect, rect.width * 0.25, rect.height * 0.25)))
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        UIView.animateWithDuration(0.4, delay: 0.0, options: [.AllowUserInteraction, .Autoreverse ], animations: {
            self.alpha = 0.5
            }, completion: nil)
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        UIView.animateWithDuration(0.4, delay: 0.0, options: [.AllowUserInteraction, .Autoreverse  ], animations: {
            self.alpha = 1.0
            }, completion: nil)
    }
    
}
