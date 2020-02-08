//
//  CommonClass.swift
//  Eko-Test
//
//  Created by ShopMyar on 2/8/20.
//  Copyright © 2020 ShopMyar. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView
{
    func setProfileImage(url : String , cornerRadius : Float)
       {
           let url = URL(string: url)
           let processor = DownsamplingImageProcessor(size: self.frame.size)
               >> RoundCornerImageProcessor(cornerRadius: CGFloat(cornerRadius))
           self.kf.indicatorType = .activity
           self.kf.setImage(
               with: url,
               placeholder: UIImage(named: ""),
               options: [
                   .processor(processor),
                   .scaleFactor(UIScreen.main.scale),
                   .transition(.fade(1)),
                   .cacheOriginalImage
               ])
           {
               result in
               switch result {
               case .success(let _): break
                   
               case .failure(let _): break
                  
               }
           }
       }
}

extension UITextField {
    
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
    
   
    
    func txtPadding()
    {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
        
    }
   
    
    
}
