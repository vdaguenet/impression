//
//  QuestionViewController.swift
//  impression
//
//  Created by DAGUENET Valentin on 03/11/15.
//  Copyright © 2015 Arthur Valentin. All rights reserved.
//


import UIKit

class QuestionViewController: UIViewController {
   
    var selectedAnswer: String = ""
    var model: QuestionModel!
   
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var answerTop: UILabel!
    @IBOutlet weak var iconTop: UIImageView!
    @IBOutlet weak var answerBottom: UILabel!
    @IBOutlet weak var iconBottom: UIImageView!
    @IBOutlet weak var slider: UISlider!{
        didSet{
            slider.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
            slider.minimumTrackTintColor = UIColor(red: 0.773, green: 0.773, blue: 0.773, alpha: 1.0)
            slider.maximumTrackTintColor = UIColor(red: 0.773, green: 0.773, blue: 0.773, alpha: 1.0)
            slider.thumbTintColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.model = QuestionModel()
        let question = self.model.getRandomQuestion()
        self.label.text = question.get(self.model.expressions.sentence).capitalizedString
        self.answerTop.text = question.get(self.model.expressions.firstProp).uppercaseString
        self.iconTop.image = UIImage(named: "cocktail")
        self.answerBottom.text = question.get(self.model.expressions.secondProp).uppercaseString
        self.iconBottom.image = UIImage(named: "fragrents")
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
