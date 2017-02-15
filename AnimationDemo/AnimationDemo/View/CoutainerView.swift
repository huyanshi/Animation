//
//  CoutainerView.swift
//  AnimationDemo
//
//  Created by 胡琰士 on 16/11/29.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class CoutainerView: UIView {
    
    fileprivate var counterView:CounterView!
    fileprivate var graphView:GraphView!
    var isGraphViewShowing = false
    
    var counter:Int = 0{
        didSet {
            if counter < 0 {counter = 0}
            if counter > 8 {counter = 8}
            counterView.counter = self.counter
        }
    }
    
    init(){
        super.init(frame: CGRect.zero)
        setSubview()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    fileprivate func setupGraphDisplay(){
        
        let noOfDays:Int = 7
        
        graphView.graphPoints[graphView.graphPoints.count-1] = counterView.counter
        
        graphView.setNeedsDisplay()
        
        
    }

    fileprivate func setSubview(){
        backgroundColor = UIColor.clear
        counterView = CounterView()
        graphView = GraphView()
        addSubview(graphView)
        addSubview(counterView)
        counterView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(0)
            make.width.height.equalTo(230)
        }
        graphView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(0)
            make.width.equalTo(300)
            make.height.equalTo(250)
        }
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CoutainerView.counterViewTap)))
    }
    func counterViewTap(){
        if isGraphViewShowing {
            UIView.transition(from: graphView, to: counterView, duration: 1.0, options: [UIViewAnimationOptions.transitionFlipFromLeft,UIViewAnimationOptions.showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: counterView, to: graphView, duration: 1.0, options: [UIViewAnimationOptions.transitionFlipFromRight, UIViewAnimationOptions.showHideTransitionViews], completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    

}
