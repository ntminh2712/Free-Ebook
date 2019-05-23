//
//  DetailAuthorConfig.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/22/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol DetailAuthorConfiguaration: class{
    func configuration(detailAuthorViewController: DetailAuthorViewController)
}

class DetailAuthorConfiguarationImplementation: DetailAuthorConfiguaration
{
    func configuration(detailAuthorViewController: DetailAuthorViewController)
    {
        let router =  DetailAuthorViewRouterImplementation(detailAuthorController:detailAuthorViewController)
        let allListStoryCategoryGateway =  ApiListStoryCategoryGatewayImplementation()
        let feedbookGateway = ApiFeedBookGatewayImplementation()
        let presenter = DetailAuthorPresentImplementation(view: detailAuthorViewController, router:router, allStoryCategoryGateway: allListStoryCategoryGateway, detailAuthorViewController: detailAuthorViewController, feedbookGateway:feedbookGateway)
        detailAuthorViewController.presenter = presenter
    }
}
