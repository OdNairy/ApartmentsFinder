//
//  Helpers.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 06/11/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import Foundation
import Cent

extension String {
    func rangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
        let from16 = self.utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
        if let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) {
                return from ..< to
        }
        return nil
    }
}

extension Regex {
    /**
     Perform regex to produce collections of group results
     
     - parameter testStr: input string to work on
     
     - returns: Collection of results. Each result is representating by collection
     of group
     */
    func groups(testStr:String) -> [[String]] {
        var groups = [[String]]()
        
        let matches = self.matches(testStr) as! [NSTextCheckingResult]
        for result in matches {
            var groupForResult = [String]()
            for index in 0..<result.numberOfRanges {
                let nsrange = result.rangeAtIndex(index)
                let range = testStr.rangeFromNSRange(nsrange)
                groupForResult << testStr[range!]
            }
            groups << groupForResult
        }
        
        return groups
    }
}