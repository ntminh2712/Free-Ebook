
//
//  MyLibraryConfig.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/24/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol MyLibraryConfiguaration: class{
    func configuration(myLibraryViewController: MyLibraryViewController)
}

class MyLibraryConfiguarationImplementation: MyLibraryConfiguaration
{
    func configuration(myLibraryViewController: MyLibraryViewController)
    {
        let router = MyLibraryViewRouterImplementation(myLibraryViewController:myLibraryViewController)
        let feedbookGateway = ApiFeedBookGatewayImplementation()
        let presenter = MyLibraryPresentImplementation(view: myLibraryViewController, router: router, myLibraryViewController: myLibraryViewController, feedbookGateway: feedbookGateway)
        myLibraryViewController.presenter = presenter
    }
}
