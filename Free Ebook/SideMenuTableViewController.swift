//
//  SideMenuTableViewController.swift
//  SideMenu
//
//  Created by Jon Kent on 4/5/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import SideMenu
import Social
import MessageUI
import UserNotifications
protocol SlideMenuView {
    func refreshData()
}
class SideMenuTableViewController: UITableViewController, SlideMenuView,UNUserNotificationCenterDelegate , MFMailComposeViewControllerDelegate{
    var presenter: SlideMenuPresent!
    var configuration: SlideMenuConfiguaration = SlideMenuConfiguarationImplementation()
    var isNotification = UIApplication.shared.isRegisteredForRemoteNotifications
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    @IBOutlet var tbMenu: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configuration.configuration(slideMenuController: self)
        tbMenu.delegate = self
        tbMenu.dataSource = self
        tbMenu.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "menuTableViewCell")
        tbMenu.register(UINib(nibName: "AvatarTableViewCell", bundle: nil), forCellReuseIdentifier: "avatarTableViewCell")
        tbMenu.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "notificationTableViewCell")
        tbMenu.delegate = self
        tbMenu.dataSource = self
    }
    func refreshData() {
        tbMenu.reloadData()
    }
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["you@yoursite.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tbMenu.dequeueReusableCell(withIdentifier: "avatarTableViewCell") as! AvatarTableViewCell
            return cell
        }else if indexPath.row != 7{
            let cell = tbMenu.dequeueReusableCell(withIdentifier: "menuTableViewCell") as! MenuTableViewCell
            presenter.setData(cell: cell, row: (indexPath.row - 1))
            cell.Selected = { [weak self] in
                self?.presenter.cellSelect( row: (indexPath.row - 1))
                switch indexPath.row {
                case 2:
                    NotificationCenter.default.post(name: notificationName.myLibrary.notification, object: nil)
                    break
                case 3:
                    DataSingleton.ViewCategory = Category.ViewAllRecommend
                    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenListStory") as! ListStoryViewController
                    self?.navigationController?.pushViewController(vc, animated: true)
                    break
                case 5:
                    let activityVC = UIActivityViewController(activityItems: [SocialNetWorking.linkDownLoadApp], applicationActivities: nil)
                    activityVC.popoverPresentationController?.sourceView = self?.view
                    self?.present(activityVC, animated: true, completion: nil)
                    break
                case 6:
                    self?.sendEmail()
                default:
                    break
                }
            }
            return cell
        }else {
            let cell = tbMenu.dequeueReusableCell(withIdentifier: "notificationTableViewCell") as! NotificationTableViewCell
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 140
            
        }
        return 50
        
    }
}

