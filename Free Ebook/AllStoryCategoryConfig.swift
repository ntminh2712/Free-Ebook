//
//  AllStoryCategoryConfig.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/17/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol AllStoryCategoryConfiguaration: class{
    func configuration(allStoryCategoryViewController: AllStoryCategoryViewController)
}

class AllStoryCategoryConfiguarationImplementation: AllStoryCategoryConfiguaration
{
    func configuration(allStoryCategoryViewController: AllStoryCategoryViewController)
    {
        let router = AllStoryCategoryViewRouterImplementation(allStoryCategoryyController:allStoryCategoryViewController)
        let allListStoryCategoryGateway = ApiListStoryCategoryGatewayImplementation()
        let presenter = AllStoryCategoryPresentImplementation(view: allStoryCategoryViewController, router:router, allStoryCategoryGateway: allListStoryCategoryGateway, allStoryCategoryViewController: allStoryCategoryViewController)
        allStoryCategoryViewController.presenter = presenter
    }
}
