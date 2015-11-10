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
    @IBOutlet weak var answerBottom: UIImageView!
    @IBOutlet weak var answerTop: UIImageView!
    @IBOutlet weak var answerTopBlurred: UIImageView!
    @IBOutlet weak var answerBottomBlurred: UIImageView!
    
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
        
        let imageTop = UIImage(named: "sortir-amis")
        self.answerTop.image = imageTop
        self.answerTopBlurred.image = self.blurImage(imageTop!)
        self.answerTopBlurred.alpha = 0.0
        
        let imageBottom = UIImage(named: "prendre-soin")
        self.answerBottom.image = imageBottom
        self.answerBottomBlurred.image = self.blurImage(imageBottom!)
        self.answerBottomBlurred.alpha = 0.0
    }
    
    @IBAction func onSlideEnd(sender: UISlider) {
        var dest = 0.0
        
        if (sender.value > 0.5) {
            dest = 1.0
            print("answer top")
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
            UIView.setAnimationDuration(0.4)
            self.answerBottom.alpha = 0.0
            self.answerBottomBlurred.alpha = 1.0
            self.answerTop.alpha = 1.0
            self.answerTopBlurred.alpha = 0.0
            UIView.commitAnimations()
            
        } else {
            print("answer bottom")
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
            UIView.setAnimationDuration(0.4)
            self.answerBottom.alpha = 1.0
            self.answerBottomBlurred.alpha = 0.0
            self.answerTop.alpha = 0.0
            self.answerTopBlurred.alpha = 1.0
            UIView.commitAnimations()
        }
       
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.setAnimationDuration(0.3)
        self.slider.setValue(Float(dest), animated: true)
        UIView.commitAnimations()
        
    }
    
    func blurImage(image: UIImage) -> UIImage {
        let imageToBlur = CIImage(image: image)
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter!.setValue(imageToBlur, forKey: "inputImage")
        blurfilter!.setValue(10.0, forKey: "inputRadius")
        let resultImage = blurfilter!.valueForKey("outputImage") as! CIImage

        return UIImage(CIImage: resultImage)
    }
}
