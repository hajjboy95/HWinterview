//
//  DetailViewController.swift
//
//  Created by Ismail El-habbash on 4/8/16.
//  Copyright © 2016 Ismail El-Habbash. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var propertyName: UILabel!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var contentView: UIView!
    
    
    var propertyId:String!
    var cityInfo:City?
    var currentPropertyDetails:PropertyDetails?
    var propertyImages:[Image]?
    var cache:NSCache!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        self.title = cityInfo?.cityName
        cache = NSCache()
        
        
        propertyApi.getPropertyData(.SpecificProperty, url:"/properties/\(propertyId)", completion:{ (city, error) -> Void in
            
            if error != nil {
                print("ERROR HAS OCCURED \(error)")
            } else {
                self.currentPropertyDetails =  JsonParser.packageSpecificProperty(city)
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.propertyImages = (self.currentPropertyDetails?.images)!
                    self.updateUI()
                    self.collectionView.reloadData()
                    
                })
                
                
            }
            
        })
        
        
    }
    
    
    func updateUI() {
        
        self.propertyName.text = (cityInfo?.cityName ?? "Unknown City") +  " , " + (cityInfo?.country ?? "Unknown country")
        self.addressTextView.text = currentPropertyDetails?.address
        self.descriptionTextView.text = currentPropertyDetails?.propertyDescription
        
        
//        self.updateScrollViewSize()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func updateScrollViewSize() {
        var contentSize = CGRectZero
        
        for view in self.scrollView.subviews {
            contentSize = CGRectUnion(contentSize, view.frame)
            // checks the subviews of the views and gets the union rect
            if view.subviews.count > 0 {
                for i in view.subviews {
                    contentSize = CGRectUnion(contentSize, i.frame)
                    
                }
            }
        }
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: contentSize.height+50)
        
    }
}

extension DetailViewController : UICollectionViewDataSource
{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("self.propertyImage.count = " , self.propertyImages?.count)
        return self.propertyImages?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! DetailCollectionViewCell
        let img = self.propertyImages![indexPath.row]
        
        let imgUrl = img.fullUrl()
        
        
        
        if let image  = (self.cache.objectForKey(imgUrl) as? UIImage){
            cell.propertyImageView.image = image
            
        } else
        {
            cell.propertyImageView.image = UIImage(named: "placeholder")
            propertyApi.downloadPropertyImage(imgUrl , completion: {  (image, error) -> Void in
                
                if error != nil {
                    print(error)
                } else {
                    let updateCell  = collectionView.cellForItemAtIndexPath(indexPath) as? DetailCollectionViewCell
                    // make ui update on main thread
                    dispatch_async(dispatch_get_main_queue(), {
                        updateCell?.propertyImageView?.image = image
                    })

                    self.cache.setObject(image!, forKey: imgUrl)
                }
            })
        }
        
        return cell
    }
}

extension DetailViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let collectionViewHeight = self.collectionView.frame.size.height
        let collectionViewWidth  = self.collectionView.frame.size.width
        
        
        let imageHeight = collectionViewHeight - collectionViewHeight/10
        let imageWidth = collectionViewWidth - collectionViewWidth/10
        
        
        return CGSize(width: imageWidth, height: imageHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10.0, left: 6.0, bottom: 10.0, right: 6.0)
    }
    
}