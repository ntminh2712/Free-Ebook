//
//  FeedBookViewController.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/8/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit
import GoogleMobileAds
class FeedBookViewController: UIViewController, FeedBookView, GADBannerViewDelegate{
    var presenter: FeedBookPresent!
    var FeedBookConfig:FeedBookConfiguaration = FeedBookConfiguarationImplementation()
    @IBOutlet weak var tbFeedBook: UITableView!
    @IBOutlet weak var tbRender: UITableView!
    @IBOutlet weak var heghtTbRender: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        FeedBookConfig.configuration(feedBookViewController: self)
        setupTableFeedBook()
        setupTableRender()
        checkSearchRender()
        
    }
    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView.adUnitID = Admod.banner
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        
        return adBannerView
    }()

    func setupTableFeedBook() {
        tbFeedBook.delegate = self
        tbFeedBook.dataSource = self
        tbFeedBook.register(UINib(nibName: "TopYesterdayTableViewCell", bundle: nil), forCellReuseIdentifier: "topYesterdayTableViewCell")
        tbFeedBook.register(UINib(nibName: "RecommendTableViewCell", bundle: nil), forCellReuseIdentifier: "recommendTableViewCell")
        tbFeedBook.register(UINib(nibName: "NewReleaseTableViewCell", bundle: nil), forCellReuseIdentifier: "newReleaseTableViewCell")
        tbFeedBook.register(UINib(nibName: "CellOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "cellOptionTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        listDownLoad = StoryRealmEntity.getAllStoryDownload()!
        listIdFavorites = FavoritesRealmEntity.getListFavorites()!
        refresh()
    }
    
    func refresh() {
        tbFeedBook.reloadData()
        tbRender.reloadData()
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
extension FeedBookViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbFeedBook {
        return 4
        }else {
            return listSearch.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbFeedBook {
            switch indexPath.row {
            case 1:
                let cell = tbFeedBook.dequeueReusableCell(withIdentifier: "topYesterdayTableViewCell") as! TopYesterdayTableViewCell
                cell.viewAllTopYesterday = { [weak self] in
                    DataSingleton.ViewCategory = Category.ViewAllTopYesterday
                    self?.presenter.viewAllTopYesterday()
                }
                cell.clickCell = {
                    [weak self] in
                    self?.presenter.goToDetail()
                }
                let bannerView = TopYesterdayTableViewCell.addBanner(rootVC: self, frame:cell.viewBanner.bounds)
                for view in cell.viewBanner.subviews {
                    if view.isKind(of:GADBannerView.self) {
                        
                        view.removeFromSuperview()
                    }
                }
                cell.viewBanner.addSubview(bannerView)
                let request = GADRequest()
                request.testDevices = [kGADSimulatorID]
                DispatchQueue.main.async(execute: {
                    bannerView.load(request)
                })

                cell.refresh()
                return cell
            case 2:
                let cell = tbFeedBook.dequeueReusableCell(withIdentifier: "recommendTableViewCell") as! RecommendTableViewCell
                cell.viewAllRecommend = { [weak self] in
                    DataSingleton.ViewCategory = Category.ViewAllRecommend
                    self?.presenter.viewAllRecommend()
                }
                cell.clickCell = {
                    [weak self] in
                    self?.presenter.goToDetail()
                }
                
                cell.refresh()
                return cell
            case 3:
                let cell = tbFeedBook.dequeueReusableCell(withIdentifier: "newReleaseTableViewCell") as! NewReleaseTableViewCell
                cell.viewAllNewRelease = { [weak self] in
                    DataSingleton.ViewCategory = Category.ViewAllNewRelease
                    self?.presenter.viewAllNewRelease()
                }
                cell.clickCell = {
                    [weak self] in
                    self?.presenter.goToDetail()
                }
                
                cell.refresh()
                return cell
            default:
                let cell = tbFeedBook.dequeueReusableCell(withIdentifier: "cellOptionTableViewCell") as! CellOptionTableViewCell
                cell.selectNewRelease = { [weak self] in
                    DataSingleton.ViewCategory = Category.NewRelease
                    self?.presenter.goListStory()
                }
                cell.selectTopAuthor = { [weak self] in
                    self?.presenter.goToTopAuthor()
                }
                cell.selectTopMonth = { [weak self] in
                    DataSingleton.ViewCategory = Category.TopMonth
                    self?.presenter.goListStory()
                }
                return cell
            }
        }else {
            let cell = tbRender.dequeueReusableCell(withIdentifier: "cellSearchTableViewCell") as! CellSearchTableViewCell
            cell.lblSearch.text = listSearch[indexPath.row].title
            cell.selectStory = { [weak self] in
                DataSingleton.Story = listSearch[indexPath.row]
                listSearch.removeAll()
                self!.presenter.goToDetail()
            }
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tbFeedBook == tableView {
            switch indexPath.row {
            case 0:
                return 55
            case 1:
                return 370
            default:
                return 330
                
            }
        }else {
            return 50
        }
        
    }
}
