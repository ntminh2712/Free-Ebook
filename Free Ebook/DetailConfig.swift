//
//  DetailConfig.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/11/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import UIKit
protocol DetailConfiguaration: class{
    func configuration(detailViewController: DetailViewController)
}

class DetailConfiguarationImplementation: DetailConfiguaration
{
    func configuration(detailViewController: DetailViewController)
    {
        let router =  DetailViewRouterImplementation(detailController:detailViewController)
        let allListStoryCategoryGateway =  ApiListStoryCategoryGatewayImplementation()
        let feedbookGateway = ApiFeedBookGatewayImplementation()
        let presenter = DetailPresentImplementation(view: detailViewController, router:router, allStoryCategoryGateway: allListStoryCategoryGateway, detailViewController: detailViewController,feedbookGateway:feedbookGateway)
        detailViewController.presenter = presenter
    }
}
