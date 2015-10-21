//
//  OwnerMarkView.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 18/10/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import UIKit

@IBDesignable
class OwnerMarkView: UIView {
    enum OwnerType {
        case Owner
        case Agent
        case Unknown
    }
    
    var ownerType : OwnerType = OwnerType.Unknown {
        didSet(newType){
            updateLabelData()
        }
    }
    var textLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    func initialize() {
        self.backgroundColor = UIColor.clearColor()
        
        textLabel = UILabel()
        self.addSubview(textLabel!)
        textLabel?.textColor = UIColor.whiteColor()
        setupLabelContraints(textLabel!)
        updateLabelData()
    }
    
    func setupLabelContraints(label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        let vContraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["label":label])
        self.addConstraints(vContraints)
        
        let hContraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[label]-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["label":label])
        self.addConstraints(hContraints)
    }
    
    func updateLabelData() {
        switch (ownerType){
        case .Owner:
            textLabel?.text = "Owner"
            break
        case .Agent:
            textLabel?.text = "Agent"
            break;
        default:
            textLabel?.text = nil
            break
        }
    }
}
