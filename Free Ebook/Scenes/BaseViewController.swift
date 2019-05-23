//
//  BaseViewController.swift
//  BaseSwift
//
//  Created by nava on 7/13/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import RxSwift
class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        initInterface()
        initData()
        initNotification()
        validate()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initInterface(){
       
        //TODO: abstract - do nothing
    }
    
    func initData(){
        //TODO: abstract - do nothing
    }
    
    
    func initNotification()
    {
        
    }
    
    func validate() {
    }
   
    
    
    

}
extension BaseViewController {
    func presentViewControllerProfile(identifier: String, main: String){
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: main, bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: identifier)
            self.present(vc, animated: true, completion: nil)
        }
    }
    func pushViewController(identifier: String,main: String){
        let storyboard: UIStoryboard = UIStoryboard(name: main, bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
//
//import UIKit
//
//class ZoomAndSnapFlowLayout: UICollectionViewFlowLayout {
//    
//    let activeDistance: CGFloat = 200
//    let zoomFactor: CGFloat = 0.3
//    
//    override init() {
//        super.init()
//        
//        scrollDirection = .horizontal
//        minimumLineSpacing = 40
//        itemSize = CGSize(width: 150, height: 150)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func prepare() {
//        guard let collectionView = collectionView else { fatalError() }
//        if #available(iOS 11.0, *) {
//            let verticalInsets = (collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom - itemSize.height) / 2
//        } else {
//            // Fallback on earlier versions
//        }
//        if #available(iOS 11.0, *) {
//            let horizontalInsets = (collectionView.frame.width - collectionView.adjustedContentInset.right - collectionView.adjustedContentInset.left - itemSize.width) / 2
//        } else {
//            // Fallback on earlier versions
//        }
//        sectionInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
//        
//        super.prepare()
//    }
//    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        guard let collectionView = collectionView else { return nil }
//        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
//        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)
//        
//        // Make the cells be zoomed when they reach the center of the screen
//        for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {
//            let distance = visibleRect.midX - attributes.center.x
//            let normalizedDistance = distance / activeDistance
//            
//            if distance.magnitude < activeDistance {
//                let zoom = 1 + zoomFactor * (1 - normalizedDistance.magnitude)
//                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
//                attributes.zIndex = Int(zoom.rounded())
//            }
//        }
//        
//        return rectAttributes
//    }
//    
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        guard let collectionView = collectionView else { return .zero }
//        
//        // Add some snapping behaviour so that the zoomed cell is always centered
//        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
//        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
//        
//        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
//        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
//        
//        for layoutAttributes in rectAttributes {
//            let itemHorizontalCenter = layoutAttributes.center.x
//            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
//                offsetAdjustment = itemHorizontalCenter - horizontalCenter
//            }
//        }
//        
//        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
//    }
//    
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        // Invalidate layout so that every cell get a chance to be zoomed when it reaches the center of the screen
//        return true
//    }
//    
//    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
//        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
//        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
//        return context
//    }
//    
//}
class LoadingAleart {
    let activity:UIActivityIndicatorView = UIActivityIndicatorView()
    func activityStart(vc:UIViewController){
    activity.center = vc.view.center
    activity.hidesWhenStopped = true
    activity.style = UIActivityIndicatorView.Style.white
    vc.view.addSubview(activity)
    activity.startAnimating()
    }
    func activityStop(){
    activity.stopAnimating()
    }
    func AlertHepper(title:String, message:String, ViewController: UIViewController) {
        let alert = UIAlertController(title: "\(title)", message: "\(message) ", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: TitleAlert.ok, style: UIAlertAction.Style.default, handler: nil))
        ViewController.present(alert, animated: true, completion: nil)
        return
        
    }
}
