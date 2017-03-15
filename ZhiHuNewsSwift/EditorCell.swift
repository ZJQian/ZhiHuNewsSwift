//
//  EditorCell.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/14.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit

class EditorCell: UITableViewCell {

    
    var headImgView = UIImageView()
    var nameLabel = UILabel()
    var nicknameLabel = UILabel()
    var model = EditorModel() {
    
        didSet {
        
            headImgView.kf.setImage(with: URL.init(string: model.avatar!))
            
            nameLabel.text = model.name
            
            nicknameLabel.text = model.bio
        
        }
    
    }
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        selectionStyle = .none
        
        headImgView = UIImageView.init()
        headImgView.layer.cornerRadius = 20
        headImgView.layer.masksToBounds = true
        contentView.addSubview(headImgView)
        headImgView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(40)
        }
        
        nameLabel = UILabel.init()
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headImgView.snp.right).offset(15)
            make.top.equalTo(headImgView)
            make.width.equalTo(200)
            make.height.equalTo(18)
        }
        
        nicknameLabel = UILabel.init()
        nicknameLabel.font = UIFont.systemFont(ofSize: 10)
        nicknameLabel.textColor = UIColor.lightGray
        contentView.addSubview(nicknameLabel)
        nicknameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(headImgView)
            make.width.equalTo(200)
            make.height.equalTo(10)
        }
        
        let img = UIImageView.init()
        img.image = UIImage.init(named: "next")
        contentView.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.left.equalTo(screenW-26)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(16)
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
