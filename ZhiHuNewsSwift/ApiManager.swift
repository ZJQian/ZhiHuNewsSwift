//
//  ApiManager.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/9.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import Foundation

import Moya

enum APIManager {
    case getNewsLatest//获取最新消息
    case getStartImage// 启动界面图像获取
    case getVersion(String)//软件版本查询
    case getThemes//主题日报列表查看
    case getNewsDetail(Int)//获取新闻详情
}

extension APIManager: TargetType {

    /// The target's base `URL`.
    var baseURL: URL {
    
        return URL.init(string: "http://news-at.zhihu.com/api/")!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
    
        switch self {
        
        case .getNewsLatest:
            return "4/news/latest"
        
        case .getStartImage://start-image 后为图像分辨率，接受任意的 number*number 格式， number 为任意非负整数，返回值均相同。
            return "4/start-image/1080*1776"
        
        case .getVersion(let version)://URL 最后部分的数字代表所安装『知乎日报』的版本
            return "4/version/ios/" + version
            
        case .getThemes:
            return "4/themes"
        
        case .getNewsDetail(let id):
            return "4/news/\(id)"
            
        }
        
        
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
    
        return .get
    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
    
        return nil
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
    
        return URLEncoding.default
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
    
        return "".data(using: String.Encoding.utf8)!
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
    
        return .request
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
    
        return false
    }

}
