//
//  ViewController.swift
//  Free Ebook
//
//  Created by MinhNT-Mac on 1/7/19.
//  Copyright © 2019 MinhNT-Mac. All rights reserved.
//

import UIKit
import Parchment
var listIdFavorites:Array<FavoritesRealmEntity> = []
class ViewController: UIViewController , MainView{
    
    var presenter:MainPresent!
    var mainConfig: MainConfiguaration = MainConfiguarationImplementation()
    let activity:UIActivityIndicatorView = UIActivityIndicatorView()
    var vc:[UIViewController] = []
    var cv1: FeedBookViewController?
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var heightCancel: NSLayoutConstraint!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viewBound: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cv1 = storyboard?.instantiateViewController(withIdentifier: "feedBookViewController") as? FeedBookViewController
        heightCancel.constant = 0
        mainConfig.configuration(viewController: self)
        setupPagemenu()
        setupViewSearch()
        initNotification()
        
        presenter.viewDidLoad(vc: cv1!)
    }
    override func viewWillAppear(_ animated: Bool) {
        listIdFavorites = FavoritesRealmEntity.getListFavorites()!
        listDownLoad = StoryRealmEntity.getAllStoryDownload()!
        presenter.reloadList()
        heightCancel.constant = 0
        txtSearch.text = ""
        txtSearch.endEditing(true)
        if cv1?.heghtTbRender != nil {
            cv1?.heghtTbRender.constant = 0
            cv1?.viewWillAppear(true)
        }
        
    }
    
    @objc func showViewHome() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenHome")
        self.navigationController?.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func showViewMyLibrary() {
        dismiss(animated: true, completion: nil)
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "screenMyLibrary")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func activityStart(){
        activity.center = self.view.center
        activity.hidesWhenStopped = true
        activity.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activity)
        activity.startAnimating()
    }
    func activityStop(){
        activity.stopAnimating()
    }
    
    @IBAction func searchEdidChange(_ sender: Any) {
        if  (txtSearch.text?.count)! <= 2 {
            listSearch.removeAll()
            cv1?.heghtTbRender.constant = 0
            activityStop()
            cv1?.checkSearchRender()
            return
        }
        presenter.search(keyword: txtSearch.text!)
        
    }
    func initNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showViewHome), name: notificationName.home.notification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showViewMyLibrary), name: notificationName.myLibrary.notification, object: nil)
    }
    
    
    
    func setupPagemenu() {
        cv1?.title = "Feed Book"
        let cv2 = storyboard?.instantiateViewController(withIdentifier: "categoryViewController") as? CategoryViewController
        cv2?.title = "Category"
        vc.append(cv1!)
        vc.append(cv2!)
        let pagingView = FixedPagingViewController(viewControllers: vc)
        addChild(pagingView)
        view.addSubview(pagingView.view)
        view.constrainToEdges(pagingView.view)
        pagingView.didMove(toParent: self)
        
        let pagingViewController = PagingViewController<PagingIndexItem>()
        pagingViewController.dataSource = self
        pagingView.dataSource = self
        pagingViewController.select(index: 0)
    }
    func setupViewSearch() {
        viewSearch.setLayoutViewSearch()
    }
    @objc func keyboardWillShow(notification: Notification) {
        showCancel()
    }
    
    @objc func keyboardWillHide(notification: Notification)
    {
        if txtSearch.text == "" {
            listSearch.removeAll()
            heightCancel.constant = 0
            txtSearch.text = ""
            txtSearch.endEditing(true)
            cv1?.checkSearchRender()
        }else {
            txtSearch.endEditing(true)
        }
        
    }
    @IBAction func hidesearch(_ sender: Any) {
        heightCancel.constant = 0
        txtSearch.text = ""
        txtSearch.endEditing(true)
        listSearch.removeAll()
        cv1?.checkSearchRender()
    }
    func showCancel() {
        heightCancel.constant = 50
    }
    @IBAction func hideKeyboard(_ sender: Any) {
        listSearch.removeAll()
        cv1?.checkSearchRender()
        txtSearch.endEditing(true)
    }
    
    
    
}
extension ViewController: PagingViewControllerDataSource {
    func numberOfViewControllers<T>(in pagingViewController: PagingViewController<T>) -> Int {
        return 2
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
        return PagingIndexItem(index: index, title: self.vc[index].title!) as! T
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
        return self.vc[index]
    }
    
    
}
