//
//  CoutainerView.swift
//  AnimationDemo
//
//  Created by 胡琰士 on 16/11/29.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class CoutainerView: UIView {
    
    private var counterView:CounterView!
    private var graphView:GraphView!
    var isGraphViewShowing = false
    
    var counter:Int = 0{
        didSet {
            counterView.counter = self.counter
        }
    }
    
    init(){
        super.init(frame: CGRectZero)
        setSubview()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func setSubview(){
        backgroundColor = UIColor.yellowColor()
        counterView = CounterView()
        graphView = GraphView()
        addSubview(graphView)
        addSubview(counterView)
        counterView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(0)
            make.width.height.equalTo(230)
        }
        graphView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(0)
            make.top.equalTo(25)
            make.width.equalTo(300)
            make.height.equalTo(250)
        }
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("counterViewTap")))
    }
    func counterViewTap(){
        if isGraphViewShowing {
            UIView.transitionFromView(graphView, toView: counterView, duration: 1.0, options: [UIViewAnimationOptions.TransitionFlipFromLeft,UIViewAnimationOptions.ShowHideTransitionViews], completion: nil)
        } else {
            UIView.transitionFromView(counterView, toView: graphView, duration: 1.0, options: [UIViewAnimationOptions.TransitionFlipFromRight, UIViewAnimationOptions.ShowHideTransitionViews], completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    

}
