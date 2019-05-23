//
//  FeedBookPresent.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/8/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation

protocol FeedBookView: class {
    func refresh()
}


protocol FeedBookPresent: class{
    func viewAllTopYesterday()
    func viewAllRecommend()
    func viewAllNewRelease()
    func goListStory()
    func goToDetail()
    func goToTopAuthor()
    
}

class FeedBookPresentImplementation: FeedBookPresent
{
    fileprivate weak var view: FeedBookView?
    internal let router: FeedBookViewRouter
    
    init(view: FeedBookView, router: FeedBookViewRouter) {
        self.view = view
        self.router = router
    }
   
    
    func goListStory() {
        self.router.presentListStory()
    }
    
    func viewAllRecommend() {
        self.router.presentListStory()
    }
    func viewAllNewRelease() {
        self.router.presentListStory()
    }
    func viewAllTopYesterday() {
        self.router.presentListStory()
    }
    func goToDetail() {
        self.router.presentDetail()
    }
    func goToTopAuthor(){
        self.router.presentTopAuthor()
    }
    
    
}
