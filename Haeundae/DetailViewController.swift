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
    var imgs : [String] = []
    @IBOutlet var imgpage: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = itemD["accName"]
        imgs.append(itemD["accDetailImages"]!)
        imgpage.numberOfPages = imgs.count
        
        imgpage.currentPageIndicatorTintColor = UIColor.red
        detailimg.image = UIImage(
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

