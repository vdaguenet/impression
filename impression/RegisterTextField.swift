//
//  RegisterTextField.swift
//  impression
//
//  Created by DAGUENET Valentin on 05/01/16.
//  Copyright © 2016 Arthur Valentin. All rights reserved.
//

import UIKit

class RegisterTextField: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addBorderBottom()
    }
    
    private func addBorderBottom() {
        let border = CALayer()
        border.frame = CGRectMake(CGFloat(0), self.frame.height - 1, self.frame.width, CGFloat(1))
        border.backgroundColor = UIColor(red:140/255.0, green:143/255.0, blue:144/255.0, alpha: 1.0).CGColor
        self.layer.addSublayer(border)
    }
}
