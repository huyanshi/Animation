//
//  HomeViewController.swift
//  CoreGraphics
//
//  Created by 胡琰士 on 16/11/24.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    fileprivate let  dataArr:[String] = ["Flo"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Animation"
        view.addSubview(tableView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate lazy var tableView:UITableView = {
       let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: SCREENH), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.tableFooterView = UIView()
        return tableView
    }()

    
}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textColor = UIColor.black
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(FloViewController(), animated: true)
        default:
            break
        }
    }
}
