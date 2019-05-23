//
//  ListStoryPresenter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/11/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol ListStoryView {
    func setNameTag(name: String)
    func refresh()
    func activityStart()
    func activityStop()
    func checkSearchRender()
}


protocol ListStoryPresent {
    func viewDidLoad()
    func setData(cell: TopYesterdayCollectionViewCell, row:Int)
    var numberOfList:Int {get}
    func presentDetail()
    func selectStory(row:Int)
    func handlerFavorites(row:Int)
    func search(keyword:String)
    var offset:Int {get set}
    func setCategory()
}
var listStory:[FeedBookDataEntity] = []
class ListStoryPresentImplementation:LoadingAleart, ListStoryPresent {
    var offset:Int = 0
    var view: ListStoryView?
    var listStoryGateway: ListStoryGateway?
    internal let router: ListStoryViewRouter
    var feedbookGateway:FeedBookGateway
    var listStoryViewController: ListStoryViewController!
    var allStoryCategoryGateway: AllListStoryCategoryGateway!
    var isSkeleton: Bool = false
    init(view: ListStoryView, router: ListStoryViewRouter,listStoryGateway: ListStoryGateway,allStoryCategoryGateway: AllListStoryCategoryGateway!,feedbookGateway:FeedBookGateway,listStoryViewController: ListStoryViewController) {
        self.view = view
        self.router = router
        self.listStoryGateway = listStoryGateway
        self.allStoryCategoryGateway = allStoryCategoryGateway!
        self.feedbookGateway = feedbookGateway
        self.listStoryViewController = listStoryViewController
    }
    func viewDidLoad() {
        setCategory()
    }
    
    var numberOfList: Int{
        return listStory.count
    }
    
    func setData(cell: TopYesterdayCollectionViewCell, row: Int) {
        cell.setData(data: listStory[row])
        
    }
    func handlerFavorites(row:Int) {
        if !listStory[row].isFavorites {
            FavoritesRealmEntity.addFavorites(listStory[row])
        }else {
            FavoritesRealmEntity.deleteFavorites(listStory[row].id)
        }
        listStory[row].isFavorites = !listStory[row].isFavorites
        self.view?.refresh()
    }
    func selectStory(row:Int) {
        DataSingleton.Story = listStory[row]
    }
    
