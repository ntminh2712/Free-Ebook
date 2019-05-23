//
//  LibraryViewController.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/14/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController, LibraryView{
    
    
    var presenter: LibraryPresent!
    var libraryConfig:LibraryConfiguaration = LibraryConfiguarationImplementation()
    let activity: UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var clFavorite: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()        
        libraryConfig.configuration(libraryViewController: self)
        clFavorite.delegate = self
        clFavorite.dataSource = self
        clFavorite.register(UINib(nibName: "TopYesterdayCollectionViewCell", bundle: nil)
            , forCellWithReuseIdentifier:"topYesterdayCollectionViewCell" )
        let layout = clFavorite.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumInteritemSpacing = 0
        layout?.minimumLineSpacing = 0
        layout?.invalidateLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        listDownLoad = StoryRealmEntity.getAllStoryDownload()!
        listIdFavorites = FavoritesRealmEntity.getListFavorites()!
        refresh()
    }
    func refresh() {
        clFavorite.reloadData()
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
    
}
extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listIdFavorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  clFavorite.dequeueReusableCell(withReuseIdentifier: "topYesterdayCollectionViewCell", for: indexPath) as! TopYesterdayCollectionViewCell
        presenter.setData(cell: cell, row: indexPath.row)
        cell.selectStory = { [weak self] in
            DataSingleton.Story?.id  = listIdFavorites[indexPath.row].id
            if DataSingleton.Story?.authors.count != 0 {
                DataSingleton.Story?.authors[0].id = listIdFavorites[indexPath.row].authorId
            }
            DataSingleton.Story?.category!.id = listIdFavorites[indexPath.row].categoryId
            self!.presenter.presentDetailStory()
        }
        cell.handlerFavorites = { [weak self] in
            FavoritesRealmEntity.deleteFavorites(listIdFavorites[indexPath.row].id)
            listIdFavorites.remove(at: indexPath.row)
            self?.refresh()
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (CGSize(width: UIScreen.main.bounds.width / 3 , height: 275))
        
    }
}
