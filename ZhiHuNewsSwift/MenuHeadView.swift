//
//  MenuHeadView.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/13.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit
import RxSwift

protocol MenuHeadViewDelegate: class {
    func clicked(index: Int)
}

class MenuHeadView: UIView {

    
    weak var delegate: MenuHeadViewDelegate?
    var dispose = DisposeBag()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.rgba(r: 34, g: 42, b: 48, a: 1)
        
        let btn = UIButton.init(type: .custom)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
        btn.setImage(UIImage.init(named: "Menu_Avatar"), for: .normal)
        btn.setTitle("请登录", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(35)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        
        for index in 0...2 {
            
            let customBtn = CustomButton.init()
            customBtn.setImage(UIImage.init(named: ["collect","msg","setting"][index]), for: .normal)
            customBtn.setTitle(["收藏","消息","设置"][index], for: .normal)
            customBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            customBtn.setTitleColor(UIColor.lightGray, for: .normal)
            addSubview(customBtn)
            customBtn.snp.makeConstraints({ (make) in
                make.left.equalTo(CGFloat(index)*screenW*0.7/3)
                make.bottom.equalTo(-10)
                make.width.equalTo(screenW*0.7/3)
                make.height.equalTo(40)
            })
            customBtn.rx.tap.subscribe({ (sender) in
                
                self.delegate?.clicked(index: index)
                
            }).addDisposableTo(dispose)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class CustomButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        let midX = self.frame.size.width/2
        let midY = self.frame.size.height/2
        self.titleLabel?.center = CGPoint.init(x: midX, y: midY+15)
        self.imageView?.center = CGPoint.init(x: midX, y: midY-10)
        
        
    }
}
