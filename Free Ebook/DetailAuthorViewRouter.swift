//
//  DetailAuthorViewRouter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/22/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import UIKit
protocol DetailAuthorViewRouter: ViewRouter {
        func presentListStory()
        func presentDetail()
}

class DetailAuthorViewRouterImplementation: DetailAuthorViewRouter {
    fileprivate weak var detailAuthorController: DetailAuthorViewController?
    init(detailAuthorController: DetailAuthorViewController) {
        self.detailAuthorController = detailAuthorController
    }
        func presentListStory() {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenListStory") as! ListStoryViewController
            detailAuthorController?.navigationController?.pushViewController(vc, animated: true)
        }
    func presentDetail() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenDetail") as! DetailViewController
        detailAuthorController?.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
