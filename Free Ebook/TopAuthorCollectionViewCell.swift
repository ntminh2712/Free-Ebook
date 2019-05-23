//
//  TopAuthorCollectionViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/14/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit
protocol ConfigCellTopAuthor {
    func setData(item: AuthorEntity)
}
class TopAuthorCollectionViewCell: UICollectionViewCell,ConfigCellTopAuthor {

    @IBOutlet weak var lblNameAuthor: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewImage.setuplayoutCollectionView()
    }
    
    func setData(item: AuthorEntity) {
        lblNameAuthor.text = item.name
        imgAvatar.setCustomImage(item.picture, defaultAvatar: nil)
        
    }
    
    @IBAction func clickDetail(_ sender: Any) {
        self.clickDetail?()
    }
    var clickDetail:(()->())?
}

