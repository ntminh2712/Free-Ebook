//
//  CategoryViewRouter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/8/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import UIKit
protocol CategoryViewRouter: ViewRouter {
    func presentListStory()
    func presentListStoryCategory()
}

class CategoryViewRouterImplementation: CategoryViewRouter {
    fileprivate weak var categoryController: CategoryViewController?
    init(categoryController: CategoryViewController) {
        self.categoryController = categoryController
    }
    
    func presentListStory() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenListStory") as! ListStoryViewController
        let config: ListStoryConfiguaration = ListStoryConfiguarationImplementation()
        categoryController?.navigationController?.pushViewController(vc, animated: true)
    }
    func presentListStoryCategory() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenListStoryCategory") as! ListStoryCategoryViewController
        categoryController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
