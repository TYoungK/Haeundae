//
//  ViewController.swift
//  Haeundae
//
//  Created by D7703_29 on 2017. 11. 6..
//  Copyright © 2017년 D7703_29. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailimg: UIImageView!
    var itemD : [String:String] = [:]
    
    
    @IBOutlet var imgpage: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = itemD["accName"]
//        let imgs = NSURL(string: itemD["accDetailImage"]!)!
//        let imagedData = NSData(contentsOfURL: imgs as URL)
//        let imgs = itemD["accDetailImage"]
//        detailimg.downloadedFrom(link: imgs!)
//        imgs.append(itemD["accDetailImage"]!)
        imgpage.currentPageIndicatorTintColor = UIColor.red
//        imgpage.numberOfPages = imgs.count
//        detailimg.image = UIImage(data: imgs[0])
        
    }
    @IBAction func pagechage(_ sender: Any) {
    detailimg.image = UIImage(named: itemD["accDetailImages"]!)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailpin" {
            
            let detailpin = segue.destination as! detailMapViewController
            // 테이블뷰에서 선택한 indexPath.row
            detailpin.itemP = itemD
            
        }
    }
    
    

}

