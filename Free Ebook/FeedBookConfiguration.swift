//
//  FeedBookConfiguration.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/8/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol FeedBookConfiguaration: class{
    func configuration(feedBookViewController: FeedBookViewController)
}

class FeedBookConfiguarationImplementation: FeedBookConfiguaration
{
    func configuration(feedBookViewController: FeedBookViewController)
    {
        let router = FeedBookViewRouterImplementation(feedBookController:feedBookViewController)
        let presenter = FeedBookPresentImplementation(view: feedBookViewController, router:router)
        feedBookViewController.presenter = presenter
    }
}
