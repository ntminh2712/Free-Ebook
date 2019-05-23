//
//  ListStoryCategoryViewController.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/17/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit
import GoogleMobileAds
var listSubCategory:[ChildrenEntity] = []
class ListStoryCategoryViewController: UIViewController,ListStoryCategoryView, GADBannerViewDelegate {
    @IBOutlet weak var viewBanner: UIView!
    var presenter: ListStoryCategoryPresent!
    var listStoryCategoryConfig = ListStoryCategoryConfiguarationImplementation()
    @IBOutlet weak var lblNameTag: UILabel!
    @IBOutlet weak var cvAllListStory: UIView!
    @IBOutlet weak var cvSubCategory: UIView!
    @IBOutlet weak var smCategory: UISegmentedControl!
    var adBannerView: GADBannerView?
    let activity: UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var viewBondSearch: UIView!
    @IBOutlet weak var tbRender: UITableView!
    @IBOutlet weak var heghtTbRender: NSLayoutConstraint!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viewSearch: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        listStoryCategoryConfig.configuration(listStoryCategoryViewController: self)
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
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func changeSegmend(_ sender: UISegmentedControl) {
        if smCategory.selectedSegmentIndex == segmented.AllStory {
            setSegumendAll()
        }else {
            setSegumendSubCategory()
        }
    }
    
    func setSegumendAll() {
        UIView.animate(withDuration: 0.5) {
            self.cvAllListStory.alpha = 1
            self.cvSubCategory.alpha = 0
        }
    }
    func setSegumendSubCategory() {
        UIView.animate(withDuration: 0.5) {
            self.cvAllListStory.alpha = 0
            self.cvSubCategory.alpha = 1
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        txtSearch.text = ""
        txtSearch.endEditing(true)
        checkSearchRender()
        heghtTbRender.constant = 0
        lblNameTag.text = DataSingleton.Category!.name
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
extension ListStoryCategoryViewController: UITableViewDelegate, UITableViewDataSource{
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
