//
//  MedalView.swift
//  AnimationDemo
//
//  Created by 胡琰士 on 16/12/6.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class MedalView: UIImageView {
    
    lazy var medalImage:UIImage = self.createMedalImage()
    
    func showMedal(_ show:Bool){
        if show {
            image = medalImage
        }else {
            image = nil
        }
    }
    
    func createMedalImage() -> UIImage {
        let size = CGSize(width:120,height:200)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        //Gold colors
        let darkGoldColor = UIColor(red: 0.6, green: 0.5, blue: 0.15, alpha: 1.0)
        let midGoldColor = UIColor(red: 0.86, green: 0.73, blue: 0.3, alpha: 1.0)
        let lightGoldColor = UIColor(red: 1.0, green: 0.98, blue: 0.9, alpha: 1.0)
        
        //Lower Ribbon
        var lowerRibbonPath = UIBezierPath()
        lowerRibbonPath.move(to: CGPoint(x: 0, y: 0))
        lowerRibbonPath.addLine(to: CGPoint(x: 40,y: 0))
        lowerRibbonPath.addLine(to: CGPoint(x: 78, y: 70))
        lowerRibbonPath.addLine(to: CGPoint(x: 38, y: 70))
        lowerRibbonPath.close()
        UIColor.red.setFill()
        lowerRibbonPath.fill()
        //丝带
        var claspPath = UIBezierPath(roundedRect: CGRect(x: 36, y: 62, width: 43, height: 20), cornerRadius: 5)
        claspPath.lineWidth = 5
        darkGoldColor.setStroke()
        claspPath.stroke()
        
        //Medallion
        var medallionPath = UIBezierPath(ovalIn: CGRect(x: 8, y: 72, width: 100, height: 100))
        //保存当前上下文状态
        context?.saveGState()
        medallionPath.addClip()
        //[darkGoldColor.cgColor,midGoldColor.cgColor , lightGoldColor.cgColor]
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [darkGoldColor.cgColor,midGoldColor.cgColor , lightGoldColor.cgColor] as! CFArray , locations: [0,0.51,1])
        context?.drawLinearGradient(gradient!, start: CGPoint(x: 40, y: 40), end: CGPoint(x: 40, y: 160), options: CGGradientDrawingOptions.drawsAfterEndLocation)
        
        context?.restoreGState()
        
        var transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        transform = transform.translatedBy(x: 15, y: 30)
        
        medallionPath.lineWidth = 2.0
        
        medallionPath.apply(transform)
        medallionPath.stroke()
        
        //Upper Ribbon
        var upperRibbonPath = UIBezierPath()
        upperRibbonPath.move(to: CGPoint(x: 68, y: 0))
        upperRibbonPath.addLine(to: CGPoint(x: 108, y: 0))
        upperRibbonPath.addLine(to: CGPoint(x: 78, y: 70))
        upperRibbonPath.addLine(to: CGPoint(x: 38, y: 70))
        upperRibbonPath.close()
        
        UIColor.blue.setFill()
        upperRibbonPath.fill()
        
        //绘制文字
        //只有NSString才能使用drawInRect()
        let numberOne = "1"
        let numberOneRect = CGRect(x: 47, y: 100, width: 50, height: 50)
        let font = UIFont(name: "Academy Engraved LET", size: 60)
        let textStyle = NSMutableParagraphStyle.default
        let numberOneAttributes = [
            NSFontAttributeName: font!,
            NSForegroundColorAttributeName: darkGoldColor]
        numberOne.draw(in: numberOneRect,
            withAttributes:numberOneAttributes)
        
        //阴影
        context?.beginTransparencyLayer(auxiliaryInfo: nil)
        let shadow:UIColor = UIColor.black.withAlphaComponent(0.8)
        let shadowOffset = CGSize(width: 2.0, height: 2.0)
        let shadowBlurRadius:CGFloat = 5
        context?.setShadow(offset: shadowOffset, blur: shadowBlurRadius, color: shadow.cgColor)
        
        context?.endTransparencyLayer()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }

}
