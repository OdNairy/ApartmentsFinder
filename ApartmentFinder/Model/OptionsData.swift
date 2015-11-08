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
    }
    
    enum Currency : Int {
        case BYR
        case USD
    }
    
    
    var minimumPrice : Int?
    var maximumPrice : Int?
    var owner = Owner.All
    var priorityCurrency = Currency.USD
    
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
    }
}
