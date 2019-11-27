//
//  MenuViewController.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/7/29.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit

// 菜单视图控制器
class MenuViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .clear
        self.view.backgroundColor = UIColor.clear
    }
    
    // 分区数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 单元格数量
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // 返回单元格内容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
            cell.textLabel?.text = "菜单\(indexPath.row + 1)"
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = UIColor.clear
            return cell
    }
}
