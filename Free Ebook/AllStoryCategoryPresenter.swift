//
//  AllStoryCategoryPresenter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/17/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol AllStoryCategoryView {
    func refresh()
    func activityStart()
    func activityStop()
}

protocol AllStoryCategoryPresent{
    func setData(cell:TopYesterdayCollectionViewCell,row:Int)
    func viewDidLoad()
    var numberOfList: Int {get}
    func presentDetail()
    func handlerFavorites(row: Int)
    func selectStory(row:Int)
    func getCategory()
    var offset: Int {get set}
}


class AllStoryCategoryPresentImplementation:LoadingAleart, AllStoryCategoryPresent{
    
    var numberOfList: Int {
        return listAllStoryCategory.count
    }
    var offset:Int = 0
    
    var listAllStoryCategory:[FeedBookDataEntity] = []
    var view: AllStoryCategoryView?
    internal let router: AllStoryCategoryViewRouter
    var allStoryCategoryViewController:AllStoryCategoryViewController
    var allStoryCategoryGateway: AllListStoryCategoryGateway!
    init(view: AllStoryCategoryView, router: AllStoryCategoryViewRouter, allStoryCategoryGateway: AllListStoryCategoryGateway,allStoryCategoryViewController:AllStoryCategoryViewController) {
        self.view = view
        self.router = router
        self.allStoryCategoryGateway = allStoryCategoryGateway
        self.allStoryCategoryViewController = allStoryCategoryViewController
    }
    
    func setData(cell: TopYesterdayCollectionViewCell, row: Int) {
        cell.setData(data: listAllStoryCategory[row])
    }
    func viewDidLoad() {
        getCategory()
    }
    func handlerFavorites(row: Int) {
        if !listAllStoryCategory[row].isFavorites {
            FavoritesRealmEntity.addFavorites(listAllStoryCategory[row])
        }else {
            FavoritesRealmEntity.deleteFavorites(listAllStoryCategory[row].id)
        }
        listAllStoryCategory[row].isFavorites = !listAllStoryCategory[row].isFavorites
    }
    
    func selectStory(row:Int){
        DataSingleton.Story = listAllStoryCategory[row]
    }
    
    func presentDetail() {
        self.router.presentDetail()
    }
    func checkFavorites(list: Array<FeedBookDataEntity>) {
        for i in 0..<list.count {
            for x in 0..<listIdFavorites.count {
                if listIdFavorites[x].id == list[i].id {
                    list[i].isFavorites = true
                }
            }
            for x in 0..<listDownLoad.count {
                if listDownLoad[x].id == list[i].id{
                    list[i].isDownload = true
                }
            }
        }
    }
    func getCategory() {
        self.view!.activityStart()
        allStoryCategoryGateway.getListStoryCategory(id: (DataSingleton.Category?.id)!, limit: 20, offset: offset) { (result) in
            switch result {
            case let .success(data):
                if self.offset == 0{
                    self.listAllStoryCategory = data._result
                }else{
                    self.listAllStoryCategory += data._result
                }
                
                self.checkFavorites(list: self.listAllStoryCategory)
                self.view!.activityStop()
                self.view?.refresh()
                break
            case let .failure(error):
                self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.allStoryCategoryViewController)
                self.view!.activityStop()
                break
            }
        }
    }
    
    
}
