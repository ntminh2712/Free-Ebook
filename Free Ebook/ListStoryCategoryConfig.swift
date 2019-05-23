//
//  ListStoryCategoryConfig.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/24/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol ListStoryCategoryConfiguaration: class{
    func configuration(listStoryCategoryViewController: ListStoryCategoryViewController)
}

class ListStoryCategoryConfiguarationImplementation: ListStoryCategoryConfiguaration
{
    func configuration(listStoryCategoryViewController: ListStoryCategoryViewController)
    {
        let router = ListStoryCategoryViewRouterImplementation(listStoryCategoryController:listStoryCategoryViewController)
        let feedbookGateway = ApiFeedBookGatewayImplementation()
        let presenter = ListStoryCategoryPresentImplementation(view: listStoryCategoryViewController, router: router, listStoryCategoryViewController: listStoryCategoryViewController, feedbookGateway: feedbookGateway)
        listStoryCategoryViewController.presenter = presenter
    }
}
