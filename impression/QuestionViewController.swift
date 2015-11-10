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
    var answerTopStr: String = ""
    var answerBottomStr: String = ""
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
        
        let imageTop = UIImage(named: question.get(self.model.expressions.firstProp))
        self.answerTop.image = imageTop
        self.answerTopBlurred.image = self.blurImage(imageTop!)
        self.answerTopBlurred.alpha = 0.0
        self.answerTopStr = question.get(self.model.expressions.firstAnswer)
        
        let imageBottom = UIImage(named: question.get(self.model.expressions.secondProp))
        self.answerBottom.image = imageBottom
        self.answerBottomBlurred.image = self.blurImage(imageBottom!)
        self.answerBottomBlurred.alpha = 0.0
        self.answerBottomStr = question.get(self.model.expressions.secondAnswer)
        
        GlobalVars.currentQuestion++;
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

            
            GlobalVars.questionAnswers.append(self.answerTopStr)
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
            
            GlobalVars.questionAnswers.append(self.answerBottomStr)
        }
       
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.setAnimationDuration(0.3)
        self.slider.setValue(Float(dest), animated: true)
        UIView.commitAnimations()
        
        let delay = 2.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            if (GlobalVars.currentQuestion < GlobalVars.NB_QUESTION) {
                self.gotoNextQuestion()
            } else {
                self.gotoImpression()
            }
        }
        
       
    }
    
    func blurImage(image: UIImage) -> UIImage {
        let imageToBlur = CIImage(image: image)
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter!.setValue(imageToBlur, forKey: "inputImage")
        blurfilter!.setValue(10.0, forKey: "inputRadius")
        let resultImage = blurfilter!.valueForKey("outputImage") as! CIImage

        return UIImage(CIImage: resultImage)
    }
    
    func gotoNextQuestion() {
        let questionViewControllerObejct = self.storyboard?.instantiateViewControllerWithIdentifier("QuestionView") as! QuestionViewController
        self.navigationController?.pushViewController(questionViewControllerObejct, animated: true)
    }
    
    func gotoImpression() {
        let impressionViewControllerObejct = self.storyboard?.instantiateViewControllerWithIdentifier("ImpressionView") as! ImpressionViewController
        self.navigationController?.pushViewController(impressionViewControllerObejct, animated: true)
    }
}
