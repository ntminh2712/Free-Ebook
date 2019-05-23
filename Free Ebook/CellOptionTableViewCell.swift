//
//  CellOptionTableViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/8/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

class CellOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var viewTopMonth: UIView!
    @IBOutlet weak var viewTopAuthor: UIView!
    @IBOutlet weak var viewNewRelease: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    func setupLayout(){
        viewNewRelease.setLayoutViewOption()
        viewTopAuthor.setLayoutViewOption()
        viewTopMonth.setLayoutViewOption()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func selectNewRelease(_ sender: Any) {
        self.selectNewRelease?()
    }
    @IBAction func selectTopAuthor(_ sender: Any) {
        self.selectTopAuthor?()
    }
    @IBAction func selectTopMonth(_ sender: Any) {
        self.selectTopMonth?()
    }
    var selectNewRelease: (()->())?
    var selectTopAuthor: (()->())?
    var selectTopMonth: (()->())?
  
}

