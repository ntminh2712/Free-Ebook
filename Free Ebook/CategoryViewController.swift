//
//  CategoryViewController.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/8/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, CategoryView {
    var presenter: CategoryPresent!
    var categoryConfig:CategoryConfiguaration = CategoryConfiguarationImplementation()
    @IBOutlet weak var tbCategory: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryConfig.configuration(categoryViewController: self)
        tbCategory.delegate = self
        tbCategory.dataSource = self
        tbCategory.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "categoryTableViewCell")
    }
    

}
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbCategory.dequeueReusableCell(withIdentifier: "categoryTableViewCell") as! CategoryTableViewCell
        cell.selectCategory = { [weak self] in
            self?.presenter.setListStory(row: indexPath.row)
            self?.presenter.presentListStoryCategory()
            DataSingleton.Category = listCategory[indexPath.row]
        }
        presenter.setData(cell: cell, row: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
   
}
