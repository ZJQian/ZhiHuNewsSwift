//
//  MenuViewController.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/10.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit
import RxSwift


class MenuViewController: UIViewController {

    var menuViewModel = MenuViewModel()
    var dispose = DisposeBag()
    var themes = [ThemeModel]()
    var bindtoNav: UITabBarController?
    
    
    var showView = false {
        didSet {
            showView ? showMenu() : dismissMenu()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.rgba(r: 34, g: 42, b: 48, a: 1)
        view.addSubview(menuHeadView)
        view.addSubview(tableView)
        view.addSubview(menuBottomView)
        loadData()
    }
    
    func loadData() {
        menuViewModel.getThemes { (model) in
            self.themes = model.others!
            var m = ThemeModel()
            m.name = "首页"
            self.themes.insert(m, at: 0)
            self.tableView.reloadData()
        }
    }

    
    //MARK:- lazy load
    lazy var menuHeadView: MenuHeadView = {
        let head = MenuHeadView.init(frame: CGRect.init(x: 0, y: 0, width: screenW*0.7, height: 130))
        return head
    }()
    lazy var menuBottomView: MenuBottomView = {
        let bottom = MenuBottomView.init(frame: CGRect.init(x: 0, y: screenH-60, width: screenW*0.7, height: 60))
        return bottom
    }()
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect.init(x: 0, y: self.menuHeadView.bottom, width: screenW*0.7, height: screenH-self.menuHeadView.bottom-60), style: .plain)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.backgroundColor = UIColor.clear
        return table
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MenuViewController {


    func showMenu() {
        let view = UIApplication.shared.keyWindow?.subviews.first
        let menuView = UIApplication.shared.keyWindow?.subviews.last
        UIApplication.shared.keyWindow?.bringSubview(toFront: (UIApplication.shared.keyWindow?.subviews[1])!)
        UIView.animate(withDuration: 0.5, animations: {
            view?.transform = CGAffineTransform.init(translationX: screenW*0.7, y: 0)
            menuView?.transform = (view?.transform)!
        })
    }
    
    func dismissMenu() {
        let view = UIApplication.shared.keyWindow?.subviews.first
        let menuView = UIApplication.shared.keyWindow?.subviews.last
        UIApplication.shared.keyWindow?.bringSubview(toFront: (UIApplication.shared.keyWindow?.subviews[1])!)
        UIView.animate(withDuration: 0.5, animations: {
            view?.transform = CGAffineTransform.init(translationX: 0, y: 0)
            menuView?.transform = (view?.transform)!
        })
    }

}
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menuCellID = "menuCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: menuCellID)
        if cell == nil {
            cell = HomeCell.init(style: .default, reuseIdentifier: menuCellID)
        }
        cell?.backgroundColor = UIColor.rgba(r: 34, g: 42, b: 48, a: 1)
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
        cell?.textLabel?.textColor = UIColor.lightGray
        let model = themes[indexPath.row] as ThemeModel
        cell?.textLabel?.text = model.name
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.showView = false
        showThemeVC(themes[indexPath.row])
    }
}

extension MenuViewController {
       
    fileprivate func showThemeVC(_ model: ThemeModel) {
        if model.id == nil {
            bindtoNav?.selectedIndex = 0
        } else {
            bindtoNav?.selectedIndex = 1
            
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "setTheme"), object: nil, userInfo: ["model": model])
        }
    }

}
