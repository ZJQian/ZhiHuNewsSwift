//
//  EditorViewController.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/14.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class EditorViewController: UIViewController {

    var navView = UIView()
    var dispose = DisposeBag()
    var editors = [EditorModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        stutasUI()
        setNavBarUI()
        view.addSubview(tableView)
        
    }

    // MARK:- set UI
    private func stutasUI() {
        
        let sta = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 1))
        view.addSubview(sta)
        
    }
    private func setNavBarUI () {
        
        navView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 60))
        navView.backgroundColor = UIColor.rgba(r: 73, g: 165, b: 246, a: 1)
        view.addSubview(navView)
        
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 20, width: screenW, height: 40))
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.text = "主编"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(titleLabel)
        
        
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 0, y: 25, width: 50, height: 30)
        btn.setImage(UIImage.init(named: "nav_back"), for: .normal)
        view.addSubview(btn)
        btn.rx
            .tap
            .subscribe(onNext: { (sender) in
                
                self.navigationController!.popViewController(animated: true)
            }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(dispose)
    }

    //MARK:- lazy load
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect.init(x: 0, y: 60, width: screenW, height: screenH-60), style: .plain)
        table.delegate = self
        table.dataSource = self
        table.separatorInset = UIEdgeInsets.zero
        table.rowHeight = 60
        table.tableFooterView = UIView.init(frame: CGRect.zero)
        return table
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension EditorViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editors.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let editorCellID = "editorCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: editorCellID) as? EditorCell
        if cell == nil {
            cell = EditorCell.init(style: .default, reuseIdentifier: editorCellID)
        }
        cell?.model = editors[indexPath.row]
        
        return cell!
    }
}

