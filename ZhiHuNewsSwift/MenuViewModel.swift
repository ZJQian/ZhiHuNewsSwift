//
//  MenuViewModel.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/13.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper
import HandyJSON

class MenuViewModel {
    
    private let provider = RxMoyaProvider<APIManager>()
    var dispose = DisposeBag()
    
    func getThemes(completed: @escaping (_ menuModel: MenuModel) -> ()){
        
         provider
            .request(.getThemes)
            .mapModel(MenuModel.self)
            .subscribe(onNext: { (model) in
                
                completed(model)
            }, onError: { (error) in
                
            }, onCompleted: nil, onDisposed: nil).addDisposableTo(dispose)
        
    }

}


struct MenuModel: HandyJSON {
    var others: [ThemeModel]?

}

struct ThemeModel: HandyJSON {
    
    var color: String?
    var thumbnail: String?
    var id: Int?
    var description: String?
    var name: String?
}
