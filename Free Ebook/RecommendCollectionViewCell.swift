//
//  RecommendCollectionViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/8/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

class RecommendCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblNameStory: UILabel!
    @IBOutlet weak var lblNameAuthor: UILabel!
    @IBOutlet weak var viewFavorites: UIView!
    @IBOutlet weak var imgFavorites: UIImageView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var viewContent: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContent.setuplayoutCollectionView()
        viewFavorites.setViewRadius()
    }
    
    func setData(data: FeedBookDataEntity) {
        lblNameStory.text = data.title
        if data.authors.count != 0 {
            lblNameAuthor.text = data.authors[0].name
        }
        imgAvatar.setCustomImage(data.picture, defaultAvatar: nil)
        //        imgFavorites.image = UIImage()
        if data.isFavorites == true {
            imgFavorites.image = UIImage(named: "favorite 2")
        }else {
            imgFavorites.image = UIImage(named: "favorite")
        }
    }
    @IBAction func selectStory(_ sender: Any) {
        self.selectStory?()
    }
    @IBAction func handlerFavorites(_ sender: Any) {
        self.handlerFavorites?()
    }
    var handlerFavorites: (()->())?
    var selectStory: (()->())?
}
