//
//  Sub-CategoryViewController.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/17/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

class Sub_CategoryViewController: UIViewController {
    @IBOutlet weak var tbSubCategory: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tbSubCategory.delegate = self
        tbSubCategory.dataSource = self
        tbSubCategory.register(UINib(nibName: "SubCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "subCategoryTableViewCell")
    }
    
}
extension Sub_CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSubCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbSubCategory.dequeueReusableCell(withIdentifier: "subCategoryTableViewCell") as! SubCategoryTableViewCell
        cell.lblNameSubCategory.text = listSubCategory[indexPath.row].name
        cell.selectCategory = { [weak self] in
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenListStory") as! ListStoryViewController
            DataSingleton.ViewCategory = Category.SubCategory
            DataSingleton.SubCategory = listSubCategory[indexPath.row].name
            DataSingleton.Category?.id = listSubCategory[indexPath.row].id
            self!.navigationController?.pushViewController(vc, animated: true)
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
