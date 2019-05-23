//
//  MyLibraryPresnter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/24/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol MyLibraryView {
    func refresh()
    func activityStart()
    func activityStop()
    func checkSearchRender()
}


protocol MyLibraryPresent{
    func presentDetailStory()
    func search(keyword:String)
}
class MyLibraryPresentImplementation: LoadingAleart,MyLibraryPresent{
    
    
    var view: MyLibraryView?
    var feedbookGateway:FeedBookGateway
    internal let router: MyLibraryViewRouter
    var myLibraryViewController: MyLibraryViewController
    init(view: MyLibraryView, router: MyLibraryViewRouter,myLibraryViewController: MyLibraryViewController,feedbookGateway:FeedBookGateway) {
        self.view = view
        self.router = router
        self.myLibraryViewController = myLibraryViewController
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
                    self.AlertHepper(title: TitleAlert.error, message: error.localizedDescription, ViewController: self.myLibraryViewController)
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
