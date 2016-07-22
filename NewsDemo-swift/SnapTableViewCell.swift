//
//  SnapTableViewCell.swift
//  NewsDemo-swift
//
//  Created by 淘未 on 16/7/22.
//  Copyright © 2016年 黄 家金. All rights reserved.
//

import UIKit
import SnapKit

class SnapTableViewCell: UITableViewCell {
    
    // MARK: - property
    
    var testImageView = UIImageView()
    var titleLabel = UILabel()
    var detailLabel = UILabel()
    var typeLabel = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(testImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailLabel)
        self.contentView.addSubview(typeLabel)
        
        detailLabel.numberOfLines = 2;
        detailLabel.font = UIFont.systemFontOfSize(10)
        detailLabel.textColor = UIColor.grayColor()
        
        testImageView.snp_makeConstraints { (make) in
            make.top.bottom.left.equalTo(self.contentView).inset(UIEdgeInsetsMake(15, 15, 15, 0))
            make.width.equalTo(70)
            
            
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(testImageView.snp_right).offset(15)
            make.top.equalTo(testImageView)
            make.right.equalTo(self.contentView).offset(-15)
        }
        
        detailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(testImageView.snp_right).offset(15)
            make.top.equalTo(titleLabel.snp_bottom).offset(15)
            make.right.equalTo(self.contentView).offset(-15)

        }
        
        
        typeLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.contentView).offset(-15)
            make.right.equalTo(self.contentView).offset(-15)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    
    

}
