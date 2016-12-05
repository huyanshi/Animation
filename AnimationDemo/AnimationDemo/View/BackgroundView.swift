//
//  BackgroundView.swift
//  AnimationDemo
//
//  Created by 胡琰士 on 16/12/5.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
    
    var lightColor:UIColor = UIColor.RGB(r: 255, g: 255, b: 242)
    var darkColor:UIColor = UIColor.RGB(r: 223, g: 255, b: 247)
    var patternSize:CGFloat = 30
    
    
    
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, darkColor.CGColor)
        
        CGContextFillRect(context, rect)
        
        let drawSize = CGSize(width: patternSize, height: patternSize)
        
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        //
        darkColor.setFill()
        CGContextFillRect(drawingContext, CGRect(x: 0, y: 0, width: drawSize.width, height: drawSize.height))
        
        let trianglePath = UIBezierPath()
        //1
        trianglePath.moveToPoint(CGPoint(x: drawSize.width/2, y: 0))
        //2
        trianglePath.addLineToPoint(CGPoint(x: 0, y: drawSize.height/2))
        //3
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width, y: drawSize.height/2))
        //4
        trianglePath.moveToPoint(CGPoint(x: 0, y: drawSize.height/2))
        //5
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width/2, y: drawSize.height))
        //6
        trianglePath.addLineToPoint(CGPoint(x: 0, y: drawSize.height))
        //7
        trianglePath.moveToPoint(CGPoint(x: drawSize.width, y: drawSize.height/2))
        //8
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width/2, y: drawSize.height))
        //9
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width, y: drawSize.height))
        lightColor.setFill()
        trianglePath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: image).setFill()
        CGContextFillRect(context, rect)
    }
   

}
