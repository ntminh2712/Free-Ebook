//
//  LibraryConfig.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/24/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol LibraryConfiguaration: class{
    func configuration(libraryViewController: LibraryViewController)
}

class LibraryConfiguarationImplementation: LibraryConfiguaration
{
    func configuration(libraryViewController: LibraryViewController)
    {
        let presenter = LibraryPresentImplementation(view: libraryViewController, libraryViewController: libraryViewController)
        libraryViewController.presenter = presenter
    }
}
