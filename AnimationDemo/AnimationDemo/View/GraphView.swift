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
    var startColor:UIColor = UIColor.RGB(r: 250, g: 183, b: 146)
    var endColor:UIColor = UIColor.RGB(r: 252, g: 79, b: 8)

    var graphPoints:[Int] = [4, 2, 6, 4, 5, 8, 3]
    
    //平均值
    private var waterDrunk:UILabel!
    private var averageWaterDrunk:UILabel!
    private var maxLabel:UILabel!
    private var minLabel:UILabel!

    init(){
        super.init(frame: CGRectZero)
        backgroundColor = UIColor.yellowColor()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGraphDisplay()
    }
    private func setupGraphDisplay(){
        let margin:CGFloat = 20.0
        let topBorder:CGFloat = 60
        let bottomBorder:CGFloat = 50
        let textFont = UIFont.systemFontOfSize(14)
        waterDrunk = UILabel()
        waterDrunk.text = "Water Drunk"
        waterDrunk.font = textFont
        waterDrunk.textColor = UIColor.whiteColor()
        addSubview(waterDrunk)
        waterDrunk.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(margin)
            make.top.equalTo(10)
        }
        averageWaterDrunk = UILabel()
        averageWaterDrunk.text = "Average:"
        averageWaterDrunk.font = textFont
        averageWaterDrunk.textColor = UIColor.whiteColor()
        let average = graphPoints.reduce(0, combine: +) / graphPoints.count
        averageWaterDrunk.text! += "\(average)"
        addSubview(averageWaterDrunk)
        averageWaterDrunk.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(waterDrunk)
            make.top.equalTo(waterDrunk.snp_bottom).offset(10)
        }
        
        maxLabel = UILabel()
        maxLabel.font = textFont
        maxLabel.textColor = UIColor.whiteColor()
        maxLabel.text = "\(graphPoints.maxElement())"
        addSubview(maxLabel)
        maxLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(topBorder-7)
            make.left.equalTo(self.snp_right).offset(-margin)
        }
        
        minLabel = UILabel()
        minLabel.font = textFont
        minLabel.textColor = UIColor.whiteColor()
        minLabel.text = "0"
        addSubview(minLabel)
        minLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(-bottomBorder+7)
            make.left.equalTo(self.snp_right).offset(-margin)
        }
        
        //添加底部时间
        let dateFormatter = NSDateFormatter()
        let calendat = NSCalendar.currentCalendar()
        let componentOptions:NSCalendarUnit = .Weekday
        let components = calendat.components(componentOptions, fromDate: NSDate())
        var weekday = components.weekday
        
        let days = ["S", "S", "M", "T", "W", "T", "F"]
        //计算X点
        let columnXPoint = { (column:Int) -> CGFloat in
            //计算两点的距离
            let spacer = (self.frame.width - margin*2 - 4) / CGFloat((self.graphPoints.count - 1))
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }

        for i in (0...days.count).reverse() {
            let dateLabel = UILabel()
            dateLabel.textColor = UIColor.whiteColor()
            dateLabel.font = textFont
            if weekday == 7 {
                weekday = 0
            }
            dateLabel.text = days[weekday--]
            if weekday < 0 {
                weekday = days.count - 1
            }
            addSubview(dateLabel)
            dateLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.bottom.equalTo(-20)
                make.left.equalTo(columnXPoint(i)-5)
            })
        }
        
        
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
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        //保存当前上下文状态
        CGContextSaveGState(context)
        // 一下代码是上下文剪裁的区域
        var clippingPath = graphPath.copy() as! UIBezierPath
        
        clippingPath.addLineToPoint(CGPoint(x: columnXPoint(graphPoints.count-1), y: height))
        clippingPath.addLineToPoint(CGPoint(x: columnXPoint(0), y: height))
        clippingPath.addClip()
        //剪裁区域填充颜色
         //
        let highestYPoint = columnYPoint(maxValue!)
        startPoint = CGPoint(x:margin, y: highestYPoint)
        endPoint = CGPoint(x:margin, y:self.bounds.height)
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, CGGradientDrawingOptions.DrawsAfterEndLocation)
        //获取保存的上下文
        CGContextRestoreGState(context)
        //添加折点圆角
        for i in 0..<graphPoints.count {
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            point.x -= 5.0/2
            point.y -= 5.0/2
            let circle = UIBezierPath(ovalInRect: CGRect(origin: point, size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
        
        //绘制三条线
        var linePath = UIBezierPath()
        
        linePath.moveToPoint(CGPoint(x: margin, y: topBorder))
        linePath.addLineToPoint(CGPoint(x: width - margin, y: topBorder))
        
        linePath.moveToPoint(CGPoint(x: margin, y: graphHeight/2 + topBorder))
        linePath.addLineToPoint(CGPoint(x: width - margin, y: graphHeight/2 + topBorder))
        
        linePath.moveToPoint(CGPoint(x: margin, y: height - bottomBorder))
        linePath.addLineToPoint(CGPoint(x: width - margin, y: height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: 0.3)
        color.setStroke()
        linePath.lineWidth = 1.0
        linePath.stroke()
        
    }
}
