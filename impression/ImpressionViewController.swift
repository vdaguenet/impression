//
//  ImpressionViewController.swift
//  impression
//
//  Created by DAGUENET Valentin on 10/11/15.
//  Copyright © 2015 Arthur Valentin. All rights reserved.
//

import UIKit

class ImpressionViewController: UIViewController {
    @IBAction func backFromSurpriseView(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("[Impression] Les produits trouvés par les questions:")
        print(GlobalVars.questionAnswerProducts);
        
    }
}
