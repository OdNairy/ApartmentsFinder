//
//  TextFieldOptionCell.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 28/10/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import UIKit

class TextFieldOptionCell: UITableViewCell {

    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var textField : UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
