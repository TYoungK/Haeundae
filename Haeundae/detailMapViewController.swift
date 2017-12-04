//
//  detailMapViewController.swift
//  Haeundae
//
//  Created by D7703_29 on 2017. 11. 13..
//  Copyright © 2017년 D7703_29. All rights reserved.
//

import UIKit
import MapKit
class detailMapViewController: UIViewController {
    @IBOutlet weak var detailMap: MKMapView!
    var itemP : [String:String] = [:]
    var Lat : Double = 0.000000
    var Long : Double = 0.000000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Lat = (itemP["gpsLat"]! as NSString).doubleValue
        Long = (itemP["gpsLon"]! as NSString).doubleValue
        
        //print("sLat = \(sLat)")
        
        let name = itemP["accName"]
        let addr = itemP["address"]
        
        
        zoomToRegion()
        
        self.title = "위치"
        
        let anno = MKPointAnnotation()
        anno.coordinate.latitude = Lat
        anno.coordinate.longitude = Long
        anno.title = name
        anno.subtitle = addr
        
        detailMap.addAnnotation(anno)
        detailMap.selectAnnotation(anno, animated: true)
        
    }
    
    func zoomToRegion() {
        
        let center = CLLocationCoordinate2DMake(Lat,Long)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegionMake(center, span)
        detailMap.setRegion(region, animated: true)
        
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


