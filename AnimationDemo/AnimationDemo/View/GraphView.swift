//
//  GraphView.swift
//  AnimationDemo
//
//  Created by 胡琰士 on 16/11/29.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    //渐变的特性
    var startColor:UIColor = UIColor.RGB(r: 250, g: 233, b: 222)
    var endColor:UIColor = UIColor.RGB(r: 252, g: 79, b: 8)

    var graphPoints:[Int] = [4, 2, 6, 4, 5, 8, 3]

    init(){
        super.init(frame: CGRectZero)
        backgroundColor = UIColor.yellowColor()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        let width = rect.width
        let height = rect.height
        //设置圆角
        var path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: 8, height: 8))
        path.addClip()
        //获取当前上线文
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.CGColor,endColor.CGColor]
        //设置色彩空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //设置颜色区域
        let colorLocations:[CGFloat] = [0.0, 1.0]
        //创建渐变
        let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
        
        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x: 0, y: self.bounds.height)
        //绘制渐变
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, CGGradientDrawingOptions.DrawsAfterEndLocation)
        
        let margin:CGFloat = 20.0
        //计算X点
        var columnXPoint = { (column:Int) -> CGFloat in
            //计算两点的距离
            let spacer = (width - margin*2 - 4) / CGFloat((self.graphPoints.count - 1))
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        //计算Y点
        let topBorder:CGFloat = 60
        let bottomBorder:CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.maxElement()
        var columnYPoint = { (graphPoint:Int) -> CGFloat in
            var y:CGFloat = CGFloat(graphPoint) / CGFloat(maxValue!) * graphHeight
            y = graphHeight + topBorder - y
            return y
        }
        
        //划线
        UIColor.whiteColor().setFill()
        UIColor.whiteColor().setStroke()
        
        var graphPath = UIBezierPath()
        graphPath.moveToPoint(CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
            for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
                graphPath.addLineToPoint(nextPoint)
        }
        graphPath.stroke()
    }
}
