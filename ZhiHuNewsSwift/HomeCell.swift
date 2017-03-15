//
//  HomeCell.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/10.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class HomeCell: UITableViewCell {

    var titleLabel = UILabel()
    var cellImageView = UIImageView()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        selectionStyle = .none
        
        cellImageView = UIImageView.init()
        contentView.addSubview(cellImageView)
        cellImageView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(-15)
            make.top.equalTo(15)
            make.width.equalTo((90 - 15*2)*1.2)
        }
        
        titleLabel = UILabel.init()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.right.equalTo(cellImageView.snp.left).offset(-15)
        }
    }
    
    func model(model: StoryModel) {
        
        titleLabel.text = model.title
        cellImageView.kf.setImage(with: URL.init(string: (model.images?.count)! > 0 ? (model.images?.first)! : ""))
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
