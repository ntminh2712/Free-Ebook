//
//  MyLibraryViewController.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/14/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit
import GoogleMobileAds
class MyLibraryViewController: UIViewController, MyLibraryView , GADBannerViewDelegate{

    var presenter: MyLibraryPresent!
    var myLibraryConfig = MyLibraryConfiguarationImplementation()
    @IBOutlet weak var btnFavorites: UIButton!
    @IBOutlet weak var btnDownloaded: UIButton!
    @IBOutlet weak var ctvDownloaded: UIView!
    @IBOutlet weak var ctvFavorites: UIView!
    @IBOutlet weak var viewBanner: UIView!
    @IBOutlet weak var viewBondSearch: UIView!
    @IBOutlet weak var tbRender: UITableView!
    @IBOutlet weak var heghtTbRender: NSLayoutConstraint!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viewSearch: UIView!
    var adBannerView: GADBannerView?
    let activity: UIActivityIndicatorView = UIActivityIndicatorView()
    var isSelect: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        myLibraryConfig.configuration(myLibraryViewController: self)
        btnDownloaded.setLayoutViewOption()
        btnFavorites.setLayoutViewOption()
        showFavorites()
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
    @IBAction func favorites(_ sender: Any) {
        showFavorites()
    }
    
    @IBAction func downloaded(_ sender: Any) {
        showDownloaded()
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showDownloaded() {
        UIView.animate(withDuration: 0.3) {
            self.ctvDownloaded.alpha = 1
            self.ctvFavorites.alpha = 0
            self.btnFavorites.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.btnFavorites.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: .normal)
            self.btnDownloaded.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            self.btnDownloaded.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            
        }
    }
    
    func showFavorites() {
        UIView.animate(withDuration: 0.3) {
            self.ctvFavorites.alpha = 1
            self.ctvDownloaded.alpha = 0
            self.btnDownloaded.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.btnDownloaded.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: .normal)
            self.btnFavorites.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            self.btnFavorites.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        txtSearch.text = ""
        txtSearch.endEditing(true)
        checkSearchRender()
        heghtTbRender.constant = 0
    }
    func refresh() {
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
        presenter.search(keyword: txtSearch.text!)
        
    }
    
    @IBAction func handlerViewSearch(_ sender: Any) {
        viewBondSearch.isHidden = false
        txtSearch.endEditing(true)
    }
    @IBAction func cancel(_ sender: Any) {
        viewBondSearch.isHidden = true
        heghtTbRender.constant = 0
        txtSearch.text = ""
        txtSearch.endEditing(true)
        listSearch.removeAll()
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
extension MyLibraryViewController: UITableViewDelegate, UITableViewDataSource{
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
