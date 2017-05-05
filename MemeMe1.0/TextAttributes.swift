//
//  TextAttributes.swift
//  MemeMe1.0
//
//  Created by Celia Gómez de Villavedón on 05/05/2017.
//  Copyright © 2017 Celia Gómez de Villavedón Pedrosa. All rights reserved.
//

import Foundation
import UIKit

class TextAttributes: UIViewController {
    
    //TextFields Text Attributes
    public func configureText(_ textField: UITextField) {
        
        let centeringText = NSMutableParagraphStyle()
        centeringText.alignment = .center
        
        let memeTextAttributes: [String:Any] = [
            NSStrokeColorAttributeName : UIColor.black,
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
            NSStrokeWidthAttributeName : -5.0,
            NSParagraphStyleAttributeName : centeringText
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
    }
    
    //Placeholder Text Attributes
    public let placeholderTextAttributes: [String:Any] = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName : UIColor.white,
        NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
        NSStrokeWidthAttributeName : -5.0,
        ]
    
    //Collection and Table Labels Text Attributes
    public func configureLabelText (_ label: UILabel) {
        
        let centeringText = NSMutableParagraphStyle()
        centeringText.alignment = .center
        
        let textLabelAttributes: [String:Any] = [
            NSStrokeColorAttributeName : UIColor.black,
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "Impact", size: 13)!,
            NSStrokeWidthAttributeName : -5.0,
            NSParagraphStyleAttributeName : centeringText
        ]
        
        label.attributedText = NSMutableAttributedString(string: label.text!, attributes: textLabelAttributes)        
    }
}
