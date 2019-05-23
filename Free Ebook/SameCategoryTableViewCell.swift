//
//  SameCategoryTableViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/18/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

class SameCategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var clSameCategor: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        clSameCategor.delegate = self
        clSameCategor.dataSource = self
        clSameCategor.register(UINib(nibName: "TopYesterdayCollectionViewCell", bundle: nil)
            , forCellWithReuseIdentifier:"topYesterdayCollectionViewCell" )
    }
    func refresh()
    {
        self.clSameCategor.reloadData()
    }
    @IBAction func viewAllTopYesterday(_ sender: Any) {
        self.viewAllSameCategory?()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func handlerFavorites(row:Int) {
        if !listSameCategory[row].isFavorites {
            FavoritesRealmEntity.addFavorites(listSameCategory[row])
        }else {
            FavoritesRealmEntity.deleteFavorites(listSameCategory[row].id)
        }
        listSameCategory[row].isFavorites = !listSameCategory[row].isFavorites
        refresh()
    }
    
    var viewAllSameCategory: (()->())?
    var clickCell:(()->())?
}
extension SameCategoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSameCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  clSameCategor.dequeueReusableCell(withReuseIdentifier: "topYesterdayCollectionViewCell", for: indexPath) as! TopYesterdayCollectionViewCell
        cell.handlerFavorites = { [weak self] in
            self?.handlerFavorites(row: indexPath.row)
        }
        cell.selectStory = { [weak self] in
            DataSingleton.Story = listSameCategory[indexPath.row]
            self?.clickCell?()
            self?.refresh()
            
        }
        cell.setData(data: listSameCategory[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (CGSize(width: 140, height: 260))
        
    }
    
}
