//
//  CounterView.swift
//  AnimationDemo
//
//  Created by 胡琰士 on 16/11/25.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit
import Foundation

let NoOfGlasses = 8
let π:CGFloat = CGFloat(M_PI)
class CounterView: UIView {
    var counter:Int = 5 {
        didSet {
            guard self.counter >= 0 && self.counter <= 8 else{
                return
            }
            if counter <= NoOfGlasses {
                setNeedsDisplay()
            }
            countLabel.text = String(self.counter)
            checkTotal()
        }
    }
    var outlineColor:UIColor = UIColor.RGB(r: 30, g: 77, b: 71)
    var counterColor:UIColor = UIColor.RGB(r: 62, g: 158, b: 149)
    var countLabel:UILabel!
    fileprivate var medalView:MedalView!
    init(){
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.clear
        countLabel = UILabel()
        countLabel.font = UIFont.systemFont(ofSize: 36)
        countLabel.textColor = UIColor.black
        countLabel.text = "\(counter)"
        addSubview(countLabel)
        countLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(0)
        }
        medalView = MedalView()
        medalView.contentMode = .scaleAspectFit
        addSubview(medalView)
        medalView.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(80)
            make.centerX.equalTo(0)
            make.bottom.equalTo(0)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func checkTotal(){
        if counter >= 8 {
            medalView.showMedal(true)
        }else {
            medalView.showMedal(false)
        }
    }
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        
        let radius:CGFloat = max(bounds.width, bounds.height)
        
        let arcWidth:CGFloat = 76
        
        let startAngle:CGFloat = 3 * π / 4
        let endAngle:CGFloat = π / 4
        
        let path = UIBezierPath(arcCenter: center, radius: radius/2 - arcWidth/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        let angleDifference:CGFloat = 2 * π - startAngle + endAngle
        
        let arcLengthPerGlass = angleDifference / CGFloat(NoOfGlasses)
        
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        let outlinePath = UIBezierPath(arcCenter: center, radius: bounds.width/2 - 2.5, startAngle: startAngle, endAngle: outlineEndAngle, clockwise: true)
        
        outlinePath.addArc(withCenter: center, radius: bounds.width/2 - arcWidth + 2.5, startAngle: outlineEndAngle, endAngle: startAngle, clockwise: false)
        
        outlinePath.close()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
        //计数器查看标记
        let context = UIGraphicsGetCurrentContext()
        //保存原始状态
        context?.saveGState()
        outlineColor.setFill()
        
        let markerWidth:CGFloat = 5.0
        let markerSize:CGFloat = 10.0
        //定位左上角的矩形标记
        let markerPath = UIBezierPath(rect: CGRect(x: -markerWidth/2, y: 0, width: markerWidth, height: markerSize))
        //移动到左上方到以前的中心位置
        context?.translateBy(x: rect.width/2, y: rect.height/2)
        for i in 1...NoOfGlasses {
            //在中心的背景
            context?.saveGState()
            //计算旋转角度
            let angle = arcLengthPerGlass * CGFloat(i) + startAngle - π/2
            //旋转和平移
            context?.rotate(by: angle)
            context?.translateBy(x: 0, y: rect.height/2 - markerSize)
            //矩形填充
            markerPath.fill()
            //恢复背景的
            context?.restoreGState()
        }
        //恢复原来的状态，
        context?.restoreGState()
    }
}
