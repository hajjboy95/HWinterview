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
    
    var propertyImages = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScrollViewSize()
        updateUI()
        // bug in sdk requires this
        
        
        

             propertyApi.getPropertyData(.SpecificProperty, url:"/properties/\(propertyId)", completion:{ (city, error) -> Void in
            
            if error != nil {
                print("ERROR HAS OCCURED \(error)")
            } else {
//                print(city)
//                print( JsonParser.packageSpecificProperty(city) )
                

                
            }
            
        })
        
        
    }
    
    
    func updateUI() {
        self.navigationController?.navigationBar.translucent = false

        self.propertyName.text = (cityInfo?.cityName ?? "Unknown City") +  " , " + (cityInfo?.country ?? "Unknown country")
        self.addressTextView.text = "JKHADUHASUDHA DUIHADISUHDSAUI J HASJDN IASD NASDJA NSDNAJKSDNnasJNJKASNDJN   nasndkSDKKDL NAS "
        
        
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
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: contentSize.height )

    }
}

extension DetailViewController : UICollectionViewDataSource
{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.propertyImages.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! DetailCollectionViewCell
        let image = self.propertyImages[indexPath.row]
        cell.propertyImageView.image = image as? UIImage
        
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