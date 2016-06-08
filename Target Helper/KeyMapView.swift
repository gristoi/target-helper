//
//  KeyMapView.swift
//  Target Helper
//
//  Created by Ian Gristock on 06/06/2016.
//  Copyright © 2016 Ian Gristock. All rights reserved.
//

import UIKit

class KeyMapView: UIView {
    
    var view: UIView!

    let colorDictionary = [
        "Red":UIColor(
            red: 1.0,
            green: 0.0,
            blue: 0.0,
            alpha: 1.0),
        "Green":UIColor(
            red: 0.0,
            green: 1.0,
            blue: 0.0, alpha: 1.0),
        "Blue":UIColor(
            red: 0.0,
            green: 0.0,
            blue: 1.0,
            alpha: 1.0),
        ]
    
    func colorButton(
        withColor color:UIColor,
                  title:String) -> UIButton
    {
        let newButton = UIButton(type: .System)
        newButton.backgroundColor = color
        newButton.setTitle(
            title,
            forState: .Normal)
        newButton.setTitleColor(
            UIColor.whiteColor(),
            forState: .Normal)
        return newButton
    }
    
    func displayKeyboard(){
        //generate an array of buttons
        var buttonArray = [UIButton]()
        for (myKey,myValue) in colorDictionary{
            buttonArray += [colorButton(
                withColor: myValue,
                title: myKey)
            ]
        }
        
        let stackView = UIStackView(arrangedSubviews: buttonArray)
        stackView.axis = .Horizontal
        stackView.distribution = .FillEqually
        stackView.alignment = .Fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        //autolayout the stack view - pin 30 up 20 left 20 right 30 down
        let viewsDictionary = ["stackView":stackView]
        let stackView_H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-20-[stackView]-20-|",  //horizontal constraint 20 points from left and right side
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary)
        let stackView_V = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-8-[stackView]-8-|", //vertical constraint 30 points from top and bottom
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary)
        self.addConstraints(stackView_H)
        self.addConstraints(stackView_V)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        displayKeyboard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        displayKeyboard()
    }
    
    
}
