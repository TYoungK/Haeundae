//
//  allViewController.swift
//  Haeundae
//
//  Created by D7703_29 on 2017. 11. 13..
//  Copyright © 2017년 D7703_29. All rights reserved.
//

import UIKit
import MapKit
class allViewController: UIViewController {
    @IBOutlet weak var allMap: MKMapView!
    var itemA : [[String:String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "해운대구 숙박업소 지도"
        
        // Do any additional setup after loading the view.
        zoomToRegion()
        
        //print("tItems = \(tItems)")
        // lat, lng
        var annos = [MKPointAnnotation]()
        
        for item in itemA {
            let anno = MKPointAnnotation()
            
            let lat = item["gpsLat"]
            let long = item["gpsLon"]
            
            let fLat = (lat! as NSString).doubleValue
            let fLong = (long! as NSString).doubleValue
            
            anno.coordinate.latitude = fLat
            anno.coordinate.longitude = fLong
            anno.title = item["accName"]
            anno.subtitle = item["address"]
            
            annos.append(anno)
            
        }
        allMap.addAnnotations(annos)
    }
    func zoomToRegion() {
        let center = CLLocationCoordinate2DMake(35.189452, 129.165529)
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(center, span)
        allMap.setRegion(region, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
