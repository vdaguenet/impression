//
//  StoreView.swift
//  impression
//
//  Created by vdaguenet on 07/12/15.
//  Copyright © 2015 Arthur Valentin. All rights reserved.
//

import UIKit

class StoreView: UIView {    
    init(frame: CGRect, name: String, adress: String, city: String, hours: String, distance: Float) {
        super.init(frame: frame)
        
        let nameLabel = UILabel(frame: CGRectMake(20, 16, frame.width - 20, 30))
        nameLabel.font = UIFont(name: "CrimsonText-Bold", size: 16.0)
        nameLabel.text = name
        
        let adressLabel = UILabel(frame: CGRectMake(20, 40, frame.width - 20, 20))
        adressLabel.font = UIFont(name: "Raleway-Light", size: 13.0)
        adressLabel.text = adress
        
        let cityLabel = UILabel(frame: CGRectMake(20, 54, frame.width - 20, 20))
        cityLabel.font = UIFont(name: "Raleway-Light", size: 13.0)
        cityLabel.text = city

        let hoursLabel = UILabel(frame: CGRectMake(20, 90, frame.width - 20, 20))
        hoursLabel.font = UIFont(name: "Raleway-Medium", size: 14.0)
        hoursLabel.text = hours
        
        let btn = UIButton(frame: CGRectMake(35, 130, 230, 42))
        btn.setBackgroundImage(UIImage(named: "button-background"), forState: UIControlState.Normal)
        btn.setTitle("C H O I S I R  C E  M A G A S I N", forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont(name: "Raleway-Medium", size: 12.0)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        let pin = UIImageView(image: UIImage(named: "pin"))
        pin.frame = CGRectMake(frame.width - 50, 21, 28, 28)
        pin.contentMode = UIViewContentMode.ScaleAspectFit
        
        let distanceLabel = UILabel(frame: CGRectMake(frame.width - 75, 51, 80, 12))
        distanceLabel.textAlignment = NSTextAlignment.Center
        distanceLabel.text = String(distance) + " m"
        distanceLabel.font = UIFont(name: "Raleway-Medium", size: 10.0)
        
        
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(nameLabel)
        self.addSubview(adressLabel)
        self.addSubview(cityLabel)
        self.addSubview(hoursLabel)
        self.addSubview(pin)
        self.addSubview(distanceLabel)
        self.addSubview(btn)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}