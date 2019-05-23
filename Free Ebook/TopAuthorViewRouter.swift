//
//  TopAuthorViewRouter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/16/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import UIKit
protocol TopAuthorViewRouter: ViewRouter {
    func presentListStory()
    func presentDetailAuthor()
    func presentDetailStory()
}

class TopAuthorViewRouterImplementation: TopAuthorViewRouter {
    fileprivate weak var topAuthorController: TopAuthorViewController?
    init(topAuthorController: TopAuthorViewController) {
        self.topAuthorController = topAuthorController
    }
    
    func presentDetailAuthor() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenDetailAuthor")
        topAuthorController?.navigationController?.pushViewController(vc, animated: true)
    }
    func presentDetailStory() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenDetail")
        topAuthorController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentListStory() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenListStory")
        topAuthorController?.navigationController?.pushViewController(vc, animated: true)
    }
}
