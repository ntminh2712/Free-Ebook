//
//  AllStoryCategoryViewController.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/17/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit

class AllStoryCategoryViewController: UIViewController  , AllStoryCategoryView{
    let activity:UIActivityIndicatorView = UIActivityIndicatorView()
    var presenter: AllStoryCategoryPresent!
    var allStoryCategoryConfig: AllStoryCategoryConfiguaration = AllStoryCategoryConfiguarationImplementation()
    @IBOutlet weak var clAllCategory: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        allStoryCategoryConfig.configuration(allStoryCategoryViewController: self)
        presenter.viewDidLoad()
        clAllCategory.delegate = self
        clAllCategory.dataSource = self
        clAllCategory.register(UINib(nibName: "TopYesterdayCollectionViewCell", bundle: nil)
            , forCellWithReuseIdentifier:"topYesterdayCollectionViewCell" )
        let layout = clAllCategory.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumInteritemSpacing = 0
        layout?.minimumLineSpacing = 0
        layout?.invalidateLayout()
    }
    
    func refresh() {
        clAllCategory.reloadData()
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
extension AllStoryCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  clAllCategory.dequeueReusableCell(withReuseIdentifier: "topYesterdayCollectionViewCell", for: indexPath) as! TopYesterdayCollectionViewCell
        presenter.setData(cell: cell, row: indexPath.row)
        cell.handlerFavorites = { [weak self] in
            self!.presenter.handlerFavorites(row: indexPath.row)
            self!.refresh()
        }
        cell.selectStory = { [weak self] in
            self!.presenter.selectStory(row: indexPath.row)
            self!.presenter.presentDetail()
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.numberOfList - 1 {
            if presenter.offset == 0 {
                presenter.offset = (presenter.offset + 1) + 20
            }else{
                presenter.offset = presenter.offset + 20
            }
            presenter.getCategory()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (CGSize(width: UIScreen.main.bounds.width / 3 , height: 275))
        
    }
    
    
}
