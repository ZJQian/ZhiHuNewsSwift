
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

class HomeViewModel {
    
    private let provider = RxMoyaProvider<APIManager>()
    
    func getNewsList() -> Observable<ListModel> {
        
        return provider
            .request(.getNewsLatest)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapObject(type: ListModel.self)
        
    }
}
