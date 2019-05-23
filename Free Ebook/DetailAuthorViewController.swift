//
//  DetailAuthorViewController.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/14/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

class DetailAuthorViewController: UIViewController, DetailAuthorView {
    var presenter: DetailAuthorPresent!
    var detailConfig: DetailAuthorConfiguaration = DetailAuthorConfiguarationImplementation()
    let activity: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var tbDetailAuthor: UITableView!
    @IBOutlet weak var viewBondSearch: UIView!
    @IBOutlet weak var tbRender: UITableView!
    @IBOutlet weak var heghtTbRender: NSLayoutConstraint!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viewSearch: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailConfig.configuration(detailAuthorViewController: self)
        presenter.viewDidLoad()
        tbDetailAuthor.dataSource = self
        tbDetailAuthor.delegate = self
        tbDetailAuthor.register(UINib(nibName: "AuthorInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "authorInfoTableViewCell")
        tbDetailAuthor.register(UINib(nibName: "FromAuthorTableViewCell", bundle: nil), forCellReuseIdentifier: "fromAuthorTableViewCell")
        viewBondSearch.isHidden = true
        viewSearch.setLayoutViewSearch()
        setupTableRender()
        checkSearchRender()
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func refresh() {
        tbDetailAuthor.reloadData()
        tbRender.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        listDownLoad = StoryRealmEntity.getAllStoryDownload()!
        listIdFavorites = FavoritesRealmEntity.getListFavorites()!
        presenter.getSameAuthor()
        txtSearch.text = ""
        txtSearch.endEditing(true)
        checkSearchRender()
        heghtTbRender.constant = 0
        
    }
    func activityStart(){
        activity.center = self.view.center
        activity.hidesWhenStopped = true
        activity.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activity)
        activity.startAnimating()
    }
    func activityStop(){
        activity.stopAnimating()
    }
    @IBAction func searchEdidChange(_ sender: Any) {
        presenter.search(keyword: txtSearch.text!)
        
    }
    
    @IBAction func handlerViewSearch(_ sender: Any) {
        viewBondSearch.isHidden = false
        txtSearch.endEditing(true)
    }
    @IBAction func cancel(_ sender: Any) {
        cancel()
    }
    func cancel() {
        viewBondSearch.isHidden = true
        txtSearch.text = ""
        listSearch.removeAll()
        heghtTbRender.constant = 0
        checkSearchRender()
    }
    func setupTableRender() {
        tbRender.dataSource = self
        tbRender.delegate = self
        tbRender.register(UINib(nibName: "CellSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "cellSearchTableViewCell")
    }
    func checkSearchRender(){
        if listSearch.count != 0 {
            heghtTbRender.constant = 250
        }else {
            heghtTbRender.constant = 0
        }
    }
    
}
extension DetailAuthorViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tbDetailAuthor == tableView{
            return 2
        }else {
            return listSearch.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tbDetailAuthor  == tableView {
            switch indexPath.row {
            case 1:
                let cell = tbDetailAuthor.dequeueReusableCell(withIdentifier: "fromAuthorTableViewCell") as! FromAuthorTableViewCell
                cell.viewAllTopYesterday = { [weak self] in
                    DataSingleton.ViewCategory = Category.ViewAllFormAuthor
                    self?.presenter.presentListStory()
                }
                cell.clickCell = { [weak self] in
                    self?.presenter.presentDetail()
                }
                cell.refresh()
                return cell
            default:
                let cell = tbDetailAuthor.dequeueReusableCell(withIdentifier: "authorInfoTableViewCell") as! AuthorInfoTableViewCell
                return cell
            }
        }else {
            let cell = tbRender.dequeueReusableCell(withIdentifier: "cellSearchTableViewCell") as! CellSearchTableViewCell
            cell.lblSearch.text = listSearch[indexPath.row].title
            cell.selectStory = { [weak self] in
                DataSingleton.Story = listSearch[indexPath.row]
                self!.cancel()
                self!.presenter.presentDetail()
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tbDetailAuthor == tableView {
            if indexPath.row == 0 {
                return 240
            }else {
                return 330
            }
        }else {
            return 50
        }
    }
}
