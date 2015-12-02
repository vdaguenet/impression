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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getProductsFromQuestions()
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
