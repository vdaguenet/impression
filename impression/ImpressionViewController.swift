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

    @IBOutlet weak var surprise: UIButton!
    
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
        
        /* Text INIT  */
       /* self.citation.hidden = true
        self.auteur.hidden = true*/
        self.descript.hidden = true
        self.produit.hidden = true
        
        self.citation.text = self.firstProduct.get(self.productModel.expressions.citation);
        self.auteur.text = self.firstProduct.get(self.productModel.expressions.auteurCitation);
        
        /* IMAGE init */
        
        self.firstImage.image = UIImage(named :"impression_1_2.png");
        self.firstImage.transform = CGAffineTransformMakeScale(1.2 , 1.2)
        self.secondImage.image = UIImage(named :self.firstProduct.get(self.productModel.expressions.image ));
       
    }
    
    func longTouch( longTouch : UIGestureRecognizer){
        if(longTouch.state == UIGestureRecognizerState.Began){
            print("view Began")
            if(self.layerCount == 0){
                touchBlur(self.firstImage, image1Blur: self.firstBlurImage);
            }else if(self.layerCount == 1){
                touchBlur(self.secondImage, image1Blur: self.secondBlurImage);
                
            }
            
        }else if(longTouch.state == UIGestureRecognizerState.Ended) {
            print("view Ended")
            self.layerCount = self.layerCount +  1 ;
            if(self.layerCount == 1){
                animationDepthIn(self.firstImage, image1Blur: self.firstBlurImage, image2: self.secondImage );
            }else if(self.layerCount == 2){
                animationDepthIn(self.secondImage, image1Blur:self.secondBlurImage, image2: self.thirdImage );
            }
            print(self.layerCount)
            
        }
        
    }
    func touchBlur(image1 : UIImageView , image1Blur: UIImageView){
        
        UIView.beginAnimations(nil, context: nil)
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
        UIView.setAnimationDuration(0.6)
        //self.firstImage.image?.setValue(3.0, forKey: "scale")
        image1 .transform = CGAffineTransformMakeScale(4.0 , 4.0)
        image1 .alpha = 0.0
        image1Blur.transform  = CGAffineTransformMakeScale(4.0 , 4.0)
        image1Blur.alpha = 0.0
        image2.transform  = CGAffineTransformMakeScale(1.1 , 1.1)
        image2.alpha = 1.0
        UIView.commitAnimations()
    }
    
    func animationDepthOut(image1 : UIImageView , image1Blur: UIImageView, image2: UIImageView){
        
        
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
