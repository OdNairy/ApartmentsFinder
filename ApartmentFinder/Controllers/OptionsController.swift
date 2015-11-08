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
    
    var optionsData = OptionsData() {
        didSet{
            print(optionsData)
        }
    }
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
        default:
            return ""
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Done" {
            
            let minimumPriceCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! TextFieldOptionCell
            let minimumPrice = minimumPriceCell.textField.text
            if ((minimumPrice?.characters.count) != nil) {
                self.optionsData.minimumPrice = Int(minimumPrice!)
            }
            
            let maximumPriceCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! TextFieldOptionCell
            let maximumPrice = maximumPriceCell.textField.text
            if ((maximumPrice?.characters.count) != nil) {
                self.optionsData.maximumPrice = Int(maximumPrice!)
            }
            
            let ownerCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! OwnerOptionCell
            self.optionsData.owner = OptionsData.Owner(rawValue: ownerCell.segmentedControl.selectedSegmentIndex)!
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
            break;
        case 1:
            let textFieldCell = cell as! TextFieldOptionCell
            textFieldCell.titleLabel.text = NSLocalizedString("Maximum price", comment: "Options cell title")
            if let maximumPrice = self.optionsData.maximumPrice {
                textFieldCell.textField.text = String(maximumPrice)
            }
            break;
        case 2:
            let ownerCell = cell as! OwnerOptionCell
            ownerCell.segmentedControl.selectedSegmentIndex = self.optionsData.owner.rawValue

            
            break;
        default:
            break;
        }

        
        return cell
    }
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
