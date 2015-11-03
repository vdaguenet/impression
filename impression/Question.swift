//
//  Question.swift
//  impression
//
//  Created by DAGUENET Valentin on 03/11/15.
//  Copyright © 2015 Arthur Valentin. All rights reserved.
//


import UIKit


class Question: UIViewController {
   
    var selectedAnswer: String = ""
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var answerTop: UILabel!
    @IBOutlet weak var answerBottom: UILabel!
    @IBOutlet weak var slider: UISlider!{
        didSet{
            slider.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.text = "Lorem ipsum dolor"
        self.answerTop.text = "I am the prop top"
        self.answerBottom.text = "I am the prop bottom"
    }
    
    @IBAction func onSlideEnd(sender: UISlider) {
        var dest = 0.0

        if (sender.value > 0.5) {
            dest = 1.0
            self.selectedAnswer = self.answerTop.text!
        } else {
            self.selectedAnswer = self.answerBottom.text!
        }
        print("answer \(self.selectedAnswer)")
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.setAnimationDuration(0.3)
        self.slider.setValue(Float(dest), animated: true)
        UIView.commitAnimations()
        
    }
}
