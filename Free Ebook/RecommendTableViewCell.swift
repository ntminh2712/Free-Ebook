//
//  RecommendTableViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/8/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit
import GoogleMobileAds
class RecommendTableViewCell: UITableViewCell {
    @IBOutlet weak var RCCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        RCCollectionView.delegate = self
        RCCollectionView.dataSource = self
        RCCollectionView.register(UINib(nibName: "RecommendCollectionViewCell", bundle: nil)
            , forCellWithReuseIdentifier:"recommendCollectionViewCell" )
    }
    @IBAction func viewAllRecommend(_ sender: Any) {
        self.viewAllRecommend?()
    }
    
    func refresh()
    {
        self.RCCollectionView.reloadData()
    }
    func handlerFavorites(row:Int) {
        if !listRecommend[row].isFavorites {
            FavoritesRealmEntity.addFavorites(listRecommend[row])
        }else {
            FavoritesRealmEntity.deleteFavorites(listRecommend[row].id)
        }
        listRecommend[row].isFavorites = !listRecommend[row].isFavorites
        refresh()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    var viewAllRecommend: (() ->())?
    var clickCell:(()->())?
}
extension RecommendTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listRecommend.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  RCCollectionView.dequeueReusableCell(withReuseIdentifier: "recommendCollectionViewCell", for: indexPath) as! RecommendCollectionViewCell
        cell.handlerFavorites = { [weak self] in
            self!.handlerFavorites(row:indexPath.row)
        }
        cell.selectStory = { [weak self] in
            self?.clickCell?()
            DataSingleton.Story = listRecommend[indexPath.row]
        }
        cell.setData(data: listRecommend[indexPath.row])
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (CGSize(width: 140, height: 260))
        
    }
    
}
