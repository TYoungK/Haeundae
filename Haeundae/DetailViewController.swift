//
//  ViewController.swift
//  Haeundae
//
//  Created by D7703_29 on 2017. 11. 6..
//  Copyright © 2017년 D7703_29. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var itemD : [String:String] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = itemD["accName"]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailpin" {
            
            let detailpin = segue.destination as! detailMapViewController
            // 테이블뷰에서 선택한 indexPath.row
            detailpin.itemP = itemD
            
        }
    }
    
    

}

