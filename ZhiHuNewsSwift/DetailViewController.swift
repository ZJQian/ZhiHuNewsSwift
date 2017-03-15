//
//  DetailViewController.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/10.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import Kingfisher
class DetailViewController: UIViewController {

    var previousWeb = DetailWebView()
    let detailViewModel = DetailViewModel()
    var dispose = DisposeBag()
    var idArr = [Int]()
    var statusView = UIView()
    var nextID = Int()
    var previousID = Int()
    var id = Int() {
        didSet {
            loadData()
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

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        stutasUI()
        view.addSubview(detailWebView)
        view.addSubview(bottomView)
        previousWeb = DetailWebView.init(frame: CGRect.init(x: 0, y: -screenH, width: screenW, height: screenH-40))
        view.addSubview(previousWeb)
        setUI()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    //MARK:- request
    func loadData() {
    
        detailViewModel.getNewsDetail(id: id)
            .asObservable()
            .subscribe(onNext: { (model) in
            
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
            
        }, onCompleted: nil, onDisposed: nil).addDisposableTo(dispose)
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
    private func stutasUI() {
        
        statusView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 20))
        statusView.backgroundColor = UIColor.white
        view.addSubview(statusView)
        statusView.isHidden = true
        
    }

    //MARK:- lazy load
    lazy var bottomView: DetailBottomView = {
        let bottom = DetailBottomView.init(frame: CGRect.init(x: 0, y: screenH - 40, width: screenW, height: 40))
        bottom.delegate = self
        return bottom
    }()
    lazy var detailWebView: DetailWebView = {
        let web = DetailWebView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenH-40))
        web.delegate = self
        web.scrollView.delegate = self
        return web
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailViewController: DetailBottomViewDelegate {

    func bottomViewClick(with index: Int) {
        
        switch index {
        case 0:
            navigationController!.popViewController(animated: true)
        default: break
            
        }
    }
}


extension DetailViewController: UIWebViewDelegate {

    func webViewDidFinishLoad(_ webView: UIWebView) {
        detailWebView.waitView.removeFromSuperview()
        detailWebView.nextLab.frame = CGRect.init(x: 15, y: self.detailWebView.scrollView.contentSize.height + 10, width: screenW - 30, height: 20)
    }
}


extension DetailViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if detailWebView.scrollView.contentOffset.y > 200 {
        
            view.bringSubview(toFront: statusView)
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

extension DetailViewController {

    func changeWebview(_ showID: Int) {
        detailWebView.removeFromSuperview()
        previousWeb.scrollView.delegate = self
        previousWeb.delegate = self
        detailWebView = previousWeb
        id = showID
        setUI()
        previousWeb = DetailWebView.init(frame: CGRect.init(x: 0, y: -screenH, width: screenW, height: screenH-40))
        view.addSubview(previousWeb)
        scrollViewDidScroll(detailWebView.scrollView)
    }

}
