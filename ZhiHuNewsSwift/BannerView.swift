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
let PAGE_TAG = 6666


class BannerView: UIView {

    var timer = Timer()
    var offY = Variable(0.0)
    var dispose = DisposeBag()
    
    var topStories = [StoryModel]() {
    
        didSet {
        
            let collect = viewWithTag(COLL_TAG) as! UICollectionView
            collect.reloadData()
            
            let page = viewWithTag(PAGE_TAG) as! UIPageControl
            page.numberOfPages = topStories.count
            
            addTimer()
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
        
        
        let pageControl = UIPageControl.init(frame: CGRect.init(x: 0, y: frame.size.height-25, width: screenW, height: 20))
        pageControl.tag = PAGE_TAG
        addSubview(pageControl)
        pageControl.rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: { () in
            
               collection.contentOffset.x = screenW * CGFloat(pageControl.currentPage)
                
                
        }).addDisposableTo(dispose)
        
        
        
        
        offY.asObservable().subscribe(onNext: { (offsetY) in
            
            let collect = self.viewWithTag(COLL_TAG) as! UICollectionView
            collect.visibleCells.forEach({ (cell) in
                let cell = cell as! BannerViewCell
                cell.img.frame.origin.y = CGFloat.init(offsetY)
                cell.img.frame.size.height = 220 - CGFloat.init(offsetY)
            })
            
        }).addDisposableTo(dispose)
        
    }
    
    func addTimer() {
        
        timer = Timer.init(timeInterval: 3.0, target: self, selector: #selector(scrollImage), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .commonModes)
    }
    func removeTimer() {
        timer.invalidate()
        timer.fire()
    }
    func scrollImage() {
        
        let collect = viewWithTag(COLL_TAG) as! UICollectionView
        //设置当前 indePath
        let currrentIndexPath = collect.indexPathsForVisibleItems.first! as IndexPath
        let currentIndexPathReset = IndexPath.init(item: currrentIndexPath.item, section: 50)
        collect.scrollToItem(at: currentIndexPathReset, at: .left, animated: true)
        // 设置下一个滚动的item
        var nextItem = currentIndexPathReset.item + 1
        var nextSection = currentIndexPathReset.section
        if nextItem == topStories.count {
        
            // 当item等于轮播图的总个数的时候
            // item等于0, 分区加1
            // 未达到的时候永远在50分区中
            nextItem = 0
            nextSection += 1
        }
        
        let nextIndexPath = IndexPath.init(item: nextItem, section: nextSection)
        collect.scrollToItem(at: nextIndexPath, at: .left, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension BannerView: UICollectionViewDelegate,UICollectionViewDataSource {

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 100
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topStories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BannerViewCell
        
        cell.model(model: topStories[indexPath.item])
        return cell
    }
}

extension BannerView: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 滚动时 动态设置 pageControl.currentPage
        let page = viewWithTag(PAGE_TAG) as! UIPageControl
        page.currentPage = (Int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5) % topStories.count
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}


class BannerViewCell: UICollectionViewCell {
    
    
    var img = UIImageView()
    var titleLabel = UILabel()
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        img = UIImageView.init()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        contentView.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(contentView)
        }
        
        titleLabel = UILabel.init()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(-30)
        }
        
        
        
    }
    func model(model: StoryModel) {
        img.kf.setImage(with: URL.init(string: model.image!))
        titleLabel.text = model.title
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

