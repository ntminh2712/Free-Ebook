//
//  SubCategoryTableViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/17/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

class SubCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNameSubCategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func selectSubCategory(_ sender: Any) {
        self.selectCategory?()
    }
    
    var selectCategory: (()->())?
    
}
