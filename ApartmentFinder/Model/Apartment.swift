//
//  Apartment.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 18/10/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import UIKit
import Parse


class Apartment: PFObject, PFSubclassing {
    override class func initialize(){
        struct Static {
            static var onceToken : dispatch_once_t = 0
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    class func parseClassName() -> String{
        return "Apartment"
    }
    @NSManaged var onlinerID : Int
    @NSManaged var priceUSD : Int
    @NSManaged var priceBYR : Int
    @NSManaged var userAddress : String
    @NSManaged var url : String
    @NSManaged var photoUrl : String
    @NSManaged var owner : Bool
    
    class func findAll() -> BFTask {
        return Apartment.query()!.findObjectsInBackground()
    }
}
