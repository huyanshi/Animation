//
//  PushButtonView.swift
//  AnimationDemo
//
//  Created by 胡琰士 on 16/11/25.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class PushButtonView: UIButton {
    
    
    var isAddButton:Bool = true{
        didSet {
            if isAddButton {
                fillColor = UIColor.RGB(r: 87, g: 218, b: 213)
            }else {
                fillColor = UIColor.RGB(r: 238, g: 77, b: 77)
            }
            setNeedsDisplay()
        }
    }
    var fillColor:UIColor = UIColor.RGB(r: 87, g: 218, b: 213)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(isAddButton:Bool = true){
        super.init(frame: CGRect.zero)
        self.isAddButton = isAddButton
        backgroundColor = UIColor.clear
    }
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        //添加加号
        let plusHeight:CGFloat = 3.0
        let plusWidth:CGFloat = min(bounds.width, bounds.height) * 0.6
        
        let plusPath = UIBezierPath()
        plusPath.lineWidth = plusHeight
        plusPath.move(to: CGPoint(x: bounds.width/2 - plusWidth/2 + 0.5, y: bounds.height/2 + 0.5))
        plusPath.addLine(to: CGPoint(x: bounds.width/2 + plusWidth/2 + 0.5, y: bounds.height/2 + 0.5))
        
        if isAddButton {
        plusPath.move(to: CGPoint(x: bounds.width/2 + 0.5, y: bounds.height/2 - plusWidth/2 + 0.5))
        plusPath.addLine(to: CGPoint(x: bounds.width/2 + 0.5, y: bounds.height/2 + plusWidth/2 + 0.5))
            
        }
        
        UIColor.white.setStroke()
        plusPath.stroke()
    }

}
