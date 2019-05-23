//
//  DownloadConfig.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/25/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import Foundation
protocol DownloadConfiguaration: class{
    func configuration(downloadViewController: DownloadViewController)
}

class DownloadConfiguarationImplementation: DownloadConfiguaration
{
    func configuration(downloadViewController: DownloadViewController)
    {
        let presenter = DownloadPresentImplementation(view: downloadViewController, downloadViewController: downloadViewController)
        downloadViewController.presenter = presenter
    }
}
