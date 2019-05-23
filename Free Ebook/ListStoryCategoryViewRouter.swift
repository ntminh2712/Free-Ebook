//
//  ListStoryCategoryViewRouter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/24/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import UIKit
protocol ListStoryCategoryViewRouter: ViewRouter {
    func presentDetailStory()
}

class ListStoryCategoryViewRouterImplementation: ListStoryCategoryViewRouter {
    fileprivate weak var listStoryCategoryController: ListStoryCategoryViewController?
    init(listStoryCategoryController: ListStoryCategoryViewController) {
        self.listStoryCategoryController = listStoryCategoryController
    }
    func presentDetailStory() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenDetail")
        listStoryCategoryController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
