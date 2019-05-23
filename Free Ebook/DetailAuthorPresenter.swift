//
//  DetailAuthorPresenter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/22/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol DetailAuthorView {
    func refresh()
    func activityStart()
    func activityStop()
    func checkSearchRender()
}

protocol DetailAuthorPresent{
    func setData(cell:DetailTableViewCell)
    func viewDidLoad()
    func presentListStory()
    func search(keyword:String)
    func presentDetail()
    func getSameAuthor()
}
var listFormAuthor:[FeedBookDataEntity] = []
class DetailAuthorPresentImplementation: LoadingAleart,DetailAuthorPresent{
    var detailAuthorViewController: DetailAuthorViewController!
    var view: DetailAuthorView?
    var feedbookGateway:FeedBookGateway
    internal let router: DetailAuthorViewRouter
    var allStoryCategoryGateway: AllListStoryCategoryGateway!
    init(view: DetailAuthorView, router: DetailAuthorViewRouter, allStoryCategoryGateway: AllListStoryCategoryGateway,detailAuthorViewController: DetailAuthorViewController,feedbookGateway:FeedBookGateway) {
        self.view = view
        self.router = router
        self.allStoryCategoryGateway = allStoryCategoryGateway
        self.detailAuthorViewController = detailAuthorViewController
        self.feedbookGateway = feedbookGateway
    }
    
    func setData(cell: DetailTableViewCell) {
        cell.setData(item: DataSingleton.Story!)
    }
    func viewDidLoad() {
        getSameAuthor()
    }
    
    func presentListStory() {
        self.router.presentListStory()
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
    func getSameAuthor() {
        self.view!.activityStart()
        allStoryCategoryGateway.getSameAuthor(id: (DataSingleton.Author?.id)!, limit: 20) { (result) in
            switch result {
            case let .success(data):
                listFormAuthor = data._result
                self.checkFavorites(list: listFormAuthor)
                self.view!.activityStop()
                self.view?.refresh()
                break
            case let .failure(error):
                self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.detailAuthorViewController)
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
                    self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.detailAuthorViewController)
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
}
