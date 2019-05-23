//
//  ListStoryViewController.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/11/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit
import GoogleMobileAds
class ListStoryViewController: UIViewController,ListStoryView, GADBannerViewDelegate {
    @IBOutlet weak var viewBanner: UIView!
    @IBOutlet weak var clListStory: UICollectionView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewBondSearch: UIView!
    @IBOutlet weak var tbRender: UITableView!
    @IBOutlet weak var heghtTbRender: NSLayoutConstraint!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var heightViewSearch: NSLayoutConstraint!
    
    var presenter:ListStoryPresent!
    var listStoryConfig:ListStoryConfiguaration = ListStoryConfiguarationImplementation()
    let activity:UIActivityIndicatorView = UIActivityIndicatorView()
    var adBannerView: GADBannerView?
    override func viewDidLoad() {
        super.viewDidLoad()
        listStoryConfig.configuration(listStoryViewController: self)
        self.presenter.viewDidLoad()
        clListStory.delegate = self
        clListStory.dataSource = self
        clListStory.register(UINib(nibName: "TopYesterdayCollectionViewCell", bundle: nil)
            , forCellWithReuseIdentifier:"topYesterdayCollectionViewCell" )
        let layout = clListStory.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumInteritemSpacing = 0
        layout?.minimumLineSpacing = 0
        layout?.invalidateLayout()
        viewSearch.setLayoutViewSearch()
        viewBondSearch.isHidden = true
        checkSearchRender()
        setupTableRender()
        adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView?.adUnitID = Admod.banner
        adBannerView?.delegate = self
        adBannerView?.rootViewController = self
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        DispatchQueue.main.async(execute: {
            self.adBannerView?.load(request)
        })
    }
    func adViewDidReceiveAd(_ bannerView: GADBannerView!) {
        print("Banner loaded successfully")
        self.viewBanner.frame = bannerView.frame
        self.viewBanner.addSubview(bannerView)
        let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
        bannerView.transform = translateTransform
        
        UIView.animate(withDuration: 0.5) {
            bannerView.transform = CGAffineTransform.identity
        }
    }
    
    func adView(_ bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        print("Fail to receive ads")
        print(error)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.offset = 0
        listDownLoad = StoryRealmEntity.getAllStoryDownload()!
        listIdFavorites = FavoritesRealmEntity.getListFavorites()!
        viewBondSearch.isHidden = true
        txtSearch.text = ""
        txtSearch.endEditing(true)
        checkSearchRender()
        heghtTbRender.constant = 0
        refresh()
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
    func setNameTag(name: String) {
        lblName.text = name
    }
    
    func refresh() {
        clListStory.reloadData()
        tbRender.reloadData()
    }
    @IBAction func searchEdidChange(_ sender: Any) {
        if  txtSearch.text == "" {
            listSearch.removeAll()
            activityStop()
            return
        }
        presenter.search(keyword: txtSearch.text!)
        
    }
    
    @IBAction func handlerViewSearch(_ sender: Any) {
        viewBondSearch.isHidden = false
        txtSearch.becomeFirstResponder()
    }
    @IBAction func cancel(_ sender: Any) {
        viewBondSearch.isHidden = true
        txtSearch.text = ""
        txtSearch.endEditing(true)
        listSearch.removeAll()
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
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
extension ListStoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  clListStory.dequeueReusableCell(withReuseIdentifier: "topYesterdayCollectionViewCell", for: indexPath) as! TopYesterdayCollectionViewCell
        presenter.setData(cell: cell, row: indexPath.row)
        cell.handlerFavorites = { [weak self] in
            self!.presenter.handlerFavorites(row:indexPath.row)
        }
        cell.selectStory = { [weak self] in
            self!.presenter.selectStory(row:indexPath.row)
            self!.presenter.presentDetail()
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (CGSize(width: (UIScreen.main.bounds.width - 6) / 3 , height: 275))
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.numberOfList - 1 {
            if presenter.offset == 0 {
                presenter.offset = (presenter.offset + 1) + 20
            }else{
                presenter.offset = presenter.offset + 20
            }
            presenter.setCategory()
        }
    }
}
extension ListStoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbRender.dequeueReusableCell(withIdentifier: "cellSearchTableViewCell") as! CellSearchTableViewCell
        cell.lblSearch.text = listSearch[indexPath.row].title
        cell.selectStory = { [weak self] in
            DataSingleton.Story = listSearch[indexPath.row]
            self!.presenter.presentDetail()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
}
