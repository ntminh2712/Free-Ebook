//
//  TopAuthorConfig.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/16/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol TopAuthorConfiguaration: class{
    func configuration(topAuthorViewController: TopAuthorViewController)
}

class TopAuthorConfiguarationImplementation: TopAuthorConfiguaration
{
    func configuration(topAuthorViewController: TopAuthorViewController)
    {
        let router = TopAuthorViewRouterImplementation(topAuthorController:topAuthorViewController)
        let topAuthorGateway = ApiTopAuthorGatewayImplementation()
        let feedbookGateway = ApiFeedBookGatewayImplementation()
        let presenter = TopAuthorPresentImplementation(view: topAuthorViewController, router:router, topAuthorGateway: topAuthorGateway, topAuthorViewController: topAuthorViewController, feedbookGateway: feedbookGateway)
        topAuthorViewController.presenter = presenter
    }
}
