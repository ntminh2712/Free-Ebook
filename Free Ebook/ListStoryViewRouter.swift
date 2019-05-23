//
//  ListStoryViewRouter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/11/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import UIKit
protocol ListStoryViewRouter: ViewRouter {
    func presentDetail()
}

class ListStoryViewRouterImplementation: ListStoryViewRouter {
    fileprivate weak var listStoryController: ListStoryViewController?
    init(listStoryController: ListStoryViewController) {
        self.listStoryController = listStoryController
    }
    func presentDetail() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenDetail")
        listStoryController?.navigationController?.pushViewController(vc, animated: true)
    }
}
