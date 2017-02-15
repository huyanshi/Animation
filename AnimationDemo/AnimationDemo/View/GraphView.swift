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
    fileprivate var waterDrunk:UILabel!
    fileprivate var averageWaterDrunk:UILabel!
    fileprivate var maxLabel:UILabel!
    fileprivate var minLabel:UILabel!

    init(){
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.yellow
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGraphDisplay()
    }
    fileprivate func setupGraphDisplay(){
        let margin:CGFloat = 20.0
        let topBorder:CGFloat = 60
        let bottomBorder:CGFloat = 50
        let textFont = UIFont.systemFont(ofSize: 14)
        waterDrunk = UILabel()
        waterDrunk.text = "Water Drunk"
        waterDrunk.font = textFont
        waterDrunk.textColor = UIColor.white
        addSubview(waterDrunk)
        waterDrunk.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(margin)
            make.top.equalTo(10)
        }
        averageWaterDrunk = UILabel()
        averageWaterDrunk.text = "Average:"
        averageWaterDrunk.font = textFont
        averageWaterDrunk.textColor = UIColor.white
        let average = graphPoints.reduce(0, +) / graphPoints.count
        averageWaterDrunk.text! += "\(average)"
        addSubview(averageWaterDrunk)
        averageWaterDrunk.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(waterDrunk)
            make.top.equalTo(waterDrunk.snp_bottom).offset(10)
        }
        
        maxLabel = UILabel()
        maxLabel.font = textFont
        maxLabel.textColor = UIColor.white
        maxLabel.text = "\(graphPoints.max()!)"
        addSubview(maxLabel)
        maxLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(topBorder-7)
            make.left.equalTo(self.snp_right).offset(-margin)
        }
        
        minLabel = UILabel()
        minLabel.font = textFont
        minLabel.textColor = UIColor.white
        minLabel.text = "0"
        addSubview(minLabel)
        minLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(-bottomBorder+7)
            make.left.equalTo(self.snp_right).offset(-margin)
        }
        
        //添加底部时间
        let dateFormatter = DateFormatter()
        let calendat = Calendar.current
        let componentOptions:NSCalendar.Unit = .weekday
        let components = (calendat as NSCalendar).components(componentOptions, from: Date())
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

        for i in (0...days.count).reversed() {
            let dateLabel = UILabel()
            dateLabel.textColor = UIColor.white
            dateLabel.font = textFont
            if weekday == 7 {
                weekday = 0
            }
            
            dateLabel.text = days[weekday!]
            weekday = weekday! - 1
            if weekday! < 0 {
                weekday = days.count - 1
            }
            addSubview(dateLabel)
            dateLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.bottom.equalTo(-20)
                make.left.equalTo(columnXPoint(i)-5)
            })
        }
        
        
    }

    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        //设置圆角
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: 8, height: 8))
        path.addClip()
        //获取当前上线文
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.cgColor,endColor.cgColor]
        //设置色彩空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //设置颜色区域
        let colorLocations:[CGFloat] = [0.0, 1.0]
        //创建渐变
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations)
        
        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x: 0, y: self.bounds.height)
        //绘制渐变
        context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        
        let margin:CGFloat = 20.0
        //计算X点
        let columnXPoint = { (column:Int) -> CGFloat in
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
        let maxValue = graphPoints.max()
        let columnYPoint = { (graphPoint:Int) -> CGFloat in
            var y:CGFloat = CGFloat(graphPoint) / CGFloat(maxValue!) * graphHeight
            y = graphHeight + topBorder - y
            return y
        }
        
        //划线
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
            for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
                graphPath.addLine(to: nextPoint)
        }
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        //保存当前上下文状态
        context?.saveGState()
        // 一下代码是上下文剪裁的区域
        let clippingPath = graphPath.copy() as! UIBezierPath
        
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count-1), y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
        clippingPath.addClip()
        //剪裁区域填充颜色
         //
        let highestYPoint = columnYPoint(maxValue!)
        startPoint = CGPoint(x:margin, y: highestYPoint)
        endPoint = CGPoint(x:margin, y:self.bounds.height)
        
        context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        //获取保存的上下文
        context?.restoreGState()
        //添加折点圆角
        for i in 0..<graphPoints.count {
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            point.x -= 5.0/2
            point.y -= 5.0/2
            let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
        
        //绘制三条线
        let linePath = UIBezierPath()
        
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: graphHeight/2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight/2 + topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: 0.3)
        color.setStroke()
        linePath.lineWidth = 1.0
        linePath.stroke()
        
    }
}
