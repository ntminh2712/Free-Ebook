//
//  TopYesterdayTableViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/8/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit
import GoogleMobileAds
class TopYesterdayTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var TYCollectionView: UICollectionView!
    @IBOutlet weak var viewBanner: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        TYCollectionView.delegate = self
        TYCollectionView.dataSource = self
        TYCollectionView.register(UINib(nibName: "TopYesterdayCollectionViewCell", bundle: nil)
            , forCellWithReuseIdentifier:"topYesterdayCollectionViewCell" )
    }
    class func addBanner(rootVC: UIViewController, frame: CGRect) -> GADBannerView {
        
        let bannerView = GADBannerView()
        
        bannerView.frame = frame
        
        bannerView.rootViewController = rootVC
        
        bannerView.adUnitID = Admod.banner
        bannerView.adSize = kGADAdSizeBanner
        
        return bannerView
        
    }
    
    func refresh()
    {
        self.TYCollectionView.reloadData()
    }
    @IBAction func viewAllTopYesterday(_ sender: Any) {
        self.viewAllTopYesterday?()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func handlerFavorites(row:Int, list:Array<FeedBookDataEntity>) {
        if !list[row].isFavorites {
            FavoritesRealmEntity.addFavorites(list[row])
        }else {
            FavoritesRealmEntity.deleteFavorites(list[row].id)
        }
        list[row].isFavorites = !list[row].isFavorites
        refresh()
    }
    
    var viewAllTopYesterday: (()->())?
    var clickCell:(()->())?
}
extension TopYesterdayTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listTopYesterday.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  TYCollectionView.dequeueReusableCell(withReuseIdentifier: "topYesterdayCollectionViewCell", for: indexPath) as! TopYesterdayCollectionViewCell
        cell.handlerFavorites = { [weak self] in
            self?.handlerFavorites(row: indexPath.row, list: listTopYesterday)
        }
        cell.selectStory = { [weak self] in
           self?.clickCell?()
            DataSingleton.Story = listTopYesterday[indexPath.row]
        }
        cell.setData(data: listTopYesterday[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (CGSize(width: 140, height: 260))
        
    }
    
}
