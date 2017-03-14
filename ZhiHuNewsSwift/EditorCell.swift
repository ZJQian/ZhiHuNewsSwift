//
//  EditorCell.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/14.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit

class EditorCell: UITableViewCell {

    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(UIColor.clear.cgColor)
        context?.fill(rect)
        
        //上分割线，
        context?.setStrokeColor(UIColor.rgba(r: 225, g: 225, b: 225, a: 1).cgColor)
        context?.stroke(CGRect.init(x: 0, y: 0, width: 0, height: 0))
        
        //下分割线
        context?.setStrokeColor(UIColor.rgba(r: 225, g: 225, b: 225, a: 1).cgColor)
        context?.stroke(CGRect.init(x: 0, y: rect.size.height, width: rect.size.width, height: 0.5))

    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "主编"
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(contentView)
            make.width.equalTo(40)
            make.height.equalTo(25)
        }
        
        let img = UIImageView.init()
        img.image = UIImage.init(named: "next")
        contentView.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.left.equalTo(screenW-35)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(20)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
