//
//  CustomSlider.swift
//  impression
//
//  Created by DAGUENET Valentin on 06/01/16.
//  Copyright © 2016 Arthur Valentin. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {
    override func trackRectForBounds(bounds: CGRect) -> CGRect {
        print("track")
        
        return bounds
    }
}
