//: Playground - noun: a place where people can play

import UIKit

let size = CGSize(width:120,height:200)

UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
let context = UIGraphicsGetCurrentContext()

//Gold colors
let darkGoldColor = UIColor(red: 0.6, green: 0.5, blue: 0.15, alpha: 1.0)
let midGoldColor = UIColor(red: 0.86, green: 0.73, blue: 0.3, alpha: 1.0)
let lightGoldColor = UIColor(red: 1.0, green: 0.98, blue: 0.9, alpha: 1.0)

//Lower Ribbon
var lowerRibbonPath = UIBezierPath()
lowerRibbonPath.moveToPoint(CGPointMake(0, 0))
lowerRibbonPath.addLineToPoint(CGPointMake(40,0))
lowerRibbonPath.addLineToPoint(CGPointMake(78, 70))
lowerRibbonPath.addLineToPoint(CGPointMake(38, 70))
lowerRibbonPath.closePath()
UIColor.redColor().setFill()
lowerRibbonPath.fill()
//丝带
var claspPath = UIBezierPath(roundedRect: CGRect(x: 36, y: 62, width: 43, height: 20), cornerRadius: 5)
claspPath.lineWidth = 5
darkGoldColor.setStroke()
claspPath.stroke()

//Medallion
var medallionPath = UIBezierPath(ovalInRect: CGRect(x: 8, y: 72, width: 100, height: 100))
//保存当前上下文状态
CGContextSaveGState(context)
medallionPath.addClip()

let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [darkGoldColor.CGColor,midGoldColor.CGColor,lightGoldColor.CGColor], [0,0.51,1])
CGContextDrawLinearGradient(context, gradient, CGPoint(x: 40, y: 40), CGPoint(x: 40, y: 160), CGGradientDrawingOptions.DrawsAfterEndLocation)

CGContextRestoreGState(context)

var transform = CGAffineTransformMakeScale(0.8, 0.8)
transform = CGAffineTransformTranslate(transform, 15, 30)

medallionPath.lineWidth = 2.0

medallionPath.applyTransform(transform)
medallionPath.stroke()

//Upper Ribbon
var upperRibbonPath = UIBezierPath()
upperRibbonPath.moveToPoint(CGPointMake(68, 0))
upperRibbonPath.addLineToPoint(CGPointMake(108, 0))
upperRibbonPath.addLineToPoint(CGPointMake(78, 70))
upperRibbonPath.addLineToPoint(CGPointMake(38, 70))
upperRibbonPath.closePath()

UIColor.blueColor().setFill()
upperRibbonPath.fill()

//绘制文字
//只有NSString才能使用drawInRect()
let numberOne = "1"
let numberOneRect = CGRectMake(47, 100, 50, 50)
let font = UIFont(name: "Academy Engraved LET", size: 60)
let textStyle = NSMutableParagraphStyle.defaultParagraphStyle()
let numberOneAttributes = [
    NSFontAttributeName: font!,
    NSForegroundColorAttributeName: darkGoldColor]
numberOne.drawInRect(numberOneRect,
    withAttributes:numberOneAttributes)

let image = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()
