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
    @IBOutlet var myView: UIView!
    
    @IBOutlet weak var citation: UILabel!
    @IBOutlet weak var auteur: UILabel!
    @IBOutlet weak var produit: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var boutton12: DualCircleButton!
    @IBOutlet weak var boutton11: DualCircleButton!
    @IBOutlet weak var Boutton21: DualCircleButton!
    @IBOutlet weak var boutton13: DualCircleButton!
    @IBOutlet weak var surprise: DualCircleButton!
    @IBOutlet weak var cross: UIButton!
    @IBOutlet weak var labelDescript: UILabel!
    var  products = [Int64: Int]()
    var myArray1 : [Int] = []
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
        self.cross.alpha = 0
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
       /* self.secondImage.image = UIImage(named :self.firstProduct.get(self.productModel.expressions.imageCitation ));
        self.thirdImage.image = UIImage(named :self.firstProduct.get(self.productModel.expressions.image ));
        
        self.firstBlurImage.image = self.blurImage(15.0, image : self.firstImage.image! );
        self.secondBlurImage.image = self.blurImage(15.0, image : self.secondImage.image! );*/
        
        self.firstImage.transform = CGAffineTransformMakeScale(1.2, 1.2)
       
    }
    
    func setImage(sender: Int) {
        let buttonId = sender
        self.citation.text  = GlobalVars.productsFinded[buttonId].get(self.productModel.expressions.citation);
        self.auteur.text = GlobalVars.productsFinded[buttonId].get(self.productModel.expressions.auteurCitation);
        self.descript.text = GlobalVars.productsFinded[buttonId].get(self.productModel.expressions.description);
        self.produit.text = GlobalVars.productsFinded[buttonId].get(self.productModel.expressions.name);
        self.firstImage.image = UIImage(named :"impression_1_1.png");
        self.secondImage.image = UIImage(named :GlobalVars.productsFinded[buttonId].get(self.productModel.expressions.imageCitation ));
        self.thirdImage.image = UIImage(named :GlobalVars.productsFinded[buttonId].get(self.productModel.expressions.image ));
        self.firstBlurImage.image = self.firstImage.image
        self.secondBlurImage.image = self.secondImage.image
        self.firstImage.transform = CGAffineTransformMakeScale(1.2, 1.2)
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        UIButton.animateWithDuration(0.4, delay: 0.0,options: [ .Autoreverse], animations: {
            self.cross.alpha = 0.5
            self.cross.transform = CGAffineTransformMakeScale(0.8, 0.8)
            }, completion: nil)
        
        if(self.layerCount>0){
            if(self.layerCount == 1){
                animationDepthOut(self.firstImage, image1Blur: self.firstBlurImage, image2: self.secondImage )
                textOut(self.citation , text2: self.auteur );
             
                self.boutton11.hidden = false
                self.boutton12.hidden = false
                self.boutton13.hidden = false
                UIView.animateWithDuration(
                    Double(0.4),
                    animations: {
                        self.cross.alpha = 0
                        self.Boutton21.alpha = 0
                        self.boutton11.alpha = 1
                        self.boutton12.alpha = 1
                        self.boutton13.alpha = 1
                    },
                    completion: { finished in
                        if(finished) {
                            self.Boutton21.hidden = true
                            self.cross.hidden = true
                        }
                    }
                )
                
                
            }else if(self.layerCount == 2){
                textIn(self.citation , text2: self.auteur );
                textOut(self.produit , text2: self.descript);
                animationDepthOut(self.secondImage, image1Blur:self.secondBlurImage, image2: self.thirdImage )
                
                self.Boutton21.hidden = false
                UIView.animateWithDuration(
                    Double(0.4),
                    animations: {
                        self.Boutton21.alpha = 1
                        self.surprise.alpha = 0
                    },
                    completion: { finished in
                        if(finished) {
                           self.surprise.hidden = true
                        }
                    }
                )
                
            }
            self.layerCount  = self.layerCount - 1 ;
        }
    }
    func CGPointDistanceSquared(from from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y);
    }
    func CGPointDistance(from from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to));
    }
    func longTouch( longTouch : UIGestureRecognizer){
        let pos = longTouch.locationInView(self.myView)
        if(self.layerCount==0){
            if(CGPointDistance(from: pos, to: self.boutton11.frame.origin ) < 40){
                setImage(1);
            }else if(CGPointDistance(from: pos, to: self.boutton12.frame.origin ) < 40){
                setImage(2);
            }else if(CGPointDistance(from: pos, to: self.boutton13.frame.origin ) < 40){
                setImage(0);
            }
        }
        
        
        if(longTouch.state == UIGestureRecognizerState.Began){
            
            if(self.layerCount == 0){
                touchBlur(self.firstImage, image1Blur: self.firstBlurImage);
                 self.cross.hidden = false ;
                UIView.animateWithDuration(
                    Double(0.4),
                    animations: {
                        self.cross.alpha = 1
                    },
                    completion: { finished in
                        if(finished) {
                           
                        }
                    }
                )
            }else if(self.layerCount == 1){
                touchBlur(self.secondImage, image1Blur: self.secondBlurImage);
            }
            
        }else if(longTouch.state == UIGestureRecognizerState.Ended) {
            self.layerCount = self.layerCount +  1 ;
            if(self.layerCount == 1){
                animationDepthIn(self.firstImage, image1Blur: self.firstBlurImage, image2: self.secondImage );
                textIn(self.citation , text2: self.auteur );
                 self.Boutton21.hidden = false
                UIView.animateWithDuration(
                    Double(0.4),
                    animations: {
                        self.boutton11.alpha = 0
                        self.boutton12.alpha = 0
                        self.boutton13.alpha = 0
                        self.Boutton21.alpha = 1
                    },
                    completion: { finished in
                        if(finished) {
                           
                            self.boutton11.hidden = true
                            self.boutton12.hidden = true
                            self.boutton13.hidden = true
                        }
                    }
                )
              
                
                
            }else if(self.layerCount == 2){
                textOut(self.citation , text2: self.auteur );
                animationDepthIn(self.secondImage, image1Blur:self.secondBlurImage, image2: self.thirdImage );
                textIn(self.produit , text2: self.descript);
                self.surprise.hidden = false
                UIView.animateWithDuration(
                    Double(0.4),
                    animations: {
                        self.Boutton21.alpha = 0
                        self.surprise.alpha = 1
                    },
                    completion: { finished in
                        if(finished) {
                            self.Boutton21.hidden = true
                        }
                    }
                )
            }
           
          //  print(self.layerCount)
            
        }
        
    }
    
    func touchBlur(image1 : UIImageView , image1Blur: UIImageView){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDelay(0.0)
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
        UIView.setAnimationDelay(0.4)
        UIView.setAnimationDuration(0.6)
        text1.alpha = 1.0
        text2.alpha = 1.0
        UIView.commitAnimations()
    
    }
    func textOut(text1: UILabel , text2: UILabel){
        UIView.animateWithDuration(
            Double(0.4),
            animations: {
                text1.alpha = 0.0
                text2.alpha = 0.0
            },
            completion: { finished in
                if(finished) {
                    text1.hidden = true
                    text2.hidden = true
                }
            }
        )
    
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
        /*
        Appel à la bse de données. Il fonctione mais on ne s'en sert pas pour la démo afin de montrer des produits specifiques
        
        self.firstProduct = self.productModel.find(countsSorted[0].0)
        self.secondProduct = self.productModel.find(countsSorted[1].0))
        self.thirdProduct = self.productModel.find(countsSorted[2].0))
        */
        
        self.firstProduct = self.productModel.find(Int64(2))
        self.secondProduct = self.productModel.find(Int64(3))
        self.thirdProduct = self.productModel.find(Int64(5))
        
        
        GlobalVars.productsFinded.append(self.firstProduct)
        GlobalVars.productsFinded.append(self.secondProduct)
        GlobalVars.productsFinded.append(self.thirdProduct)
    }
    
    
   
}
