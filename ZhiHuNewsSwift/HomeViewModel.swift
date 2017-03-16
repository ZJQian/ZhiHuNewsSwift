
//
//  HomeViewModel.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/9.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import Foundation
import Moya
import RxSwift


protocol HomeViewModelDelegate: class {
    func didSelectRow(viewController: DetailViewController)
}

class HomeViewModel: NSObject {
    
    private let provider = RxMoyaProvider<APIManager>()
    let dispose = DisposeBag()
    
    var tableView = UITableView()
    var bannerView = BannerView()
    var navView = UIView()
    
    
    var dataArray = [StoryModel]()
    
    weak var delegate: HomeViewModelDelegate?
        
    func getNewsList() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
         provider
            .request(.getNewsLatest)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapObject(type: ListModel.self).subscribe(onNext: { (model) in
                
                self.dataArray = model.stories!
                self.tableView.reloadData()
                self.bannerView.topStories = model.top_stories!
                
                
            }, onError: { (error) in
                
            }).addDisposableTo(dispose)
        
    }

}

extension HomeViewModel: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCellID = "homeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: homeCellID) as? HomeCell
        if cell == nil {
            cell = HomeCell.init(style: .default, reuseIdentifier: homeCellID)
        }
        cell?.model(model: dataArray[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var idArr = [Int]()
        dataArray.forEach { (model) in
            idArr.append(model.id!)
        }
        let detail = DetailViewController()
        detail.idArr = idArr
        detail.id = idArr[indexPath.row]
        delegate?.didSelectRow(viewController: detail)
    }
}
// MARK: - UIScrollViewDelegate
extension HomeViewModel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navView.backgroundColor = UIColor.rgba(r: 48, g: 142, b: 205, a: 1)
        navView.alpha = scrollView.contentOffset.y / 200
        
        bannerView.offY.value = Double(scrollView.contentOffset.y)
    }
}

