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
    var imgArr : [String] = []
    
    @IBOutlet var imgpage: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = itemD["accName"]
//        let imgs = NSURL(string: itemD["accDetailImage"]!)!
//        let imagedData = NSData(contentsOfURL: imgs as URL)
//        let imgs = itemD["accDetailImage"]
//        detailimg.downloadedFrom(link: imgs!)
//        imgs.append(itemD["accDetailImage"]!)
        
        var imgs = itemD["accDetailImages"]!
        let Arr = imgs.characters.split(separator: ";").map(String.init)
        imgArr = Arr
        imgpage.currentPage = 0
        imgpage.pageIndicatorTintColor = UIColor.white
        imgpage.currentPageIndicatorTintColor = UIColor.red
        imgpage.numberOfPages = imgArr.count
        //self.detailimg.setImageFromURl(stringImageUrl: imgArr[0])
        detailimg.downloadedFrom(link: imgArr[imgpage.currentPage])
        
        
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(detailimg.responds(to:)))
//        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
    }
    @IBAction func pagechage(_ sender: Any) {
        //self.detailimg.setImageFromURl(stringImageUrl: imgArr[])
        detailimg.downloadedFrom(link: imgArr[imgpage.currentPage])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailpin" {
            
            let detailpin = segue.destination as! detailMapViewController
            // 테이블뷰에서 선택한 indexPath.row
            detailpin.itemP = itemD
            
        }
    }
    
    

}

