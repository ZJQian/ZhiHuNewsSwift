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

class EditorViewController: BaseViewController {

    var navView = UIView()
    var dispose = DisposeBag()
    var editors = [EditorModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = "主编"
        
        view.addSubview(tableView)
        
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

