//
//  MyLibraryViewRouter.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/24/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
import UIKit
protocol MyLibraryViewRouter: ViewRouter {
    func presentDetailStory()
}

class MyLibraryViewRouterImplementation: MyLibraryViewRouter {
    fileprivate weak var myLibraryViewController: MyLibraryViewController?
    init(myLibraryViewController: MyLibraryViewController) {
        self.myLibraryViewController = myLibraryViewController
    }
    func presentDetailStory() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenDetail")
        myLibraryViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
