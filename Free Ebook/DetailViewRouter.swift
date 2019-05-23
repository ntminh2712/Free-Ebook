//
//  DetailViewRouter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/11/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import UIKit
protocol DetailViewRouter: ViewRouter {
    func presentListStory()
    func presentDetail()
}

class DetailViewRouterImplementation: DetailViewRouter {
    fileprivate weak var detailController: DetailViewController?
    init(detailController: DetailViewController) {
        self.detailController = detailController
    }
    func presentDetail() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenDetail")
        detailController?.navigationController?.pushViewController(vc, animated: true)
    }
    func presentListStory() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenListStory") as! ListStoryViewController
        detailController?.navigationController?.pushViewController(vc, animated: true)
    }
}
