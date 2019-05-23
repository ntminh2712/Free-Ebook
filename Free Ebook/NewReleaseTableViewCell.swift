//
//  NewReleaseTableViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/8/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit
import GoogleMobileAds
class NewReleaseTableViewCell: UITableViewCell {
    @IBOutlet weak var NRCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        NRCollectionView.delegate = self
        NRCollectionView.dataSource = self
        NRCollectionView.register(UINib(nibName: "NewReleaseCollectionViewCell", bundle: nil)
            , forCellWithReuseIdentifier:"newReleaseCollectionViewCell" )
    }
    
    @IBAction func viewAllNewRelease(_ sender: Any) {
        self.viewAllNewRelease?()
    }
    func refresh()
    {
        self.NRCollectionView.reloadData()
    }
    func handlerFavorites(row:Int) {
        if !listRelease[row].isFavorites {
            FavoritesRealmEntity.addFavorites(listRelease[row])
        }else {
            FavoritesRealmEntity.deleteFavorites(listRelease[row].id)
        }
        listRelease[row].isFavorites = !listRelease[row].isFavorites
        refresh()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    var viewAllNewRelease: (() ->())?
    var clickCell:(()->())?
    
}
extension NewReleaseTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listRelease.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  NRCollectionView.dequeueReusableCell(withReuseIdentifier: "newReleaseCollectionViewCell", for: indexPath) as! NewReleaseCollectionViewCell
        
        cell.handlerFavorites = { [weak self] in
            self?.handlerFavorites(row: indexPath.row)
        }
        cell.selectStory = { [weak self] in
            self?.clickCell?()
            DataSingleton.Story = listRelease[indexPath.row]
        }
        cell.setData(data: listRelease[indexPath.row])
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (CGSize(width: 140, height: 260))
        
    }
    
}
