//
//  ImpressionViewController.swift
//  impression
//
//  Created by DAGUENET Valentin on 10/11/15.
//  Copyright © 2015 Arthur Valentin. All rights reserved.
//

import UIKit
import SQLite

class ImpressionViewController: UIViewController {
    var productModel = ProductModel()
    var firstProduct: SQLite.Row!
    var secondProduct: SQLite.Row!
    var thirdProduct: SQLite.Row!
    
    @IBAction func backFromSurpriseView(segue: UIStoryboardSegue) {}
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var firstBlurImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var secondBlurImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    
    @IBOutlet weak var citation: UILabel!
    @IBOutlet weak var auteur: UILabel!
    @IBOutlet weak var produit: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var bouton12: pushButton!
    @IBOutlet weak var boutton11: pushButton!
    @IBOutlet weak var Boutton21: pushButton!
    @IBOutlet weak var boutton13: pushButton!
    @IBOutlet weak var surprise: UIButton!
    @IBOutlet weak var cross: UIButton!
    @IBOutlet weak var labelDescript: UILabel!
    
    var layerCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getProductsFromQuestions()
        
        let longTouch: UILongPressGestureRecognizer = UILongPressGestureRecognizer (target: self, action: "longTouch:")
        longTouch.minimumPressDuration = 0.8
        self.view.addGestureRecognizer(longTouch)
        
        /* Layer */
        
        self.layerCount = 0;
        self.surprise.hidden = true;
        self.cross.hidden = true;
        self.Boutton21.hidden = true
       
       
        /* Text INIT  */
        self.citation.hidden = true
        self.auteur.hidden = true
        self.descript.hidden = true
        self.produit.hidden = true
        
        self.citation.text = self.firstProduct.get(self.productModel.expressions.citation);
        self.auteur.text = self.firstProduct.get(self.productModel.expressions.auteurCitation);
        self.descript.text = self.firstProduct.get(self.productModel.expressions.description);
        self.produit.text = self.firstProduct.get(self.productModel.expressions.name);
        
        /* IMAGE init */
        
        
        self.firstImage.image = UIImage(named :"impression_1_1.png");
        self.secondImage.image = UIImage(named :self.firstProduct.get(self.productModel.expressions.imageCitation ));
        self.thirdImage.image = UIImage(named :self.firstProduct.get(self.productModel.expressions.image ));
        
        self.firstBlurImage.image = self.blurImage(15.0, image : self.firstImage.image! );
        self.secondBlurImage.image = self.blurImage(15.0, image : self.secondImage.image! );
        
