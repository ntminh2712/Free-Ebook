//
//  SameAuthorTableViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/18/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

class SameAuthorTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var clSameAuthor: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        clSameAuthor.delegate = self
        clSameAuthor.dataSource = self
        clSameAuthor.register(UINib(nibName: "TopYesterdayCollectionViewCell", bundle: nil)
            , forCellWithReuseIdentifier:"topYesterdayCollectionViewCell" )
    }
    func refresh()
    {
        self.clSameAuthor.reloadData()
    }
    @IBAction func viewAllTopYesterday(_ sender: Any) {
        self.viewAllSameAuthor?()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func handlerFavorites(row:Int) {
        if !listSameAuthor[row].isFavorites {
            FavoritesRealmEntity.addFavorites(listSameAuthor[row])
        }else {
            FavoritesRealmEntity.deleteFavorites(listSameAuthor[row].id)
        }
        listSameAuthor[row].isFavorites = !listSameAuthor[row].isFavorites
        refresh()
    }
    
    var viewAllSameAuthor: (()->())?
    var clickCell:(()->())?
}
extension SameAuthorTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSameAuthor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  clSameAuthor.dequeueReusableCell(withReuseIdentifier: "topYesterdayCollectionViewCell", for: indexPath) as! TopYesterdayCollectionViewCell
        cell.handlerFavorites = { [weak self] in
            self?.handlerFavorites(row: indexPath.row)
        }
        cell.selectStory = { [weak self] in
            DataSingleton.Story = listSameAuthor[indexPath.row]
            self?.clickCell?()
            self?.refresh()
            
        }
        cell.setData(data: listSameAuthor[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (CGSize(width: 140, height: 260))
        
    }
    
}
