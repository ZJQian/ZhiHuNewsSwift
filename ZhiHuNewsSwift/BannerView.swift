//
//  BannerView.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/9.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDCycleScrollView

class BannerView: UIView {

    var cycleView = SDCycleScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cycleView = SDCycleScrollView.init(frame: frame, delegate: self, placeholderImage: UIImage.init(named: ""))
        cycleView.autoScrollTimeInterval = 2
        cycleView.titleLabelHeight = 40
        cycleView.titleLabelTextFont = UIFont.systemFont(ofSize: 21)
        cycleView.titleLabelBackgroundColor = UIColor.clear
        addSubview(cycleView)
        
    }
    
    func images(array: [StoryModel]) {
        
        var imageArr = [String]()
        var titleArr = [String]()
        
        array.forEach { (model) in
            imageArr.append(model.image!)
            titleArr.append(model.title!)
        }
        cycleView.imageURLStringsGroup = imageArr
        cycleView.titlesGroup = titleArr
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension BannerView: SDCycleScrollViewDelegate {

    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
    }
}
