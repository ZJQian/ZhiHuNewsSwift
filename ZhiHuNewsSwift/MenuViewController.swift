//
//  MenuViewController.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/10.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    
    var showView = false {
        didSet {
            showView ? showMenu() : dismissMenu()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MenuViewController {


    func showMenu() {
        let view = UIApplication.shared.keyWindow?.subviews.first
        let menuView = UIApplication.shared.keyWindow?.subviews.last
        UIApplication.shared.keyWindow?.bringSubview(toFront: (UIApplication.shared.keyWindow?.subviews[0])!)
        UIView.animate(withDuration: 0.5, animations: {
            view?.transform = CGAffineTransform.init(translationX: screenW*0.7, y: 0)
            menuView?.transform = (view?.transform)!
        })
    }
    
    func dismissMenu() {
        let view = UIApplication.shared.keyWindow?.subviews.first
        let menuView = UIApplication.shared.keyWindow?.subviews.last
        UIApplication.shared.keyWindow?.bringSubview(toFront: (UIApplication.shared.keyWindow?.subviews[0])!)
        UIView.animate(withDuration: 0.5, animations: {
            view?.transform = CGAffineTransform.init(translationX: 0, y: 0)
            menuView?.transform = (view?.transform)!
        })
    }

}
