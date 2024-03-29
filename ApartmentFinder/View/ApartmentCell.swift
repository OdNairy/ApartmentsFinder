//
//  ApartmentCell.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 18/10/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import UIKit
import PINRemoteImage
import Cent


class ApartmentCell: UICollectionViewCell {
    // Highest subviews in hierarchy
    @IBOutlet weak var previewView: UIImageView!

    @IBOutlet weak var ownerView: OwnerMarkView!
    @IBOutlet weak var upTextLabel : UILabel!
    
    @IBOutlet weak var normalPriorityCurrencyLabel: UILabel!
    @IBOutlet weak var highPriorityCurrencyLabel: UILabel!
    @IBOutlet weak var roomCountlabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var currencyPriority = OptionsData.Currency.USD

    static var formatter = NSNumberFormatter()
    var numberFormatter : NSNumberFormatter {
        get {
            let numberFormatter =  NSNumberFormatter()
            numberFormatter.numberStyle = .CurrencyStyle
            return numberFormatter
        }
    }
    
    weak var apartment : Apartment?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(apartment: Apartment){
        self.apartment = apartment
        
        let formatter = NSNumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ru_RU")
        formatter.numberStyle = .CurrencyStyle
        formatter.currencySymbol = "$"
        formatter.currencyGroupingSeparator = " "
        formatter.maximumFractionDigits = 0;
        
        self.highPriorityCurrencyLabel.text = formatter.stringFromNumber(NSNumber(integer: apartment.priceUSD))
        formatter.currencySymbol = NSLocalizedString("Br", comment: "Currency Symbol on ApartmentCell")
        self.normalPriorityCurrencyLabel.text = formatter.stringFromNumber(NSNumber(integer: apartment.priceBYR))
        self.addressLabel.text = apartment.userAddress
        
        self.upTextLabel.text = nil
        self.ownerView.ownerType = apartment.owner ? .Owner : .Agent;
        
        self.roomCountlabel.text = apartment.roomsText()
        self.timeLabel.text = apartment.timeAgoText()
        
        
        guard let url = NSURL(string: apartment.photoUrl) else {
            return
        }

        // Set remote image into ImageView with check for apartment
        self.previewView.pin_setImageFromURL(url) { remoteResult -> Void in
            if apartment.isEqual(self.apartment) {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.previewView.image = remoteResult.image
                })
            }
            
        }
    }
    
    
    func format(number: NSNumber) -> String -> String? {
        
        return { currencyCode in
            self.numberFormatter.currencyCode = currencyCode
            return self.numberFormatter.stringFromNumber(number)
        }
    }
    
    override func prepareForReuse() {
        self.previewView.image = nil
    }

}
