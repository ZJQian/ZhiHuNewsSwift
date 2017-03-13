//
//  StoryModel.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/9.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import Foundation
import ObjectMapper

class ListModel: Mappable {
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    
    var date: String?
    var stories: [StoryModel]?
    var top_stories: [StoryModel]?
    
    required init?(map: Map) {
    
    }

    public func mapping(map: Map) {
        date <- map["date"]
        stories <- map["stories"]
        top_stories <- map["top_stories"]
    }

}

class StoryModel: Mappable {
    var ga_prefix: String?
    var id: Int?
    var images: [String]?
    var title: String?
    var type: Int?
    var image: String?
    var multipic = false
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        ga_prefix <- map["ga_prefix"]
        id <- map["id"]
        images <- map["images"]
        title <- map["title"]
        type <- map["type"]
        image <- map["image"]
        multipic <- map["multipic"]

    }
}
