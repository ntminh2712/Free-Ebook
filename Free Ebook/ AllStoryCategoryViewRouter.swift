//
//   AllStoryCategoryViewRouter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/17/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import UIKit
protocol AllStoryCategoryViewRouter: ViewRouter {
    func presentDetail()
}

class AllStoryCategoryViewRouterImplementation: AllStoryCategoryViewRouter {
    fileprivate weak var allStoryCategoryyController: AllStoryCategoryViewController?
    init(allStoryCategoryyController: AllStoryCategoryViewController) {
        self.allStoryCategoryyController = allStoryCategoryyController
    }
    func presentDetail() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenDetail")
        allStoryCategoryyController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
