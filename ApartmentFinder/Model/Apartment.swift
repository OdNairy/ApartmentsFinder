//
//  Apartment.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 18/10/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import UIKit
import Parse
import Cent


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
    @NSManaged var rentType : String
    
    class func findAll() -> BFTask {
        return Apartment.query()!.findObjectsInBackground()
    }
    
    func roomsText() -> String {
        var roomsText = NSLocalizedString("room", comment: "Apartment rent type with 1 room only not full flat")
        if self.rentType =~ "_room" {
            let roomCountText = Regex.init("(\\d+)_room").groups(self.rentType).first()!.last()!
            
            if let roomsCount = Int(roomCountText) {
                let roomsTextSuffix = roomsCount > 2 ? "s" : ""
                roomsText = "\(roomsCount) room\(roomsTextSuffix)"
            }
        }
        return roomsText
    }
}
