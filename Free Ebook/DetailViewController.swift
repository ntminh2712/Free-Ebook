//
//  DetailViewController.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/11/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit
import GoogleMobileAds
class DetailViewController: UIViewController, DetailView , GADBannerViewDelegate, GADInterstitialDelegate{
    let handlerDownload: StoryRealmEntity = StoryRealmEntity()
    var presenter: DetailPresent!
    var detailConfig: DetailConfiguaration = DetailConfiguarationImplementation()
    var isSearch:Bool = true
    var showAdMode:Bool = true
    let activity:UIActivityIndicatorView = UIActivityIndicatorView()
    var idStoryOld:Int!
    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView.adUnitID = Admod.banner
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        
        return adBannerView
    }()
    var interstitial: GADInterstitial?
    @IBOutlet weak var viewBondSearch: UIView!
    @IBOutlet weak var tbRender: UITableView!
    @IBOutlet weak var heghtTbRender: NSLayoutConstraint!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var tbDetail: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailConfig.configuration(detailViewController: self)
        presenter.viewDidLoad()
        detailConfig.configuration(detailViewController: self)
        tbDetail.dataSource = self
        tbDetail.delegate = self
        tbDetail.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "detailTableViewCell")
        tbDetail.register(UINib(nibName: "SameAuthorTableViewCell", bundle: nil), forCellReuseIdentifier: "sameAuthorTableViewCell")
        tbDetail.register(UINib(nibName: "SameCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "sameCategoryTableViewCell")
        self.tbDetail.rowHeight = UITableView.automaticDimension
        viewBondSearch.isHidden = true
        viewSearch.setLayoutViewSearch()
        setupTableRender()
        checkSearchRender()
        
    }
    func reloadViewController(){
        presenter.viewDidLoad()
        self.showAdMode = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        listDownLoad = StoryRealmEntity.getAllStoryDownload()!
        listIdFavorites = FavoritesRealmEntity.getListFavorites()!
        presenter.getSameAuthor()
        presenter.getSameCategory()
        txtSearch.text = ""
        txtSearch.endEditing(true)
        checkSearchRender()
        heghtTbRender.constant = 0
        refresh()
        
    }
    
    private func createAndLoadInterstitial() -> GADInterstitial? {
        interstitial = GADInterstitial(adUnitID: Admod.interstitial)
        
        guard let interstitial = interstitial else {
            return nil
        }
        
        let request = GADRequest()
        request.testDevices = [ kGADSimulatorID ]
        interstitial.load(request)
        interstitial.delegate = self
        
        return interstitial
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func refresh() {
        tbDetail.reloadData()
        tbRender.reloadData()
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
        isSearch = true
        presenter.search(keyword: txtSearch.text!)
        
    }
    func interstitialDidReceiveAd(_ ad: GADInterstitial!) {
        print("Interstitial loaded successfully")
        ad.present(fromRootViewController: self)
    }
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial!) {
        print("Fail to receive interstitial")
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
        txtSearch.endEditing(true)
        listSearch.removeAll()
        checkSearchRender()
        heghtTbRender.constant = 0
        
    }
    func hiddenSameAuthor() {
        
        tbDetail.deleteRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
    }
    func setupTableRender() {
        tbRender.dataSource = self
        tbRender.delegate = self
        tbRender.register(UINib(nibName: "CellSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "cellSearchTableViewCell")
    }
    func checkSearchRender(){
        if listSearch.count != 0 {
            if isSearch
            {
                heghtTbRender.constant = 250
            }
            else
            {
                heghtTbRender.constant = 0
            }
        }else {
            heghtTbRender.constant = 0
        }
        
    }
    
}
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tbDetail == tableView{
            return 3
        }else {
            return listSearch.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tbDetail  == tableView {
            switch indexPath.row {
            case 1:
                let cell = tbDetail.dequeueReusableCell(withIdentifier: "sameAuthorTableViewCell") as! SameAuthorTableViewCell
                cell.viewAllSameAuthor = { [weak self] in
                    DataSingleton.ViewCategory = Category.ViewAllSameAuthor
                    self?.presenter.presentListStory()
                }
                cell.refresh()
                cell.clickCell = { [weak self] in
                    self?.idStoryOld = DataSingleton.Story?.id
                    let indexPath = IndexPath(row: 0, section: 0)
                    self!.tbDetail.scrollToRow(at: indexPath, at: .top, animated: true)
                    listDownLoad = StoryRealmEntity.getAllStoryDownload()!
                    listIdFavorites = FavoritesRealmEntity.getListFavorites()!
                    self?.reloadViewController()
                    cell.refresh()
                }
                return cell
            case 2:
                let cell = tbDetail.dequeueReusableCell(withIdentifier: "sameCategoryTableViewCell") as! SameCategoryTableViewCell
                cell.viewAllSameCategory = { [weak self] in
                    DataSingleton.ViewCategory = Category.ViewAllSameCategory
                    self?.presenter.presentListStory()
                }
                cell.clickCell = { [weak self] in
                    self?.idStoryOld = DataSingleton.Story?.id
                    let indexPath = IndexPath(row: 0, section: 0)
                    self!.tbDetail.scrollToRow(at: indexPath, at: .top, animated: true)
                    listDownLoad = StoryRealmEntity.getAllStoryDownload()!
                    listIdFavorites = FavoritesRealmEntity.getListFavorites()!
                    self?.reloadViewController()
                    cell.refresh()
                }
                cell.refresh()
                return cell
            default:
                let cell = tbDetail.dequeueReusableCell(withIdentifier: "detailTableViewCell") as! DetailTableViewCell
                presenter.setData(cell: cell)
                cell.download = { [weak self] in
                    
                    if !cell.isDownload {
                        self?.interstitial = self?.createAndLoadInterstitial()
                        self!.presenter.downloadCountStory(id: (DataSingleton.Story?.id)!)
                        self!.presenter.saveDownloadLocal()
                    }else {
                        if self!.showAdMode{
                            let ramdomAdMod = Bool.random()
                            if ramdomAdMod {
                                self?.interstitial = self?.createAndLoadInterstitial()
                                self?.showAdMode = false
                                return
                            }
                        }
                        self!.presenter.readBook()
                        
                    }
                }
                let bannerView = DetailTableViewCell.addBanner(rootVC: self, frame:cell.viewBanner.bounds)
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
                
                return cell
            }
        }else {
            let cell = tbRender.dequeueReusableCell(withIdentifier: "cellSearchTableViewCell") as! CellSearchTableViewCell
            cell.lblSearch.text = listSearch[indexPath.row].title
            cell.selectStory = { [weak self] in
                listDownLoad = StoryRealmEntity.getAllStoryDownload()!
                listIdFavorites = FavoritesRealmEntity.getListFavorites()!
                self?.isSearch = false
                self?.heghtTbRender.constant = 0
                DataSingleton.Story = listSearch[indexPath.row]
                self?.txtSearch.endEditing(true)
                listSearch.removeAll()
                self?.reloadViewController()
                self?.cancel()
                self?.refresh()
            }
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tbDetail == tableView {
            if indexPath.row == 0 {
                return 270
            }else {
                return 330
            }
        }else {
            return 50
        }
    }
    
}
