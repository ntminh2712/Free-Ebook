
//
//  CellSearchTableViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/19/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

class CellSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSearch: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func selectStory(_ sender: Any) {
        self.selectStory?()
    }
    var selectStory:(()->())?
}
