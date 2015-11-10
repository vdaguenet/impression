//
//  ImpressionViewController.swift
//  impression
//
//  Created by DAGUENET Valentin on 10/11/15.
//  Copyright © 2015 Arthur Valentin. All rights reserved.
//

import UIKit

class ImpressionViewController: UIViewController {
    @IBOutlet weak var answersContainer: UILabel!

    @IBAction func backFromSurpriseView(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(GlobalVars.questionAnswers)
        
        for answer in GlobalVars.questionAnswers {
            self.answersContainer.text = self.answersContainer.text! + "\n - " + answer
        }
        
    }
}
