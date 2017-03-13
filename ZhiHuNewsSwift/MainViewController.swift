//
//  MainViewController.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/9.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit

import Moya
import RxSwift

class MainViewController: UITabBarController {

    var provider = RxMoyaProvider<APIManager>()
    var dispose = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let home = HomeViewController.init()
        home.view.backgroundColor = UIColor.white
        let nav = UINavigationController.init(rootViewController: home)
        nav.navigationBar.isHidden = true
       
        
        
        
        let theme = ThemeViewController.init()
        theme.view.backgroundColor = UIColor.white
        let nav2 = UINavigationController.init(rootViewController: theme)
        
        viewControllers = [nav,nav2]
        
        
        tabBar.isHidden = true
        
        
        
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