        self.firstImage.transform = CGAffineTransformMakeScale(1.4, 1.4)
       
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        print("crossPress")
        UIButton.animateWithDuration(0.4, delay: 0.0,options: [ .Autoreverse], animations: {
            self.cross.alpha = 0.5
            self.cross.transform = CGAffineTransformMakeScale(0.8, 0.8)
            }, completion: nil)
        if(self.layerCount>0){
            if(self.layerCount == 1){
                animationDepthOut(self.firstImage, image1Blur: self.firstBlurImage, image2: self.secondImage )
                textOut(self.citation , text2: self.auteur );
             
                self.Boutton21.hidden = true
                self.boutton11.hidden = false
                self.bouton12.hidden = false
                self.boutton13.hidden = false
                 self.cross.hidden = true
            }else if(self.layerCount == 2){
                textIn(self.citation , text2: self.auteur );
                textOut(self.produit , text2: self.descript);
                animationDepthOut(self.secondImage, image1Blur:self.secondBlurImage, image2: self.thirdImage )
                self.Boutton21.hidden = false
                self.surprise.hidden = true
            }
            self.layerCount  = self.layerCount - 1 ;
            print(self.layerCount)
        }
    }
    
    func longTouch( longTouch : UIGestureRecognizer){
        if(longTouch.state == UIGestureRecognizerState.Began){
            print("view Began")
            if(self.layerCount == 0){
                touchBlur(self.firstImage, image1Blur: self.firstBlurImage);
                self.cross.hidden = false ;
            }else if(self.layerCount == 1){
                touchBlur(self.secondImage, image1Blur: self.secondBlurImage);
                
                
            }
            
        }else if(longTouch.state == UIGestureRecognizerState.Ended) {
            print("view Ended")
            self.layerCount = self.layerCount +  1 ;
            if(self.layerCount == 1){
                animationDepthIn(self.firstImage, image1Blur: self.firstBlurImage, image2: self.secondImage );
                textIn(self.citation , text2: self.auteur );
                self.Boutton21.hidden = false
                self.boutton11.hidden = true
                self.bouton12.hidden = true
                self.boutton13.hidden = true
                
                
            }else if(self.layerCount == 2){
                textOut(self.citation , text2: self.auteur );
                animationDepthIn(self.secondImage, image1Blur:self.secondBlurImage, image2: self.thirdImage );
                textIn(self.produit , text2: self.descript);
                self.Boutton21.hidden = true
                self.surprise.hidden = false
            }
          //  print(self.layerCount)
            
        }
        
    }
    
    
    func touchBlur(image1 : UIImageView , image1Blur: UIImageView){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDelay(0.6)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.setAnimationDuration(0.4)
        image1Blur.alpha = 0.2
        image1.alpha = 0.5
        UIView.commitAnimations()
        
    }
    
    func animationDepthIn(image1 : UIImageView , image1Blur: UIImageView, image2: UIImageView){
        image2.hidden = false
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.setAnimationDuration(0.8)
        image1 .transform = CGAffineTransformMakeScale(4.0 , 4.0)
        image1 .alpha = 0.0
        image1Blur.transform  = CGAffineTransformMakeScale(4.0 , 4.0)
        image1Blur.alpha = 0.0
        image2.transform  = CGAffineTransformMakeScale(1.2 , 1.2)
        image2.alpha = 1.0
        UIView.commitAnimations()
        
    }
    
    func animationDepthOut(image1 : UIImageView , image1Blur: UIImageView, image2: UIImageView){
        image1.hidden = false
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.setAnimationDuration(0.8)
        image1 .transform = CGAffineTransformMakeScale(1.2 , 1.2)
        image1 .alpha = 1.0
        image1Blur.transform  = CGAffineTransformMakeScale(1.2 , 1.2)
        image1Blur.alpha = 0.0
        image2.transform  = CGAffineTransformMakeScale(1 , 1)
        image2.alpha = 0.0
        UIView.commitAnimations()
        
        
    }
    func textIn(text1: UILabel , text2: UILabel){
        text1.alpha = 0.0
        text2.alpha = 0.0
        text1.hidden = false
        text2.hidden = false
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.setAnimationDuration(0.6)
        text1.alpha = 1.0
        text2.alpha = 1.0
        UIView.commitAnimations()
    
    }
    func textOut(text1: UILabel , text2: UILabel){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.setAnimationDuration(0.6)
        text1.alpha = 0.0
        text2.alpha = 0.0
        UIView.commitAnimations()
        text1.hidden = true
        text2.hidden = true
    
    }
    
    func blurImage(blurValue: Float , image: UIImage) -> UIImage {
        let imageToBlur = CIImage(image: image)
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter!.setValue(imageToBlur, forKey: "inputImage")
        blurfilter!.setValue(blurValue, forKey: "inputRadius")
        let resultImage = blurfilter!.valueForKey("outputImage") as! CIImage
        
        return UIImage(CIImage: resultImage)
    }

    
    func getProductsFromQuestions() {
        var counts = [Int64: Int]()
        
        for id in GlobalVars.questionAnswers.sort() {
            counts[id] = 0;
            
            for productId in GlobalVars.questionAnswers.sort() {
                if (productId == id) {
                    counts[id] = counts[id]! + 1
                }
            }
        }
        
        var countsSorted = counts.sort({ (a, b) -> Bool in
            return a.1 > b.1
        })
        
        self.firstProduct = self.productModel.find(countsSorted[0].0)
        self.secondProduct = self.productModel.find(countsSorted[1].0)
        self.thirdProduct = self.productModel.find(countsSorted[2].0)
        
        GlobalVars.productsFinded.append(self.firstProduct)
        GlobalVars.productsFinded.append(self.secondProduct)
        GlobalVars.productsFinded.append(self.thirdProduct)
    }
    
    
   
}
