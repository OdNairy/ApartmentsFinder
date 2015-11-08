//
//  ApartmentAnnotation.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 08/11/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import UIKit
import Mapbox

class ApartmentAnnotation: MGLPointAnnotation {
    var apartment : Apartment!
    
    init(apartment : Apartment ) {
        super.init()
        self.apartment = apartment
        self.setupApartmentInfo()
    }
    
    func setupApartmentInfo(){
        self.coordinate = CLLocationCoordinate2D(latitude: apartment.location.latitude, longitude: apartment.location.longitude)
        self.title = apartment.userAddress
        self.subtitle = "\(apartment.priceUSD)$"
    }
}
