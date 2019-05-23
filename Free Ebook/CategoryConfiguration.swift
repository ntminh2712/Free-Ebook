//
//  CategoryConfiguration.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/8/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol CategoryConfiguaration: class{
    func configuration(categoryViewController: CategoryViewController)
}

class CategoryConfiguarationImplementation: CategoryConfiguaration
{
    func configuration(categoryViewController: CategoryViewController)
    {
        let router = CategoryViewRouterImplementation(categoryController:categoryViewController)
        let presenter = CategoryPresentImplementation(view: categoryViewController, router:router)
        categoryViewController.presenter = presenter
    }
}
