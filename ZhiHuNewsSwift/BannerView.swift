//
//  BannerView.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/9.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit
import RxSwift

let COLL_TAG = 8888



class BannerView: UIView {

    
    var offY = Variable(0.0)
    var dispose = DisposeBag()
    
    var topStories = [StoryModel]() {
    
        didSet {
        
            let collect = viewWithTag(COLL_TAG) as! UICollectionView
            collect.reloadData()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layout = UICollectionViewFlowLayout.init()
        
        
        
        let collection = UICollectionView.init(frame: frame, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.tag = COLL_TAG
        collection.isPagingEnabled = true
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.clipsToBounds = false
        
        layout.itemSize = CGSize.init(width: collection.width, height: collection.height)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .horizontal
        
        
        addSubview(collection)
        collection.register(BannerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
        offY.asObservable().subscribe(onNext: { (offsetY) in
            
            let collect = self.viewWithTag(COLL_TAG) as! UICollectionView
            collect.visibleCells.forEach({ (cell) in
                let cell = cell as! BannerViewCell
                cell.img.frame.origin.y = CGFloat.init(offsetY)
                cell.img.frame.size.height = 220 - CGFloat.init(offsetY)
            })
            
        }).addDisposableTo(dispose)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension BannerView: UICollectionViewDelegate,UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topStories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BannerViewCell
        
        cell.model(model: topStories[indexPath.item])
        
        return cell
    }

}

class BannerViewCell: UICollectionViewCell {
    
    
    var img = UIImageView()
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        img = UIImageView.init()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        contentView.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(contentView)
        }
        
    }
    func model(model: StoryModel) {
        img.kf.setImage(with: URL.init(string: model.image!))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

