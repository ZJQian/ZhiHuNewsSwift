//
//  ThemeViewModel.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/14.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import Foundation
import HandyJSON
import RxSwift
import Moya

class ThemeViewModel {

    private let provider = RxMoyaProvider<APIManager>()
    let dispose = DisposeBag()
    
    
    /// 获取主题详情
    ///
    /// - Parameters:
    ///   - id: id
    ///   - completed: 完成callback
    func getThemeDetail(id: Int, callback completed: @escaping (_ model: ThemeDetailModel) -> ()) {
    
        provider.request(.getThemeDetail(id)).mapModel(ThemeDetailModel.self).subscribe(onNext: { (model) in
            
            completed(model)
            
        }, onError: { (error) in
            
        }).addDisposableTo(dispose)
        
    
    }

}

struct ThemeDetailModel: HandyJSON {
    var stories: [ThemeStoryModel]?
    var description: String?
    var background: String?
    var color: Int?
    var name: String?
    var image: String?
    var editors: [EditorModel]?
    var image_source: String?
    
}


struct ThemeStoryModel: HandyJSON {
    var images: [String]?
    var type: Int?
    var id: Int?
    var title: String?
    
}
struct EditorModel: HandyJSON {
    
    var url: String?
    var bio: String?
    var id: Int?
    var avatar: String?
    var name: String?
}
