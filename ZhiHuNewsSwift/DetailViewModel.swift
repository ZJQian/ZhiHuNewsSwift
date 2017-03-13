//
//  DetailViewModel.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/10.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper

class DetailViewModel {
    
    private let provider = RxMoyaProvider<APIManager>()
    
    func getNewsDetail(id: Int) -> Observable<DetailModel> {
        
        return provider
            .request(.getNewsDetail(id))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapObject(type: DetailModel.self)
        
    }
}

class DetailModel: Mappable {
    
    var body = String()
    var image_source: String?
    var title = String()
    var image: String?
    var share_url = String()
    var js = String()
    var recommenders = [[String: String]]()
    var ga_prefix = String()
    var section: DetailSectionModel?
    var type = Int()
    var id = Int()
    var css = [String]()
    
    
    

    
    func mapping(map: Map) {
        
        body <- map["body"]
        image_source <- map["image_source"]
        title <- map["title"]
        image <- map["image"]
        share_url <- map["share_url"]
        js <- map["js"]
        recommenders <- map["recommenders"]
        ga_prefix <- map["ga_prefix"]
        section <- map["section"]
        type <- map["type"]
        id <- map["id"]
        css <- map["css"]
    }
    required init?(map: Map) {
        
    }
}

class DetailSectionModel: Mappable {
    
    var thumbnail = String()
    var id = Int()
    var name = String()
    
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        
        thumbnail <- map["thumbnail"]
        id <- map["id"]
        name <- map["name"]
    }
}
