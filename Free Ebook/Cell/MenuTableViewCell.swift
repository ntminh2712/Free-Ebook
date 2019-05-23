//
//  MenuTableViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/9/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

protocol ConfigCellSlideMenu {
    func setData(data: MenuEntity)
}
class MenuTableViewCell: UITableViewCell, ConfigCellSlideMenu {

    @IBOutlet weak var lblNameMenu: UILabel!
    @IBOutlet weak var imgMenu: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func showSelection(_ sender: Any) {
        self.Selected?()
    }
    func setData(data: MenuEntity) {
        if data.isSelected
        {
            
            imgMenu.image = UIImage(named: "\(data.icon!) 1")
            lblNameMenu.text = data.name
            lblNameMenu.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        }
        else
        {
            imgMenu.image = UIImage(named: data.icon!)
            lblNameMenu.text = data.name
            lblNameMenu.textColor = UIColor.black
        }
    }
var Selected: (()->())?
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
