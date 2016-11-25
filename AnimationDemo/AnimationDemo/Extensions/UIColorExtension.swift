//
//  UIColorExtension.swift
//  AnimationDemo
//
//  Created by 胡琰士 on 16/11/25.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func RGB(r r: CGFloat,g: CGFloat, b: CGFloat) -> UIColor {
        
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
