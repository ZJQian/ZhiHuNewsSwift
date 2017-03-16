//
//  ThemeViewController.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/9.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit
import RxSwift

class ThemeViewController: UIViewController {

    var titleLabel = UILabel()
    var dispose = DisposeBag()
    var menuVC = MenuViewController()
    var themeStories = [ThemeStoryModel]()
    var themeEditors = [EditorModel]()
    var themeViewModel = ThemeViewModel()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        stutasUI()
        view.addSubview(tableView)
        setNavBarUI()
        
        //通知
        NotificationCenter.default
            .rx
            .notification(Notification.Name.init(rawValue: "setTheme"))
            .subscribe(onNext: { (noti) in
            
                let model = noti.userInfo?["model"] as! ThemeModel
                print(model.thumbnail!)
                self.headView.img.kf.setImage(with: URL.init(string: model.thumbnail!))
                self.titleLabel.text = model.name
                self.menuVC.showView = false//这里设置的原因是,每次点击完之后,让侧边栏隐藏,然后点击返回的时候取反
                self.loadData(id: model.id!)
                
        }).addDisposableTo(dispose)
        
        
        //手势事件
        let tap = UITapGestureRecognizer.init()
        tap.delegate = self
        view.addGestureRecognizer(tap)
        tap.rx
            .event
            .subscribe(onNext: { (sender) in
            
                if self.menuVC.showView == true {
                self.menuVC.showView = !self.menuVC.showView
                }
        }).addDisposableTo(dispose)
        
       
        
    }

    func loadData(id: Int) {
        
        themeViewModel.getThemeDetail(id: id) { (model) in
            self.themeStories = model.stories!
            self.themeEditors = model.editors!
            self.tableView.reloadData()
        }
        
    }
    // MARK:- set UI
    private func stutasUI() {
        
        let sta = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 1))
        view.addSubview(sta)
        
    }
    private func setNavBarUI () {
        
        titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 20, width: screenW, height: 40))
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(titleLabel)
        
        self.menuVC.view.frame = CGRect.init(x: -screenW*0.7, y: 0, width: screenW*0.7, height: screenH)
        
        
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 0, y: 25, width: 50, height: 30)
        btn.setImage(UIImage.init(named: "nav_back"), for: .normal)
        view.addSubview(btn)
        btn.rx
            .tap
            .subscribe(onNext: { (sender) in
                
                self.menuVC.showView = !self.menuVC.showView
            }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(dispose)
    }

    //MARK:- lazy load
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: self.view.frame, style: .plain)
        table.separatorStyle = .none
        table.backgroundColor = UIColor.clear
        table.delegate = self
        table.dataSource = self
        return table
    }()

    lazy var headView: HeadView = {
        let head = HeadView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 60))
        return head
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - UIGestureRecognizerDelegate
extension ThemeViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if menuVC.showView == true {
            
            if (touch.view?.isKind(of: UITableView.self))! {
                return false
            }
            return true
        }
        return false
    }
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension ThemeViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themeStories.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            
            let editorCellID = "allEditorCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: editorCellID) as? AllEditorCell
            if cell == nil {
                cell = AllEditorCell.init(style: .default, reuseIdentifier: editorCellID)
            }
            cell?.editors = themeEditors
            return cell!
            
        } else {
            let model = themeStories[indexPath.row - 1] as ThemeStoryModel
            
            if model.images != nil {
                
                let themeCellID = "themeImageCell"
                var cell = tableView.dequeueReusableCell(withIdentifier: themeCellID) as? ThemeWithImageCell
                if cell == nil {
                    cell = ThemeWithImageCell.init(style: .default, reuseIdentifier: themeCellID)
                }
                cell?.model = model
                return cell!
            }else{
                
                let themeCellID = "themeCell"
                var cell = tableView.dequeueReusableCell(withIdentifier: themeCellID) as? ThemeCell
                if cell == nil {
                    cell = ThemeCell.init(style: .default, reuseIdentifier: themeCellID)
                }
                cell?.model = model
                return cell!
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 35 : 90
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 60))
        
        view.addSubview(headView)
        
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let editor = EditorViewController.init()
            editor.editors = themeEditors
            navigationController?.pushViewController(editor, animated: true)
            
        } else {
            var idArr = [Int]()
            themeStories.forEach { (model) in
                idArr.append(model.id!)
            }
            let detail = DetailViewController()
            detail.idArr = idArr
            detail.id = idArr[indexPath.row-1]
            navigationController?.pushViewController(detail, animated: true)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension ThemeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        
        if offsetY < 0 {
            
            headView.offY.value = Double(offsetY)
            
        }
        
    }
}




// MARK: - 自定义view
class HeadView: UIView {
    
    var offY = Variable(0.0)
    var dispose = DisposeBag()
    var img = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        img = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 60))
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        addSubview(img)
        
        offY.asObservable().subscribe(onNext: { (offsetY) in
            
            self.img.frame.origin.y = CGFloat.init(offsetY)
            self.img.frame.size.height = 60 - CGFloat.init(offsetY)
            
        }).addDisposableTo(dispose)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

