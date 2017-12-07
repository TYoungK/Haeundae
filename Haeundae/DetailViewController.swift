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
    
    @IBOutlet var addr: UILabel!
    @IBOutlet var tel: UILabel!
    @IBOutlet var fee: UILabel!
    
    @IBOutlet var imgpage: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = itemD["accName"]
//        let imgs = NSURL(string: itemD["accDetailImage"]!)!
//        let imagedData = NSData(contentsOfURL: imgs as URL)
//        let imgs = itemD["accDetailImage"]
//        detailimg.downloadedFrom(link: imgs!)
//        imgs.append(itemD["accDetailImage"]!)
        addr.text = itemD["address"]
        tel.text = itemD["contactPlace"]
        var feeinfo = itemD["costInfo"]!
        let feeArr = feeinfo.characters.split(separator: ";").map(String.init)
        print(feeinfo)
        let feejoin = feeArr.joined(separator: "\n")
        //print(feejoin)
        if feeinfo == "\n"{
            fee.text = "업소문의"
        }else{
        fee.text = feejoin
        }
        var imgs = itemD["accDetailImages"]!
        let Arr = imgs.characters.split(separator: ";").map(String.init)
        imgArr = Arr
        imgpage.currentPage = 0
        imgpage.pageIndicatorTintColor = UIColor.white
        imgpage.currentPageIndicatorTintColor = UIColor.red
        imgpage.numberOfPages = imgArr.count
        //self.detailimg.setImageFromURl(stringImageUrl: imgArr[0])
        detailimg.downloadedFrom(link: imgArr[imgpage.currentPage])
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(DetailViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(DetailViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }
    func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                if (imgpage.currentPage<imgpage.numberOfPages-1) {
                    imgpage.currentPage = imgpage.currentPage + 1
                }
                //print("Swiped Left")
            case UISwipeGestureRecognizerDirection.right:
                if (imgpage.currentPage>0) {
                    imgpage.currentPage = imgpage.currentPage - 1
                }
                //print("Swiped Right")
            default:
                break
            }
            
            detailimg.downloadedFrom(link: imgArr[imgpage.currentPage])
        }
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

