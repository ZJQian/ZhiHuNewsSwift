//
//  DetailViewController.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/10.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

    var previousWeb = DetailWebView()
    var detailViewModel: DetailViewModel?
    var idArr = [Int]()
    var statusView = UIView()
    var nextID = Int()
    var previousID = Int()
    var id = Int() 
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        stutasUI()
        view.addSubview(detailWebView)
        view.addSubview(bottomView)
        previousWeb = DetailWebView.init(frame: CGRect.init(x: 0, y: -screenH, width: screenW, height: screenH-40))
        view.addSubview(previousWeb)
        
        
        detailViewModel = DetailViewModel.init(id: id)
        detailWebView.delegate = detailViewModel
        detailWebView.scrollView.delegate = detailViewModel
        detailViewModel?.detailWebView = detailWebView
        detailViewModel?.previousWeb = previousWeb
        detailViewModel?.statusView = statusView
        detailViewModel?.controllerView = view
        detailViewModel?.nextID = nextID
        detailViewModel?.previousID = previousID
        detailViewModel?.idArr = idArr
        detailViewModel?.id = id
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
            
    
    private func stutasUI() {
        
        statusView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 20))
        statusView.backgroundColor = UIColor.white
        view.addSubview(statusView)
        statusView.isHidden = true
        
    }

    //MARK:- lazy load
    lazy var bottomView: DetailBottomView = {
        let bottom = DetailBottomView.init(frame: CGRect.init(x: 0, y: screenH - 40, width: screenW, height: 40))
        bottom.delegate = self
        return bottom
    }()
    lazy var detailWebView: DetailWebView = {
        let web = DetailWebView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenH-40))
        return web
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - DetailBottomViewDelegate
extension DetailViewController: DetailBottomViewDelegate {

    func bottomViewClick(with index: Int) {
        
        switch index {
        case 0:
            navigationController!.popViewController(animated: true)
        default: break
            
        }
    }
}


