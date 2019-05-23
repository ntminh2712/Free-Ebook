//
//  ListStoryCategoryPresenter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/24/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol ListStoryCategoryView {
    func refresh()
    func activityStart()
    func activityStop()
    func checkSearchRender()
}


protocol ListStoryCategoryPresent{
    func presentDetailStory()
    func search(keyword:String)
}
class ListStoryCategoryPresentImplementation: LoadingAleart,ListStoryCategoryPresent{
    
    
    var view: ListStoryCategoryView?
    var feedbookGateway:FeedBookGateway
    internal let router: ListStoryCategoryViewRouter
    var listStoryCategoryViewController: ListStoryCategoryViewController
    init(view: ListStoryCategoryView, router: ListStoryCategoryViewRouter,listStoryCategoryViewController: ListStoryCategoryViewController,feedbookGateway:FeedBookGateway) {
        self.view = view
        self.router = router
        self.listStoryCategoryViewController = listStoryCategoryViewController
        self.feedbookGateway = feedbookGateway
    }
    func presentDetailStory(){
        self.router.presentDetailStory()
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
                    self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.listStoryCategoryViewController)
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