    func setCategory(){
        switch DataSingleton.ViewCategory {
        case Category.NewRelease:
            getNewRelease(limit:20)
            self.view?.setNameTag(name: "New Release")
            break
        case Category.TopMonth:
            getTopMonth(limit: 20)
            self.view?.setNameTag(name: "Top Month")
            break
        case Category.ViewAllRecommend:
            getRecommend(limit:20)
            self.view?.setNameTag(name: "All Recommend")
            break
        case Category.ViewAllTopYesterday:
            getTopYesterday(limit:20)
            self.view?.setNameTag(name: "All Top Yesterday")
            break
        case Category.ViewAllNewRelease:
            getNewRelease(limit:20)
            self.view?.setNameTag(name: "All New Release")
            break
        case Category.SubCategory:
            getCategory(limit: 20)
            self.view?.setNameTag(name: (DataSingleton.SubCategory)!)
            break
        case Category.ViewAllFormAuthor:
            getFormAuthor(limit:20)
            self.view?.setNameTag(name: "Form Author")
        case Category.ViewAllSameAuthor:
            getFormAuthor(limit:100)
            self.view?.setNameTag(name: "All Same Author")
        case Category.ViewAllSameCategory:
            getCategory(limit: 100)
            self.view?.setNameTag(name: "All Same Category")
        default:
            break
        }
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
    
    func presentDetail() {
        self.router.presentDetail()
    }
    
    func getTopMonth(limit:Int) {
        self.view!.activityStart()
        listStoryGateway?.getTopMonth(limit: limit, offset: offset, completetionHandler: { (result) in
            switch result {
            case let .success(data):
                if self.offset == 0 {
                    listStory = (data.result?.data)!
                }else {
                    listStory += (data.result?.data)!
                }
                self.checkFavorites(list: listStory)
                self.view?.refresh()
                self.view!.activityStop()
                break
            case let .failure(error):
                self.view?.refresh()
                self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.listStoryViewController)
                self.view!.activityStop()
                break
            }
        })
    }
    func getNewRelease(limit:Int) {
        self.view!.activityStart()
        listStoryGateway?.getNewRelease(limit: limit, offset: offset, completetionHandler: { (result) in
            switch result {
            case let .success(data):
                if self.offset == 0 {
                    listStory = (data.result?.data)!
                }else {
                    listStory += (data.result?.data)!
                }
                self.checkFavorites(list: listStory)
                self.view?.refresh()
                self.view!.activityStop()
                break
            case let .failure(error):
                self.view?.refresh()
                self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.listStoryViewController)
                self.view!.activityStop()
                break
            }
        })
    }
    
    func getCategory(limit:Int) {
        self.view!.activityStart()
        var id :Int
        if DataSingleton.ViewCategory == Category.ViewAllSameCategory {
            id = (DataSingleton.Story?.category?.id)!
        }else {
            id  = (DataSingleton.Category?.id)!
        }
        allStoryCategoryGateway.getListStoryCategory(id: id, limit: limit, offset: offset) { (result) in
            switch result {
            case let .success(data):
                if self.offset == 0 {
                    listStory = data._result
                }else {
                    listStory += data._result
                }
                self.checkFavorites(list: listStory)
                self.view?.refresh()
                self.view!.activityStop()
                break
            case let .failure(error):
                self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.listStoryViewController)
                self.view!.activityStop()
                break
            }
        }
    }
    func getRecommend(limit:Int) {
        self.view!.activityStart()
        feedbookGateway.getRecommend(limit: limit, offset: offset) { (result) in
            switch result {
            case let .success(data):
                if self.offset == 0 {
                    listStory = (data.result?.data)!
                }else {
                    listStory += (data.result?.data)!
                }
                self.checkFavorites(list: listStory)
                self.view?.refresh()
                self.view!.activityStop()
                break
            case let .failure(error):
                self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.listStoryViewController)
                self.view!.activityStop()
                break
            }
        }
    }
    func getTopYesterday(limit:Int) {
        self.view!.activityStart()
        feedbookGateway.getTopYesterday(limit: limit, offset: offset) { (result) in
            switch result {
            case let .success(data):
                if self.offset == 0 {
                    listStory = (data.result?.data)!
                }else {
                    listStory += (data.result?.data)!
                }
                self.checkFavorites(list: listStory)
                self.view?.refresh()
                self.view!.activityStop()
                break
            case let .failure(error):
                self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.listStoryViewController)
                self.view!.activityStop()
                break
            }
        }
    }
    func search(keyword:String){
        if keyword.count >= 2{
            feedbookGateway.search(keyword: keyword) { (result) in
                switch result {
                case let .success(data):
                    if data.code == 0 {
                        if data.result?.data.count != 0 {
                            listSearch = (data.result?.data)!
                        }
                    }
                    self.view!.activityStop()
                    self.view!.checkSearchRender()
                    self.view!.refresh()
                    break
                case let .failure(error):
                    self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.listStoryViewController)
                    self.view!.activityStop()
                    break
                }
            }
        }else {
            listSearch.removeAll()
            self.view!.checkSearchRender()
            self.view!.refresh()
        }
    }
    func getFormAuthor(limit:Int) {
        var id :Int
        if DataSingleton.ViewCategory == Category.ViewAllSameAuthor {
            id = (DataSingleton.Story?.authors[0].id)!
        }else {
            id  = (DataSingleton.Author?.id)!
        }
        allStoryCategoryGateway.getSameAuthor(id: id, limit: limit) { (result) in
            switch result {
            case let .success(data):
                if data.code == 0 {
                    if data.result?.data.count != 0 {
                        listStory = (data._result)
                    }
                }
                self.checkFavorites(list: listStory)
                self.view?.refresh()
                self.view!.activityStop()
                
                break
            case let .failure(error):
                self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.listStoryViewController)
                self.view!.activityStop()
                break
            }
        }
    }
    
}
