//
//  ImageTableViewCell.swift
//  NewsDemo-swift
//
//  Created by 淘未 on 16/7/22.
//  Copyright © 2016年 黄 家金. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    lazy var bigImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.grayColor()
        return imageView
    }()
    
    lazy var titleLable:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(12)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
     }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        
        self.contentView.addSubview(bigImageView)
        self.contentView.addSubview(titleLable)
        
        titleLable.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(self.contentView).inset(UIEdgeInsetsMake(15, 15, 0, 15))
        }
        
        bigImageView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.contentView).inset(UIEdgeInsetsMake(0, 15, 0, 15))
            make.top.equalTo(titleLable.snp_bottom).offset(15)
            make.bottom.equalTo(self.contentView).offset(-15)
        }
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

}
