//
//  ThemeCell.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/14.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {

    var titleLabel = UILabel()
    var model = ThemeStoryModel() {
    
        didSet {
        
            titleLabel.text = model.title
        
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        titleLabel = UILabel.init()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.right.equalTo(-15)
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(UIColor.clear.cgColor)
        context?.fill(rect)
        
        //上分割线，
        context?.setStrokeColor(UIColor.rgba(r: 225, g: 225, b: 225, a: 1).cgColor)
        context?.stroke(CGRect.init(x: 0, y: 0, width: 0, height: 0))
        
        //下分割线
        context?.setStrokeColor(UIColor.rgba(r: 225, g: 225, b: 225, a: 1).cgColor)
        context?.stroke(CGRect.init(x: 15, y: rect.size.height, width: rect.size.width-30, height: 0.5))
        
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
