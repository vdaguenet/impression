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
    var productIdAnswerTop: Int64!
    var productIdAnswerBottom: Int64!
    
    let slider = CustomSlider(frame: CGRectZero)
   
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var answerBottom: UIImageView!
    @IBOutlet weak var answerTop: UIImageView!
    @IBOutlet weak var answerTopBlurred: UIImageView!
    @IBOutlet weak var answerBottomBlurred: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slider.viewController = self
        view.addSubview(self.slider)
        
        self.model = QuestionModel()
        let question = self.model.getRandomQuestion()
        self.label.text = question.get(self.model.expressions.sentence)
        
        self.backgroundImage.image = UIImage(named: question.get(self.model.expressions.background))
        
        let imageTop = UIImage(named: question.get(self.model.expressions.firstProp))
        self.answerTop.image = imageTop
        self.answerTopBlurred.image = self.blurImage(imageTop!)
        self.answerTopBlurred.alpha = 0.0
        self.productIdAnswerTop = question.get(self.model.expressions.firstProduct)
        
        let imageBottom = UIImage(named: question.get(self.model.expressions.secondProp))
        self.answerBottom.image = imageBottom
        self.answerBottomBlurred.image = self.blurImage(imageBottom!)
        self.answerBottomBlurred.alpha = 0.0
        self.productIdAnswerBottom = question.get(self.model.expressions.secondProduct)
        
        GlobalVars.currentQuestion++;

    }
    
    override func viewDidLayoutSubviews() {
        let x = 0.5 * view.bounds.width - 7
        let y = 0.5 * view.bounds.height - 75
        
        self.slider.frame = CGRect(x: x, y: y, width: 40.0, height: 200.0)
        self.slider.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
    }
    
    func onSliding(value: Double) {
        if (value > 0.5) {
            // answer top
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
            UIView.setAnimationDuration(0.4)
            self.answerBottom.alpha = 0.0
            self.answerBottomBlurred.alpha = 1.0
            self.answerTop.alpha = 1.0
            self.answerTopBlurred.alpha = 0.0
            UIView.commitAnimations()
        
        
            GlobalVars.questionAnswers.append(self.productIdAnswerTop)
        } else {
            // answer bottom
        
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
            UIView.setAnimationDuration(0.4)
            self.answerBottom.alpha = 1.0
            self.answerBottomBlurred.alpha = 0.0
            self.answerTop.alpha = 0.0
            self.answerTopBlurred.alpha = 1.0
            UIView.commitAnimations()
        
            GlobalVars.questionAnswers.append(self.productIdAnswerBottom)
        }
                
        let delay = 0.5 * Double(NSEC_PER_SEC)
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
