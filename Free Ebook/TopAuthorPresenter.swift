//
//  TopAuthorPresenter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/16/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol TopAuthorView {
    func refresh()
    func activityStart()
    func activityStop()
    func checkSearchRender()
}


protocol TopAuthorPresent{
    func goToListStory()
    func viewDidLoad()
    func presentDetailAuthor()
    func presentDetailStory()
    func setData(cell:TopAuthorCollectionViewCell,row:Int)
    func search(keyword:String)
    var offset:Int {get set}
    func getTopAuthor()
}
var listTopAuthor:[AuthorEntity] = []
class TopAuthorPresentImplementation: LoadingAleart,TopAuthorPresent{
    var offset: Int = 0
    var view: TopAuthorView?
    var feedbookGateway:FeedBookGateway
    internal let router: TopAuthorViewRouter
    var topAuthorGateway:TopAuthorGateway!
    var topAuthorViewController: TopAuthorViewController
    init(view: TopAuthorView, router: TopAuthorViewRouter,topAuthorGateway:TopAuthorGateway,topAuthorViewController: TopAuthorViewController,feedbookGateway:FeedBookGateway) {
        self.view = view
        self.router = router
        self.topAuthorGateway = topAuthorGateway
        self.topAuthorViewController = topAuthorViewController
        self.feedbookGateway = feedbookGateway
    }
    func setData(cell: TopAuthorCollectionViewCell, row: Int) {
        cell.setData(item: listTopAuthor[row])
    }
    func viewDidLoad() {
        getTopAuthor()
    }
    func goToListStory() {
        self.router.presentListStory()
    }
    func presentDetailStory(){
        self.router.presentDetailStory()
    }
    func presentDetailAuthor() {
        self.router.presentDetailAuthor()
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
    
    func getTopAuthor() {
        self.view!.activityStart()
        topAuthorGateway.getTopAuthor(limit: 20, offset: offset) { (result) in
            switch result {
            case let .success(data):
                if self.offset == 0 {
                    listTopAuthor = (data.result?._data)!
                }else{
                    listTopAuthor += (data.result?._data)!
                }
                
                self.checkFavorites(list: listTopYesterday)
                self.view?.refresh()
                self.view!.activityStop()
                break
            case let .failure(error):
                self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.topAuthorViewController)
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
                    self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.topAuthorViewController)
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
