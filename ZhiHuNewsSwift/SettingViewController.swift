//
//  SettingViewController.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/15.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit

import RxSwift

class SettingViewController: BaseViewController {

    var menuVC = MenuViewController()
    var dispose = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = "设置"
        view.backgroundColor = UIColor.rgba(r: 240, g: 240, b: 240, a: 1)
        
        menuVC.view.frame = CGRect.init(x: -screenW*0.7, y: 0, width: screenW*0.7, height: screenH)
        
        NotificationCenter.default
            .rx
            .notification(Notification.Name.init(rawValue: "setting"))
            .subscribe(onNext: { (noti) in
            
            self.menuVC.showView = false
        }).addDisposableTo(dispose)
        
        view.addSubview(tableView)
    }

    // MARK: - override
    override func leftDismiss() {
        
        menuVC.showView = !menuVC.showView
    }
    
    // MARK: - lazy load
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect.init(x: 0, y: self.titleLabel.bottom, width: screenW, height: screenH-self.titleLabel.bottom), style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor.clear
        return table
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension SettingViewController: UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 || section == 4 {
            return 2
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let settingCellID = "settingCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: settingCellID)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: settingCellID)
        }
        
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        if indexPath.section == 0 {
            
            cell?.textLabel?.text = "我的资料"
            
        } else {
            
            cell?.textLabel?.text = [["自动离线下载"],["移动网络不下载图片","大字号"],["消息推送"],["去好评","去吐槽"],["清除缓存"]][indexPath.section-1][indexPath.row]
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

}

