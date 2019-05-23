//
//  DownloadViewController.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/14/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit
var listDownLoad: Array<StoryRealmEntity> = []
class DownloadViewController: UIViewController, DownloadView {
    var presenter:DownloadPresent!
    var downloadConfig: DownloadConfiguaration = DownloadConfiguarationImplementation()
    @IBOutlet weak var clDownload: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadConfig.configuration(downloadViewController: self)
        clDownload.delegate = self
        clDownload.dataSource = self
        clDownload.register(UINib(nibName: "TopYesterdayCollectionViewCell", bundle: nil)
            , forCellWithReuseIdentifier:"topYesterdayCollectionViewCell" )
        let layout = clDownload.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumInteritemSpacing = 0
        layout?.minimumLineSpacing = 0
        layout?.invalidateLayout()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        listDownLoad = StoryRealmEntity.getAllStoryDownload()!
        listDownLoad = StoryRealmEntity.getAllStoryDownload()!
        refresh()
    }
    func refresh() {
        clDownload.reloadData()
    }
    
    
}
extension DownloadViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listDownLoad.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  clDownload.dequeueReusableCell(withReuseIdentifier: "topYesterdayCollectionViewCell", for: indexPath) as! TopYesterdayCollectionViewCell
        presenter?.setData(cell: cell, row: indexPath.row)
        cell.selectStory = { [weak self] in
            DataSingleton.Story?.id  = listDownLoad[indexPath.row].id
            DataSingleton.Story?.authors[0].id = listDownLoad[indexPath.row].authorId
            DataSingleton.Story?.category!.id = listDownLoad[indexPath.row].categoryId
            self!.presenter.presentDetailStory()
        }
        cell.viewFavorites.isHidden = true
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (CGSize(width: UIScreen.main.bounds.width / 3 , height: 275))
        
    }
    
    
}
