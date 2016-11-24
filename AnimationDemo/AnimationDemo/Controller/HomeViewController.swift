//
//  HomeViewController.swift
//  CoreGraphics
//
//  Created by 胡琰士 on 16/11/24.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit
/// 屏幕宽度
let SCREENW = UIScreen.mainScreen().bounds.size.width
/// 屏幕高度
let SCREENH = UIScreen.mainScreen().bounds.size.height
/// 屏幕三围
let SCREENBOUNDS = UIScreen.mainScreen().bounds

class HomeViewController: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Animation"
        view.addSubview(tableView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private lazy var tableView:UITableView = {
       let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: SCREENH), style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.tableFooterView = UIView()
        return tableView
    }()

    
}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        cell.textLabel?.text = "这是第\(indexPath.row)行"
        cell.textLabel?.font = UIFont.systemFontOfSize(16)
        cell.textLabel?.textColor = UIColor.blackColor()
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
