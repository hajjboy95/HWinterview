//
//  DetailViewController.swift
//
//  Created by Ismail El-habbash on 4/8/16.
//  Copyright © 2016 Ismail El-Habbash. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailTagsLabel: UILabel!
    
    var detailImage:UIImage?
    var detailDescription:String?
    var detailTag:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.image = detailImage
        detailDescriptionLabel.text = detailDescription
        detailTagsLabel.text = detailTag

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
