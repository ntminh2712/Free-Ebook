//
//  SlideMenuConfig.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/9/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol SlideMenuConfiguaration: class{
    func configuration(slideMenuController: SideMenuTableViewController)
}

class SlideMenuConfiguarationImplementation: SlideMenuConfiguaration
{
    func configuration(slideMenuController: SideMenuTableViewController)
    {
        let presenter = SlideMenuPresentImplementation(view: slideMenuController)
        slideMenuController.presenter = presenter
    }
}
