//
//  CategoryTableViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/11/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

protocol ConfigCellCategory {
    func setData(item:StoryEntity)
}
class CategoryTableViewCell: UITableViewCell, ConfigCellCategory {

    @IBOutlet weak var imgAvatar: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       viewContent.setuplayoutCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(item: StoryEntity) {
        lblName.text = item.name
        imgAvatar.image = UIImage(named: "\((item.name)!)")
    }
    
    @IBAction func selectCategory(_ sender: Any) {
        self.selectCategory?()
    }
    var selectCategory:(()->())?
    
}
