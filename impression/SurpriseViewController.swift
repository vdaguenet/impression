//
//  SurpriseViewController.swift
//  impression
//
//  Created by DAGUENET Valentin on 10/11/15.
//  Copyright © 2015 Arthur Valentin. All rights reserved.
//

import UIKit
import SQLite

class SurpriseViewController: UIViewController {
    @IBOutlet weak var imageImpression: UIImageView!
    @IBOutlet weak var imageProductTop: UIImageView!
    @IBOutlet weak var imageProductMiddle: UIImageView!
    @IBOutlet weak var imageProductBottom: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var chooseStore: UIButton!
    
    var productModel = ProductModel()
    var firstProduct: SQLite.Row!
    var secondProduct: SQLite.Row!
    var thirdProduct: SQLite.Row!
    
    @IBAction func backFromMapView(segue: UIStoryboardSegue) {
         getProductsFromQuestions()
    }
    
    override func viewDidLoad() {
        getProductsFromQuestions() 
    }
    
    override func viewWillAppear(animated: Bool) {
        self.imageImpression.alpha = 0
        self.imageImpression.center.y += 10
        self.imageProductTop.alpha = 0
        self.imageProductTop.center.y += 10
        self.imageProductMiddle.alpha = 0
        self.imageProductMiddle.center.y += 10
        self.imageProductBottom.alpha = 0
        self.imageProductBottom.center.y += 10
        self.titleLabel.alpha = 0
        self.titleLabel.center.y += 7
        self.text.alpha = 0
        self.text.center.y += 7
        self.chooseStore.alpha = 0
        self.chooseStore.center.y += 7
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.8, delay: 0.0, options: [ .CurveEaseOut ], animations: {
            self.imageImpression.alpha = 1
            self.imageImpression.center.y -= 10
            }, completion: nil)
        UIView.animateWithDuration(0.8, delay: 0.2, options: [ .CurveEaseOut ], animations: {
            self.imageProductTop.alpha = 1
            self.imageProductTop.center.y -= 10
            }, completion: nil)
        UIView.animateWithDuration(0.8, delay: 0.4, options: [ .CurveEaseOut ], animations: {
            self.imageProductMiddle.alpha = 1
            self.imageProductMiddle.center.y -= 10
            }, completion: nil)
        UIView.animateWithDuration(0.8, delay: 0.6, options: [ .CurveEaseOut ], animations: {
            self.imageProductBottom.alpha = 1
            self.imageProductBottom.center.y -= 10
            }, completion: nil)
        UIView.animateWithDuration(1.1, delay: 1.3, options: [ .CurveEaseOut ], animations: {
            self.titleLabel.alpha = 1
            self.titleLabel.center.y -= 7
            }, completion: nil)
        UIView.animateWithDuration(1.1, delay: 1.5, options: [ .CurveEaseOut ], animations: {
            self.text.alpha = 1
            self.text.center.y -= 7
            }, completion: nil)
        UIView.animateWithDuration(1.1, delay: 1.8, options: [ .CurveEaseOut ], animations: {
            self.chooseStore.alpha = 1
            self.chooseStore.center.y -= 7
            }, completion: nil)
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
        setImages();
    }
    
    func setImages(){
        
        imageImpression.image =  UIImage(named :"impression_1_1.png");
        imageProductTop.image = UIImage(named :self.firstProduct.get(self.productModel.expressions.image ));
        imageProductMiddle.image = UIImage(named :self.secondProduct.get(self.productModel.expressions.image ));
        imageProductBottom.image = UIImage(named :self.thirdProduct.get(self.productModel.expressions.image ));
        
        
        
    }
}
