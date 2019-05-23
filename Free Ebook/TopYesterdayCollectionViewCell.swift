//
//  TopYesterdayCollectionViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/8/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

protocol ConfigCollectionViewCell {
    func setData(data:FeedBookDataEntity)
    func setDataListCategory(data:ChildrenEntity)
    func setDataRealm(data: StoryRealmEntity)
    func setDataFavorites(data: FavoritesRealmEntity)
}

class TopYesterdayCollectionViewCell: UICollectionViewCell,ConfigCollectionViewCell {
    
    @IBOutlet weak var lblNameStory: UILabel!
    @IBOutlet weak var lblNameAuthor: UILabel!
    @IBOutlet weak var viewFavorites: UIView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgFavorites: UIImageView!
    @IBOutlet weak var imgAvatar: UIImageView!
    
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
        if data.isFavorites == true {
            imgFavorites.image = UIImage(named: "favorite 2")
        }else {
            imgFavorites.image = UIImage(named: "favorite")
        }
        imgAvatar.setCustomImage(data.picture, defaultAvatar: nil)
    }
    
    func setDataFavorites(data: FavoritesRealmEntity) {
        lblNameStory.text = data.name
        lblNameAuthor.text = data.author
            imgFavorites.image = UIImage(named: "favorite 2")
        imgAvatar.setCustomImage(data.picture, defaultAvatar: nil)
    }
    func setDataListCategory(data: ChildrenEntity) {
        lblNameStory.text = data.name
        lblNameAuthor.text = ""
        imgAvatar.setCustomImage(data.picture, defaultAvatar: nil)
    }
    func setDataRealm(data: StoryRealmEntity) {
        lblNameStory.text = data.title
            lblNameAuthor.text = data.authors
        imgAvatar.setCustomImage(data.picture, defaultAvatar: nil)
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

