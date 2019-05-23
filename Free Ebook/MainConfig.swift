//
//  MainConfig.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/15/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol MainConfiguaration: class{
    func configuration(viewController: ViewController)
}

class MainConfiguarationImplementation: MainConfiguaration
{
    func configuration(viewController: ViewController)
    {
        let router = MainViewRouterImplementation(mainController: viewController)
        let categoryGateway = ApiCategoryGatewayImplementation()
        let feedbookGateway = ApiFeedBookGatewayImplementation()
        let presenter = MainPresentImplementation(view: viewController, router: router, categoryGateway: categoryGateway, feedbookGateway:feedbookGateway, mainViewController: viewController)
        viewController.presenter = presenter
    }
}
