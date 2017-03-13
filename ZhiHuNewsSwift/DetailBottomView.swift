//
//  DetailBottomView.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/10.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit
import RxSwift
class DetailBottomView: UIView {

    weak var delegate: DetailBottomViewDelegate?
    var dispose = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        for index in 0...4 {
            let btn = UIButton.init(type: .custom)
            btn.backgroundColor = UIColor.orange
            btn.frame = CGRect.init(x: CGFloat(index) * screenW/5, y: 0, width: screenW/5, height: frame.size.height)
            btn.setImage(UIImage.init(named: ["back","down","zan","share","comment"][index]), for: .normal)
            addSubview(btn)
            btn.rx
                .tap
                .subscribe(onNext: { (sender) in
                
                self.delegate?.bottomViewClick(with: index)
            }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(dispose)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

protocol DetailBottomViewDelegate: class {
    func bottomViewClick(with index: Int)
}
