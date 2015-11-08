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
    var webController : WebController?
    
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

        
        self.webController = self.storyboard?.instantiateViewControllerWithIdentifier("WebController") as? WebController
        self.webController?.loadViewIfNeeded()
    }
    
    func updateAnnotations() {
        guard mapView != nil else {return}
        for apartment in apartments {
            let annotation = ApartmentAnnotation(apartment: apartment)
            
            mapView.addAnnotation(annotation)
        }
        mapView.setNeedsDisplay()
    }
    
    func openApartmentDetails(annotation: MGLAnnotation) {
        let annotation = annotation as! ApartmentAnnotation
        let apartment = annotation.apartment
        
        webController?.apartment = apartment
        self.navigationController?.pushViewController(webController!, animated: true)
    }
    
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(mapView: MGLMapView, rightCalloutAccessoryViewForAnnotation annotation: MGLAnnotation) -> UIView? {
        return UIButton(type: .DetailDisclosure)
    }
    
    func mapView(mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl){
        openApartmentDetails(annotation)
    }

}
