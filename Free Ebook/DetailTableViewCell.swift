//
//  DetailTableViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/11/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit
import GoogleMobileAds
protocol ConfigcellDetail {
    func setData(item: FeedBookDataEntity)
}
class DetailTableViewCell: UITableViewCell,ConfigcellDetail {
    var isDownload:Bool = false
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblNameStory: UILabel!
    @IBOutlet weak var lblNameAuthor: UILabel!
    @IBOutlet weak var lblNameLanguage: UILabel!
    @IBOutlet weak var lblPublicAt: UILabel!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var progressDownload: UIProgressView!
    @IBOutlet weak var viewBanner: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContent.setuplayoutCollectionView()
        btnDownload.layer.borderColor = #colorLiteral(red: 0.2342579961, green: 0.5671895146, blue: 0.9857856631, alpha: 1)
        btnDownload.layer.borderWidth = 1
        btnDownload.layer.cornerRadius = 3
        progressDownload.setProgress(0, animated: true)
        progressDownload.isHidden = true
        progressDownload.progressViewStyle = UIProgressView.Style.bar
        progressDownload.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        NotificationCenter.default.addObserver(self, selector: #selector(self.downloadSuscess(_:)), name: notificationName.downloadSuccess.notification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateProgress(_:)), name: notificationName.updateProgress.notification, object: nil)
    }
    
    class func addBanner(rootVC: UIViewController, frame: CGRect) -> GADBannerView {
        
        let bannerView = GADBannerView()
        
        bannerView.frame = frame
        
        bannerView.rootViewController = rootVC
        
        bannerView.adUnitID = Admod.banner
        bannerView.adSize = kGADAdSizeBanner
        
        return bannerView
        
    }
    func setData(item: FeedBookDataEntity) {
        listDownLoad = StoryRealmEntity.getAllStoryDownload()!
        lblCategory.text = item.category!.name
        lblPublicAt.text = item.release_date
        lblNameStory.text = item.title
        if item.authors.count != 0 {
            lblNameAuthor.text = item.authors[0].name
        }
        progressDownload.setProgress(0, animated: true)
        progressDownload.isHidden = true
        
        isDownload = false
        btnDownload.setTitle("Download", for: .normal)
        for i in 0..<listDownLoad.count {
            if item.id == listDownLoad[i].id {
                isDownload = true
                progressDownload.setProgress(0, animated: true)
                progressDownload.isHidden = true
                btnDownload.setTitle("Read", for: .normal)
            }
        }
        imgAvatar.setCustomImage(item.picture, defaultAvatar: nil)
    }
    @objc func updateProgress(_ notification: NSNotification) {
        let progress = notification.userInfo?["progress"] as! Float
        DispatchQueue.main.async {
            self.progressDownload.progress = progress
        }
        
    }
    
    @objc func downloadSuscess(_ notification:NSNotification){
        btnDownload.isEnabled = true
        progressDownload.isHidden = true
        isDownload = true
        let id = notification.userInfo?["idStory"] as? Int
        if id == DataSingleton.Story?.id{
            btnDownload.setTitle("Read", for: .normal)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func download(_ sender: Any) {
        if !isDownload {
            progressDownload.setProgress(0, animated: true)
            progressDownload.isHidden = false
            btnDownload.isEnabled = false
        }
        self.download?()
    }
    
    var download:(()->())?
}
