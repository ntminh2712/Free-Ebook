//
//  AuthorInfoTableViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/14/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

class AuthorInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var lblNameAuthor: UILabel!
    @IBOutlet weak var lblBornDie: UILabel!
    //    @IBOutlet weak var heightViewContext: NSLayoutConstraint!
    @IBOutlet weak var imgAvatar: UIImageView!
    var isReadMore: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContent.setuplayoutCollectionView()
        viewImage.setuplayoutCollectionView()
        lblNameAuthor.text = DataSingleton.Author?.name
        imgAvatar.setCustomImage(DataSingleton.Author?.picture, defaultAvatar: nil)
        lblBornDie.text = DataSingleton.Author?.born_die
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
