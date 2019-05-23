//
//  MainPresenter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/15/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol MainView {
    func activityStart()
    func activityStop()
    
}


protocol MainPresent{
    func viewDidLoad(vc:FeedBookViewController)
    func search(keyword:String)
    func checkTbRender()
    func reloadList()
}

var listCategory:[StoryEntity] = []
var listRelease:[FeedBookDataEntity] = []
var listTopYesterday:[FeedBookDataEntity] = []
var listRecommend:[FeedBookDataEntity] = []
var listSearch:[FeedBookDataEntity] = []

class MainPresentImplementation: LoadingAleart, MainPresent{
    var view: MainView?
    var offset:Int = 0
    internal let router: MainViewRouter
    var categoryGateway:CategoryGateway
    var feedbookGateway:FeedBookGateway
    var mainViewController:ViewController
    var feedBookController:FeedBookViewController!
    var isCompleteGetCategory: Bool = false
    {
        didSet{
            self.checkComplete()
        }
    }
    var isCompleteTopYesterday: Bool = false
    {
        didSet{
            self.checkComplete()
        }
    }
    var isCompleteNewRelease: Bool = false
    {
        didSet{
            self.checkComplete()
        }
    }
    init(view: MainView, router: MainViewRouter, categoryGateway: CategoryGateway, feedbookGateway:FeedBookGateway,mainViewController:ViewController) {
        self.view = view
        self.router = router
        self.categoryGateway = categoryGateway
        self.feedbookGateway = feedbookGateway
        self.mainViewController = mainViewController
    }
    
    func reloadList(){
        self.checkFavorites(list: listRecommend)
        self.checkFavorites(list: listRelease)
        self.checkFavorites(list: listTopYesterday)
    }
    
    func viewDidLoad(vc:FeedBookViewController) {
        self.feedBookController = vc
        getCategory()
        getTopYesterday()
        getNewRelease()
        getRecommend()
    }
    
    func checkTbRender() {
        feedBookController.checkSearchRender()
    }
    
    func checkFavorites(list: Array<FeedBookDataEntity>) {
        for i in 0..<list.count {
            for x in 0..<listIdFavorites.count {
                if listIdFavorites[x].id == list[i].id {
                    list[i].isFavorites = true
                    break
                }else {
                    list[i].isFavorites = false
                }
            }
            for x in 0..<listDownLoad.count {
                if listDownLoad[x].id == list[i].id{
                    list[i].isDownload = true
                    break
                }else {
                    list[i].isDownload = false
                }
            }
        }
    }
    func getCategory() {
        self.view!.activityStart()
        categoryGateway.getCategory { (result) in
            switch result {
            case let .success(data):
                listCategory = data.result
                self.isCompleteGetCategory = true
                self.view!.activityStop()
                break
            case let .failure(error):
                self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.mainViewController)
                self.isCompleteGetCategory = true
                self.view!.activityStop()
                break
            }
        }
    }
    func getRecommend() {
        self.view!.activityStart()
        feedbookGateway.getRecommend(limit: 20, offset: offset) { (result) in
            switch result {
            case let .success(data):
                listRecommend = (data.result?.data)!
                self.checkFavorites(list: listRecommend)
                self.isCompleteTopYesterday = true
                self.view!.activityStop()
                break
            case let .failure(error):
                self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.mainViewController)
                self.isCompleteTopYesterday = true
                self.view!.activityStop()
                break
            }
        }
    }
    func getTopYesterday() {
        self.view!.activityStart()
        feedbookGateway.getTopYesterday(limit: 20, offset: offset) { (result) in
            switch result {
            case let .success(data):
                listTopYesterday = (data.result?.data)!
                DataSingleton.Story = listTopYesterday[0]
                self.checkFavorites(list: listTopYesterday)
                self.isCompleteTopYesterday = true
                self.view!.activityStop()
                break
            case let .failure(error):
                self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.mainViewController)
                self.isCompleteTopYesterday = true
                self.view!.activityStop()
                break
            }
        }
    }
    
    func getNewRelease() {
        self.view!.activityStart()
        feedbookGateway.getNewRelease(limit: 20, offset: offset) { (result) in
            switch result {
            case let .success(data):
                listRelease = (data.result?.data)!
                self.checkFavorites(list: listRelease)
                self.isCompleteNewRelease = true
                self.view!.activityStop()
                break
            case let .failure(error):
                self.isCompleteNewRelease = true
                self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.mainViewController)
                self.view!.activityStop()
                break
            }
        }
    }
    func search(keyword:String){
        
        if keyword.count >= 2{
            self.view?.activityStart()
            feedbookGateway.search(keyword: keyword) { (result) in
                switch result {
                case let .success(data):
                    if data.code == 0 {
                        if data.result?.data.count != 0 {
                            listSearch = (data.result?.data)!
                        }
                    }
                    self.view!.activityStop()
                    self.feedBookController.checkSearchRender()
                    self.feedBookController.refresh()
                    break
                case let .failure(error):
                    self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.mainViewController)
                    self.view!.activityStop()
                    break
                }
            }
        }else {
            listSearch.removeAll()
            self.feedBookController.checkSearchRender()
            self.feedBookController.refresh()
        }
    }
    
    fileprivate func checkComplete()
    {
        if self.isCompleteTopYesterday && self.isCompleteNewRelease && self.isCompleteGetCategory
        {
            self.feedBookController.refresh()
        }
    }
    
}
