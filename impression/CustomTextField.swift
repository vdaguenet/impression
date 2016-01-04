//
//  CustomTextField.swift
//  impression
//
//  Created by DAGUENET Valentin on 04/01/16.
//  Copyright © 2016 Arthur Valentin. All rights reserved.
//

import UIKit

class CustomTextField : UITextField {
    let padding = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 5);
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    private func newBounds(bounds: CGRect) -> CGRect {

        var newBounds = bounds
        newBounds.origin.x += padding.left
        newBounds.origin.y += padding.top
        newBounds.size.height -= padding.top + padding.bottom
        newBounds.size.width -= padding.left + padding.right
        
        return newBounds
    }
    
    func addSearchIcon() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search")
        imageView.contentMode = UIViewContentMode.Center
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: self.frame.height)
        self.addSubview(imageView)
        
        self.leftView = imageView
        self.leftViewMode = UITextFieldViewMode.Always
    }
}