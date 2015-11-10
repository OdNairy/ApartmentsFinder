//
//  OptionsData.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 28/10/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import UIKit

extension NSCoder {
    func decodeIntegerForKeyOptional(key: String) -> Int? {
        guard self.containsValueForKey(key) else {
            return nil
        }
        return self.decodeIntegerForKey(key)
    }
}

class OptionsData : NSObject, NSSecureCoding {
    enum Owner : Int {
        case Agent = 0
        case Owner = 1
        case All = 2
        func toString() -> String{
            switch (self){
            case .Agent:
                return "Agent"
            case .Owner:
                return "Owner"
            case .All:
                return "All"
            }
        }
    }
    
    enum Currency : Int {
        case BYR
        case USD
    }
    
    enum ApartmentType : Int {
        case NotDeterminated = -1
        case room = 0
        case oneRoom
        case twoRooms
        case threeRooms
        case fourAndMoreRooms
        case All

        func toString() -> String {
            switch(self){
            case .NotDeterminated: return "NoD"
            case .room: return "room"
            case .oneRoom: return "1 room"
            case .twoRooms: return "2 rooms"
            case .threeRooms: return "3 rooms"
            case .fourAndMoreRooms: return "4+ rooms"
            case .All : return "All"
            }
        }
    }
    
    
    var minimumPrice : Int?
    var maximumPrice : Int?
    var owner = Owner.All
    var priorityCurrency = Currency.USD
    var apartmentType = ApartmentType.NotDeterminated
    
    override init(){
        
    }
    
    init(minimumPrice: Int?, maximumPrice: Int?){
        self.minimumPrice = minimumPrice
        self.maximumPrice = maximumPrice
    }
    
    required init?(coder aDecoder: NSCoder){
        minimumPrice = aDecoder.decodeIntegerForKeyOptional("minimumPrice")
        maximumPrice = aDecoder.decodeIntegerForKeyOptional("maximumPrice")
        owner = Owner(rawValue: aDecoder.decodeIntegerForKey("owner"))!
        if let apartmentTypeInt = aDecoder.decodeIntegerForKeyOptional("apartmentType") {
            apartmentType = ApartmentType(rawValue: apartmentTypeInt)!
        }
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard ((object?.isKindOfClass(OptionsData.self)) != nil), let object = object else {
            return false
        }
        let optionsObject = object as! OptionsData
        return self.minimumPrice == optionsObject.minimumPrice && self.maximumPrice == optionsObject.maximumPrice
    }
    
    static func supportsSecureCoding() -> Bool {
        return true
    }
    func encodeWithCoder(aCoder: NSCoder){
        if let minimumPrice = minimumPrice {
            aCoder.encodeInteger(minimumPrice, forKey: "minimumPrice")
        }
        if let maximumPrice = maximumPrice {
            aCoder.encodeInteger(maximumPrice, forKey: "maximumPrice")
        }
        aCoder.encodeInteger(owner.rawValue, forKey: "owner")
        aCoder.encodeInteger(apartmentType.rawValue, forKey: "apartmentType")
        
    }
    
    func analyticMap() -> [String:String] {
        var map = [String:String]()
        if let minimumPrice = minimumPrice {
            map["Minimum Price"] = String(minimumPrice)
        }
        if let maximumPrice = maximumPrice {
            map["Maximum Price"] = String(maximumPrice)
        }
        map["Owner"] = owner.toString()
        map["Apartment type"] = apartmentType.toString()
        return map
    }
}
