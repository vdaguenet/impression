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
