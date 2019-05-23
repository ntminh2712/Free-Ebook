//
//  FeedBookViewRouter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/8/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import UIKit
protocol FeedBookViewRouter: ViewRouter {
    func presentListStory()
    func presentDetail()
    func viewAll()
    func presentTopAuthor()
}

class FeedBookViewRouterImplementation: FeedBookViewRouter {
    fileprivate weak var feedBookController: FeedBookViewController?
    init(feedBookController: FeedBookViewController) {
        self.feedBookController = feedBookController
    }
    
    func presentListStory() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenListStory") as! ListStoryViewController
        let config: ListStoryConfiguaration = ListStoryConfiguarationImplementation()
        feedBookController?.navigationController?.pushViewController(vc, animated: true)
    }
    func presentDetail() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenDetail")
        feedBookController?.navigationController?.pushViewController(vc, animated: true)
    }
    func viewAll() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenListStory")
        feedBookController?.navigationController?.pushViewController(vc, animated: true)
    }
    func presentTopAuthor() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenTopAuthor")
        feedBookController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
