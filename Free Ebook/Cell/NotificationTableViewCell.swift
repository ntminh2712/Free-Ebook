//
//  NotificationTableViewCell.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 2/12/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit
import UserNotifications
class NotificationTableViewCell: UITableViewCell,UNUserNotificationCenterDelegate {
    @IBOutlet weak var lblNameMenu: UILabel!
    @IBOutlet weak var imgMenu: UIImageView!
    var isNotification = UIApplication.shared.isRegisteredForRemoteNotifications
    override func awakeFromNib() {
        super.awakeFromNib()
        lblNameMenu.textColor = UIColor.black
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setCurrentNotification() {
        isNotification = !isNotification
        if !isNotification {
            imgMenu.image = UIImage(named: "notification_off")
            UIApplication.shared.unregisterForRemoteNotifications()
        }else {
            imgMenu.image = UIImage(named: "notification_on")
            if #available(iOS 10.0, *) {
                // For iOS 10.0 +
                let center  = UNUserNotificationCenter.current()
                center.delegate = self
                center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                    if error == nil{
                        DispatchQueue.main.async(execute: {
                            UIApplication.shared.registerForRemoteNotifications()
                        })
                    }
                }
            }else{
                
                let settings = UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(settings)
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    @IBAction func btnSelectNotification(_ sender: Any) {
        setCurrentNotification()
        
    }
}
