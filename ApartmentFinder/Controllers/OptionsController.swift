//
//  OptionsController.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 28/10/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import UIKit
import TLYShyNavBar

/** TODO: Improve by [iOS 7 Translucent Modal View Controller](http://stackoverflow.com/a/22181911/887401)
*/
class OptionsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var optionsData = OptionsData()
    @IBOutlet var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.shyNavBarManager.scrollView = self.tableView
    }
    
    // MARK: - Helpers
    
    func cellIdentifier(indexPath: NSIndexPath) -> String {
        switch (indexPath.row){
        case 0...1:
            return "TextFieldCell"
        case 2:
            return "OwnerCell"
        case 3:
            return "FlatTypeCell"
        default:
            return ""
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Done" {
            let minPriceCell = minimumPriceCell()
            let minimumPrice = minPriceCell.textField.text
            if ((minimumPrice?.characters.count) != nil) {
                self.optionsData.minimumPrice = Int(minimumPrice!)
            }
            
            let maxPriceCell = maximumPriceCell()
            let maximumPrice = maxPriceCell.textField.text
            if ((maximumPrice?.characters.count) != nil) {
                self.optionsData.maximumPrice = Int(maximumPrice!)
            }
            
            let ownerOptionCell = ownerCell()
            self.optionsData.owner = OptionsData.Owner(rawValue: ownerOptionCell.segmentedControl.selectedSegmentIndex)!

            let flatTypeCell = apartmentTypeCell()
            self.optionsData.apartmentType = OptionsData.ApartmentType(rawValue: flatTypeCell.apartmentTypeSegment.selectedSegmentIndex)!
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier(indexPath), forIndexPath: indexPath)
        
        switch (indexPath.row){
        case 0:
            let textFieldCell = cell as! TextFieldOptionCell
            textFieldCell.titleLabel.text = NSLocalizedString("Minimum price", comment: "Options cell title")
            if let minimumPrice = self.optionsData.minimumPrice {
                textFieldCell.textField.text = String(minimumPrice)
            }
        case 1:
            let textFieldCell = cell as! TextFieldOptionCell
            textFieldCell.titleLabel.text = NSLocalizedString("Maximum price", comment: "Options cell title")
            if let maximumPrice = self.optionsData.maximumPrice {
                textFieldCell.textField.text = String(maximumPrice)
            }
        case 2:
            let ownerCell = cell as! OwnerOptionCell
            ownerCell.segmentedControl.selectedSegmentIndex = self.optionsData.owner.rawValue
        case 3:
            let apartmentTypeCell = cell as! ApartmentTypeCell
            apartmentTypeCell.apartmentTypeSegment.selectedSegmentIndex = self.optionsData.apartmentType.rawValue
        default:
            break;
        }

        return cell
    }

    
    func minimumPriceCell() -> TextFieldOptionCell {
        return self.tableView.visibleCells[0] as! TextFieldOptionCell
    }
    
    func maximumPriceCell() -> TextFieldOptionCell {
        return self.tableView.visibleCells[1] as! TextFieldOptionCell
    }
    
    func ownerCell() -> OwnerOptionCell {
        return self.tableView.visibleCells[2] as! OwnerOptionCell
    }
    
    func apartmentTypeCell() -> ApartmentTypeCell {
        return self.tableView.visibleCells[3] as! ApartmentTypeCell
    }
}
