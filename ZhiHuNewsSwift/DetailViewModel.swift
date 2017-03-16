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

class DetailViewModel: NSObject {
    
    var dispose = DisposeBag()
    
    var detailWebView = DetailWebView()
    var previousWeb = DetailWebView()
    var statusView = UIView()
    var controllerView = UIView()
    var nextID = Int()
    var previousID = Int()
    var idArr = [Int]()
    var id = Int() {
        didSet {
            
            for (index, element) in idArr.enumerated() {
                if id == element {
                    if index == 0 {
                        //最新一条
                        previousID = 0
                        nextID = idArr[index + 1]
                    }
                    else if (index == idArr.count - 1) {
                        //最后一条
                        nextID = -1
                        previousID = idArr[index - 1]
                    }
                    else {
                        previousID = idArr[index - 1]
                        nextID = idArr[index + 1]
                    }
                    break;
                }
            }
        }
    }

    
    
    
    init(id: Int) {
        super.init()
       
        setUI()
        getNewsDetail(id: id)
    }
    
    private let provider = RxMoyaProvider<APIManager>()
    
    fileprivate func getNewsDetail(id: Int) {
        
         provider
            .request(.getNewsDetail(id))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapObject(type: DetailModel.self).subscribe(onNext: { (model) in
                
                
                if let image = model.image {
                    
                    self.detailWebView.img.kf.setImage(with: URL.init(string: image))
                    self.detailWebView.titleLab.text = model.title
                }else {
                    
                    self.detailWebView.img.isHidden = true
                    self.detailWebView.previousLab.textColor = UIColor.colorFromHex(hex: 0x777777)
                }
                if let image_source = model.image_source {
                    self.detailWebView.imgLab.text = "图片: " + image_source
                }
                if (model.title.characters.count) > 16 {
                    self.detailWebView.titleLab.frame = CGRect.init(x: 15, y: 120, width: screenW - 30, height: 55)
                }
                OperationQueue.main.addOperation {
                    self.detailWebView.loadHTMLString(self.loadHTMLFile(css: model.css, body: model.body), baseURL: nil)
                }

                
            }, onError: { (error) in
                
            }, onCompleted: { 
                
            }, onDisposed: nil).addDisposableTo(dispose)
        
    }
    
    //MARK:- private
    /**加载html文件*/
    private func loadHTMLFile(css: [String], body: String) -> String {
        var html = "<html>"
        html += "<head>"
        css.forEach { html += "<link rel=\"stylesheet\" href=\($0)>" }
        html += "<style>img{max-width:320px !important;}</style>"
        html += "</head>"
        html += "<body>"
        html += body
        html += "</body>"
        html += "</html>"
        return html
    }

    fileprivate func setUI() {
        
        if previousID == 0 {
            detailWebView.previousLab.text = "已经是第一篇了"
        } else {
            detailWebView.previousLab.text = "载入上一篇"
        }
        if nextID == -1 {
            detailWebView.nextLab.text = "已经是最后一篇了"
        } else {
            detailWebView.nextLab.text = "载入下一篇"
        }
    }

}



// MARK: - UIWebViewDelegate
extension DetailViewModel: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        detailWebView.waitView.removeFromSuperview()
        detailWebView.nextLab.frame = CGRect.init(x: 15, y: self.detailWebView.scrollView.contentSize.height + 10, width: screenW - 30, height: 20)
    }
}


// MARK: - UIScrollViewDelegate
extension DetailViewModel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if detailWebView.scrollView.contentOffset.y > 200 {
            
            controllerView.bringSubview(toFront: statusView)
            UIApplication.shared.statusBarStyle = .default
            statusView.isHidden = false
        }else {
            
            UIApplication.shared.statusBarStyle = .lightContent
            statusView.isHidden = true
        }
        detailWebView.img.frame.size.height = max(200 - (scrollView.contentOffset.y), 200)
        detailWebView.img.frame.origin.y = min(scrollView.contentOffset.y, 0)
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //载入上一篇
        if scrollView.contentOffset.y <= -100 {
            if previousID > 0 {
                previousWeb.frame = CGRect.init(x: 0, y: -screenH, width: screenW, height: screenH-40)
                UIView.animate(withDuration: 0.3, animations: {
                    self.detailWebView.transform = CGAffineTransform.init(translationX: 0, y: screenH)
                    self.previousWeb.transform = CGAffineTransform.init(translationX: 0, y: screenH)
                }, completion: { (state) in
                    if state { self.changeWebview(self.previousID) }
                })
            }
        }
        //载入下一篇
        if scrollView.contentOffset.y - 100 + screenH >= scrollView.contentSize.height {
            if nextID > 0 {
                previousWeb.frame = CGRect.init(x: 0, y: screenH, width: screenW, height: screenH-40)
                UIView.animate(withDuration: 0.3, animations: {
                    self.previousWeb.transform = CGAffineTransform.init(translationX: 0, y: -screenH)
                    self.detailWebView.transform = CGAffineTransform.init(translationX: 0, y: -screenH)
                }, completion: { (state) in
                    if state { self.changeWebview(self.nextID) }
                })
            }
        }
    }
    
}


// MARK: - Description
extension DetailViewModel {
    
    func changeWebview(_ showID: Int) {
        detailWebView.removeFromSuperview()
        previousWeb.scrollView.delegate = self
        previousWeb.delegate = self
        detailWebView = previousWeb
        id = showID
        getNewsDetail(id: id)
        setUI()
        previousWeb = DetailWebView.init(frame: CGRect.init(x: 0, y: -screenH, width: screenW, height: screenH-40))
        controllerView.addSubview(previousWeb)
        scrollViewDidScroll(detailWebView.scrollView)
    }
    
}




//MARK: - Model
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
