//
//  MapController.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 07/11/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import UIKit
import Mapbox

class MapController: UIViewController, MGLMapViewDelegate {
    @IBOutlet var mapView : MGLMapView!
    var apartments = [Apartment](){
        didSet{
            updateAnnotations()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        updateAnnotations()

        mapView.setCenterCoordinate(CLLocationCoordinate2D(latitude: 53.904729, longitude: 27.653554), zoomLevel: 11, animated: false)
        
        let annotation = MGLPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: 53.904729, longitude: 27.653554)
        annotation.title = "Test point"
        annotation.subtitle = "This is my test"
        
        mapView.addAnnotation(annotation)

    }
    
    func updateAnnotations() {
        guard mapView != nil else {return}
        for apartment in apartments {
            let annotation = MGLPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: apartment.location.latitude, longitude: apartment.location.longitude)
            annotation.title = apartment.userAddress
            annotation.subtitle = "\(apartment.priceUSD)$"
            
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}
