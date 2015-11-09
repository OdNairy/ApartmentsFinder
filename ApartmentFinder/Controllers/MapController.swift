//
//  MapController.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 07/11/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import UIKit
import Mapbox
import GoogleMaps

class MapController: UIViewController, GMSMapViewDelegate {
//    @IBOutlet var mapView : MGLMapView!
    var webController : WebController?
    @IBOutlet var mapView : GMSMapView!
    
    var apartments = [Apartment](){
        didSet{
            updateAnnotations()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        updateAnnotations()
        
        let camera = GMSCameraPosition.cameraWithLatitude(53.901090,
            longitude:27.558759, zoom:12)
        mapView.camera = camera

//        mapView.setCenterCoordinate(CLLocationCoordinate2D(latitude: 53.904729, longitude: 27.653554), zoomLevel: 11, animated: false)
        
//        let annotation = MGLPointAnnotation()
        
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 53.904729, longitude: 27.653554)
//        annotation.title = "Test point"
//        annotation.subtitle = "This is my test"
//        
//        mapView.addAnnotation(annotation)

        
        self.webController = self.storyboard?.instantiateViewControllerWithIdentifier("WebController") as? WebController
        self.webController?.loadViewIfNeeded()
    }
    
    func updateAnnotations() {
        guard mapView != nil else {return}
        for apartment in apartments {
//            let annotation = ApartmentAnnotation(apartment: apartment)
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: apartment.location.latitude, longitude: apartment.location.longitude))
            marker.title = "\(apartment.priceUSD)$ \(apartment.userAddress)"
            marker.map = mapView
            marker.appearAnimation = kGMSMarkerAnimationPop;
            marker.userData = apartment
//            mapView.addAnnotation(annotation)
        }
//        mapView.setNeedsDisplay()
    }
    
    func openApartmentDetails(marker: GMSMarker) {
        let apartment = marker.userData as! Apartment
        
        webController?.apartment = apartment
        self.navigationController?.pushViewController(webController!, animated: true)
    }
    
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!){
        openApartmentDetails(marker)
    }
}
