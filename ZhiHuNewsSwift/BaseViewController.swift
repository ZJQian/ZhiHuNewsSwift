//
//  BaseViewController.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/15.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {

    
    var titleLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setNavBarUI()
    }

    
    private func setNavBarUI () {
        
        let navView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 60))
        navView.backgroundColor = UIColor.rgba(r: 73, g: 165, b: 246, a: 1)
        view.addSubview(navView)
        
        titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 20, width: screenW, height: 40))
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        navView.addSubview(titleLabel)
        
        
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 0, y: 25, width: 50, height: 30)
        btn.setImage(UIImage.init(named: "nav_back"), for: .normal)
        navView.addSubview(btn)
        btn.addTarget(self, action: #selector(leftDismiss), for: .touchUpInside)
    }

    func leftDismiss() {
        self.navigationController!.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
