//
//  AllExtension.swift
//  InternetConnection
//
//  Created by ds-mayur on 30/8/2020.
//

import UIKit.UIButton
import UIKit.UIColor

extension UIButton{
    
    func makeEdgesCircular(cornerRadius radi : CGFloat = 10,
                           backgroundColor color : UIColor = UIColor(named: "brand")!){
        
        self.layer.cornerRadius = radi
        self.layer.masksToBounds = true
        self.backgroundColor = color
        self.setTitleColor(.white, for: .normal)
    }
}
