//
//  HomeViewController.swift
//  CoreGraphics
//
//  Created by 胡琰士 on 16/11/24.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private let  dataArr:[String] = ["Flo"]
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
        return dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row]
        cell.textLabel?.font = UIFont.systemFontOfSize(16)
        cell.textLabel?.textColor = UIColor.blackColor()
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(FloViewController(), animated: true)
        default:
            break
        }
    }
}
