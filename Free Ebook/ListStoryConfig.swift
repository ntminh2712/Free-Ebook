//
//  ListStoryConfig.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/11/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol ListStoryConfiguaration: class{
   func configuration(listStoryViewController: ListStoryViewController)
}

class ListStoryConfiguarationImplementation: ListStoryConfiguaration
{
    func configuration(listStoryViewController: ListStoryViewController)
    {
        let router = ListStoryViewRouterImplementation(listStoryController:listStoryViewController)
        let listStoryGateway = ApiListStoryGatewayImplementation()
        let allListStoryCategoryGateway = ApiListStoryCategoryGatewayImplementation()
        let feedbookGateway = ApiFeedBookGatewayImplementation()
        let presenter = ListStoryPresentImplementation(view: listStoryViewController, router:router, listStoryGateway: listStoryGateway, allStoryCategoryGateway: allListStoryCategoryGateway, feedbookGateway:feedbookGateway, listStoryViewController: listStoryViewController)
        listStoryViewController.presenter = presenter
    }
}
