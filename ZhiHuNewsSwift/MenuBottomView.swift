//
//  MenuBottomView.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/13.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit
import RxSwift

class MenuBottomView: UIView {

    var dispose = DisposeBag()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        for index in 0...1 {
            let btn = UIButton.init(type: .custom)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.setTitleColor(UIColor.lightGray, for: .normal)
            btn.setTitle(["完成","夜间"][index], for: .normal)
            btn.setImage(UIImage.init(named: ["download","moon"][index]), for: .normal)
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
            addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.left.equalTo(CGFloat(index)*screenW*0.7/2)
                make.width.equalTo(screenW*0.7/2)
                make.height.equalTo(60)
                make.bottom.equalTo(self)
            })
            btn.rx
                .tap
                .subscribe({ (sender) in
                
                    if index == 1 {
                    
                        print("夜间")
                    }
                    
            }).addDisposableTo(dispose)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
