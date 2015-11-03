//
//  OwnerOptionCell.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 31/10/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import UIKit

class OwnerOptionCell: UITableViewCell {
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var segmentedControl : UISegmentedControl! {
        willSet{
            newValue.addTarget(self, action: Selector(stringLiteral: "segmentedControlDidChangedValue"), forControlEvents: .ValueChanged)
        }
    }
    var selectedSegment = -1
    
    func segmentedControlDidChangedValue(){
        if segmentedControl.selectedSegmentIndex == selectedSegment {
            segmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        }
        selectedSegment = segmentedControl.selectedSegmentIndex
    }
    
}
