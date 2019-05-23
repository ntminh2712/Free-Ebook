//
//  AvatarTableViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/9/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

class AvatarTableViewCell: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgAvatar.layer.masksToBounds = false
        imgAvatar.layer.cornerRadius = imgAvatar.frame.height / 2
        imgAvatar.layer.borderColor = UIColor.white.cgColor
        imgAvatar.layer.borderWidth = 1
        imgAvatar.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
