//
//  HomeViewController.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/9.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit

import Moya
import RxSwift
import RxCocoa
import RxDataSources

class HomeViewController: UIViewController {

    var navView = UIView()
    var provider = RxMoyaProvider<APIManager>()
    var dispose = DisposeBag()
    let homeViewModel = HomeViewModel()
    var dataArray = [StoryModel]()
    var menuViewController = MenuViewController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        stutasUI()
        view.addSubview(tableView)
        tableView.tableHeaderView = bannerView
        bannerView.isUserInteractionEnabled = true
        setNavBarUI()
        loadData()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }

    func tapClick(_ sender: UITapGestureRecognizer) {
        
        if menuViewController.showView == true {
            menuViewController.showView = !menuViewController.showView
        }
    }
    
    //MARK:- request
    func loadData() {
    
        homeViewModel.getNewsList().subscribe(onNext: { (model) in
            
            self.bannerView.images(array: model.top_stories!)
            self.dataArray = model.stories!
            self.tableView.reloadData()
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil).addDisposableTo(dispose)
        
    }
    //MARK:- set UI
    private func stutasUI() {
    
        let sta = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 1))
        view.addSubview(sta)
        
    }
    private func setNavBarUI () {
        
        navView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 60))
        view.addSubview(navView)
        navView.alpha = 0
        
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 20, width: screenW, height: 40))
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "今日热闻"
        view.addSubview(label)
        
        
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 10, y: 31.5, width: 22.5, height: 17)
        btn.setImage(UIImage.init(named: "menu"), for: .normal)
        view.addSubview(btn)
        btn
            .rx
            .tap
            .subscribe(onNext: { (sender) in
            
                UIApplication.shared.keyWindow?.addSubview(self.menuViewController.view)
                self.menuViewController.bindtoNav = self.navigationController?.tabBarController
                self.menuViewController.view.frame = CGRect.init(x: -screenW*0.7, y: 0, width: screenW*0.7, height: screenH)
                self.menuViewController.showView = !self.menuViewController.showView
                
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(dispose)
    }
    
    //MARK:- lazy load
    lazy var bannerView: BannerView = {
        let banner = BannerView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 220))
        banner.backgroundColor = UIColor.white
        return banner
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenH), style: .plain)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 90
        table.separatorInset = UIEdgeInsetsMake(0, 25, 0, 20)
        return table
    }()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension HomeViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCellID = "homeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: homeCellID) as? HomeCell
        if cell == nil {
            cell = HomeCell.init(style: .default, reuseIdentifier: homeCellID)
        }
        cell?.model(model: dataArray[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var idArr = [Int]()
        dataArray.forEach { (model) in
            idArr.append(model.id!)
        }
        let detail = DetailViewController()
        detail.idArr = idArr
        detail.id = idArr[indexPath.row]
        navigationController?.pushViewController(detail, animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navView.backgroundColor = UIColor.rgba(r: 48, g: 142, b: 205, a: 1)
        navView.alpha = scrollView.contentOffset.y / 200
    }
}

// MARK: - 手势代理方法
extension HomeViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if menuViewController.showView == true {
          
            if (touch.view?.isKind(of: UITableView.self))! {
                return false
            }
            return true
        }
        return false
    }
}
