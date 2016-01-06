//
//  CustomSlider.swift
//  impression
//
//  Created by DAGUENET Valentin on 06/01/16.
//  Copyright © 2016 Arthur Valentin. All rights reserved.
//

import UIKit

class CustomSlider: UIControl {
    var minimumValue = 0.0
    var maximumValue = 1.0
    var value = 0.5
    var previousLocation = CGPoint()
    var viewController: QuestionViewController?
    
    let trackLayer = CALayer()
    var trackHight:CGFloat = 1.0
    var trackColor = UIColor.init(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1.0).CGColor
    
    var tickHight:CGFloat = 8.0
    var tickWidth: CGFloat = 2.0
    
    let thumbLayer = CSThumbLayer()
    var thumbMargin: CGFloat = -20.0
    var thumbWidth: CGFloat = 40.0
    let thumbButton = DualCircleButton(frame: CGRectZero)
    
    override var frame: CGRect {
        didSet {
            updateFrames()
        }
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer.backgroundColor = trackColor
        layer.addSublayer(trackLayer)
        
        thumbLayer.customSlider = self
        layer.addSublayer(thumbLayer)
        self.thumbButton.drawRect(thumbLayer.frame)
        self.addSubview(self.thumbButton)
        
        updateFrames()
    }
    
    func updateFrames() {
        trackLayer.frame = CGRect(x: 0, y: tickHight - trackHight, width: bounds.width, height: trackHight)
        trackLayer.setNeedsDisplay()
        
        let thumbCenter = CGPoint(x: CGFloat(value) * (bounds.width / CGFloat(maximumValue)), y: bounds.midY)
        thumbLayer.frame = CGRect(x: thumbCenter.x - thumbWidth / 2, y: tickHight + thumbMargin , width: thumbWidth, height: thumbWidth)
        
//        self.thumbButton.drawRect(thumbLayer.frame)
        self.thumbButton.move(thumbLayer.frame)
    }
    
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        previousLocation = touch.locationInView(self)
        if thumbLayer.frame.contains(previousLocation) {
            thumbLayer.highlighted = true
        }
        
        return thumbLayer.highlighted
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        
        // Track how much user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbLayer.frame.width)
        
        previousLocation = location
        
        // update value
        if thumbLayer.highlighted {
            value += deltaValue
            value = clipValue(value)
        }
        // update the UI
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        updateFrames()
        CATransaction.commit()
        
        return thumbLayer.highlighted
    }
    
    func clipValue(value: Double) -> Double {
        return min(max(value, minimumValue), maximumValue)
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        var to = 0.0
        if (value > 0.5) {
            to = 1.0
        }
        
        self.viewController!.onSliding(to);
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.setAnimationDuration(0.5)
        self.value = to
        updateFrames()
        UIView.commitAnimations()
        
        
        thumbLayer.highlighted = false
    }
    
}

class CSThumbLayer: CALayer {
    var highlighted = false
    weak var customSlider : CustomSlider?
}