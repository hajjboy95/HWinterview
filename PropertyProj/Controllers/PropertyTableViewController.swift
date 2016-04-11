//
//  PropertyViewController.swift
//
//  Created by Ismail El-habbash on 4/8/16.
//  Copyright © 2016 Ismail El-Habbash. All rights reserved.
//

import UIKit

class PropertyTableViewController: UITableViewController {
    
    
    var propertyTableDataSource :[Hostel]!
    var propertyApi:PropertyApi!
    var cache:NSCache!
    var task: NSURLSessionDownloadTask!
    var session: NSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 200.0; // set to whatever your "average" cell height is
        
        
        intialiseObjects()
        
        
        
        propertyApi.getPropertyData("/cities/1530/properties/", completion:{ (cities, error) -> Void in
            
            if error != nil {
                print("ERROR HAS OCCURED \(error)")
            } else {
                self.propertyTableDataSource =  JsonParser.packageHostel(cities)

                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                    print("reloading data")
                })
               
            }
            
        })
    }
    
    private func intialiseObjects(){
        
        propertyTableDataSource = [Hostel]()
        propertyApi = PropertyApi()
        cache = NSCache()
      
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //    Isn't being automatically triggered from tableview (String error)
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        switch segue.identifier ?? "" {
            
        case Constants.PropertyTableViewToDetailViewSegue:
            
            let detailVC  = segue.destinationViewController as! DetailViewController
            let indexPath = sender as! NSIndexPath
            
            let info = propertyTableDataSource[indexPath.row]

            
            
            
        default:
            print("Error has occured")
            
        }
    }
    
}

//Extension to help with the PrepareForSegue
extension PropertyTableViewController  {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(Constants.PropertyMainTableViewCellIdentifier, sender: indexPath)
        
        
    }
}

extension PropertyTableViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertyTableDataSource.count
    }
    
    
    
    
    /**
     This functoin displays the cells in the tableView .
     
     Checks if the image is present in the NSCache variable first.
     the key is the dataTaken varaible . if present don't make a netweok request and display the
     image within the cache 
     
     if its not present in the cache call the flickr api object to download the image with the given
     url and update the ui when the image is recieved .
     
     as the image is being downlaoded from the server the user cannot click into the cell and a 
     placeholder is displayed in the meantime
     
     
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PropertyCell") as! PropertyTableViewCell
        let hostel = propertyTableDataSource[indexPath.row]
        let uniqueIdForHostel = hostel.hosteId
        cell.cellInfo = hostel
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}



//        cell.cellInfo = cellInfo
//
//        let date_taken = cellInfo.date_taken
//        let media = cellInfo.media
//
//        // check if the image is already present in the cache
//        if let img = cache.objectForKey(date_taken!) {
//            cell.mainImageView?.image = img as? UIImage
//        }
//
//            // set placeholder image , make network request then set image in cache
//        else {
//            cell.mainImageView?.image = UIImage(named: "placeholder")
//            cell.userInteractionEnabled = false
//
//            propertyApi.downloadPropertyImage(media! , completion: {  (image, error) -> Void in
//
//                print("media! = \(media!)")
//                if error != nil {
//                    print(error)
//                } else {
//                    let updateCell  = tableView.cellForRowAtIndexPath(indexPath) as? PropertyTableViewCell
//                    updateCell?.mainImageView?.image = image
//                    cell.userInteractionEnabled = true
//
//                    self.cache.setObject(image!, forKey: date_taken!)
//                }
//            })
//        }


