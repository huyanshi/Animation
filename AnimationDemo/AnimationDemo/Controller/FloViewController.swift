//
//  FloViewController.swift
//  AnimationDemo
//
//  Created by 胡琰士 on 16/11/24.
//  Copyright © 2016年 Gavin. All rights reserved.
//
/// https://www.raywenderlich.com/90693/modern-core-graphics-with-swift-part-2

import UIKit

class FloViewController: BaseViewController {
    
    var counterView:CounterView!
    var coutainerView:CoutainerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = BackgroundView()
        let subtractBtn = PushButtonView(isAddButton: false)
        subtractBtn.isAddButton = false
        subtractBtn.addTarget(self, action: "btnPushButton:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(subtractBtn)
        subtractBtn.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(0)
            make.bottom.equalTo(-30)
            make.width.height.equalTo(60)
        }

        let plusButton = PushButtonView(isAddButton: true)
        plusButton.addTarget(self, action: "btnPushButton:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(plusButton)
        plusButton.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(0)
            make.width.height.equalTo(100)
            make.bottom.equalTo(subtractBtn.snp_top).offset(-40)
        }
        coutainerView = CoutainerView()
        view.addSubview(coutainerView)
        coutainerView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(0)
            make.width.equalTo(300)
            make.height.equalTo(250)
            make.top.equalTo(100)
            
        }
        coutainerView.counterViewTap()
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnPushButton(button:PushButtonView) {
        if button.isAddButton {
            coutainerView.counter++
        }else {
            coutainerView.counter--
        }
        if coutainerView.isGraphViewShowing {
            coutainerView.counterViewTap()
        }
    }

}
