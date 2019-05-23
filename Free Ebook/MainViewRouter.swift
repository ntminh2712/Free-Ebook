//
//  MainViewRouter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/15/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import UIKit
protocol MainViewRouter: ViewRouter {
    func presentDetail()
}

class MainViewRouterImplementation: MainViewRouter {
    fileprivate weak var mainController: ViewController?
    
    init(mainController: ViewController) {
        self.mainController = mainController
    }
    
    func presentListStory(category:Int) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenListStory") as! ListStoryViewController
        let config:ListStoryConfiguaration = ListStoryConfiguarationImplementation()
        mainController?.navigationController?.pushViewController(vc, animated: true)
    }
    func presentDetail() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenDetail") as! DetailViewController
        mainController?.navigationController?.pushViewController(vc, animated: true)
        
    }
}
