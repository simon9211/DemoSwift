//
//  FMHomeItemCell.swift
//  FMDemoSwift
//
//  Created by xiwang wang on 2018/8/29.
//  Copyright © 2018年 com.simon. All rights reserved.
//

import UIKit

class FMHomeItemCell: UITableViewCell {

    private var _imageName: String = ""
    var imageName:String {
        get {
            return _imageName
        }
        set(value) {
            _imageName = value
            self.bannerImage.image = UIImage(named: value)
        }
    }
    
    private var bannerImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bannerImage.image = UIImage(named: imageName)
        contentView.addSubview(bannerImage)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bannerImage.image = UIImage(named: imageName)
        contentView.addSubview(bannerImage)
    }
    
    override open class var requiresConstraintBasedLayout: Bool {
        get {
            return true
        }
    }
    
    override func updateConstraints() {
        bannerImage.snp.makeConstraints { (make) in
//            make.margins.equalTo(10)
            make.leftMargin.topMargin.equalTo(10)
            make.rightMargin.bottomMargin.equalTo(-10)
        }
        
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
