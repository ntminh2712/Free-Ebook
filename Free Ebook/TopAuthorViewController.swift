//
//  TopAuthorViewController.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/14/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit
import GoogleMobileAds
class TopAuthorViewController: UIViewController, TopAuthorView, GADBannerViewDelegate{
    let activity:UIActivityIndicatorView = UIActivityIndicatorView()
    var presenter:TopAuthorPresent!
    var configuration: TopAuthorConfiguaration = TopAuthorConfiguarationImplementation()
    @IBOutlet weak var viewBanner: UIView!
     var adBannerView: GADBannerView?
    @IBOutlet weak var viewBondSearch: UIView!
    @IBOutlet weak var tbRender: UITableView!
    @IBOutlet weak var heghtTbRender: NSLayoutConstraint!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var clAuthor: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration.configuration(topAuthorViewController: self)
        presenter.viewDidLoad()
        setupLayout()
        
    }
    
    func setupLayout() {
        clAuthor.delegate = self
        clAuthor.dataSource = self
        clAuthor.register(UINib(nibName: "TopAuthorCollectionViewCell", bundle: nil)
            , forCellWithReuseIdentifier:"topAuthorCollectionViewCell" )
        let layout = clAuthor.collectionViewLayout as? UICollectionViewFlowLayout
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
        txtSearch.text = ""
        txtSearch.endEditing(true)
        checkSearchRender()
        heghtTbRender.constant = 0
    }
    func refresh() {
        clAuthor.reloadData()
        tbRender.reloadData()
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    
    
}
extension TopAuthorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listTopAuthor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  clAuthor.dequeueReusableCell(withReuseIdentifier: "topAuthorCollectionViewCell", for: indexPath) as! TopAuthorCollectionViewCell
        cell.clickDetail = { [weak self] in
            DataSingleton.Author = listTopAuthor[indexPath.row]
            self!.presenter.presentDetailAuthor()
        }
        presenter.setData(cell: cell, row: indexPath.row)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (CGSize(width: UIScreen.main.bounds.width / 3 , height: 250))
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == listTopAuthor.count - 1 {
            if presenter.offset == 0 {
                presenter.offset = (presenter.offset + 1) + 20
            }else{
                presenter.offset = presenter.offset + 20
            }
            presenter.getTopAuthor()
        }
    }
    
}
extension TopAuthorViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbRender.dequeueReusableCell(withIdentifier: "cellSearchTableViewCell") as! CellSearchTableViewCell
        cell.lblSearch.text = listSearch[indexPath.row].title
        cell.selectStory = { [weak self] in
            DataSingleton.Story = listSearch[indexPath.row]
            listSearch.removeAll()
            self!.presenter.presentDetailStory()
            
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
}
