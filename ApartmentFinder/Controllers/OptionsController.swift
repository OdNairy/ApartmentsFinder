//
//  OptionsController.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 28/10/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import UIKit
import TLYShyNavBar

class OptionsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.shyNavBarManager.scrollView = self.tableView
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Helpers
    
    func cellIdentifier(indexPath: NSIndexPath) -> String {
        return "TextFieldCell"
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier(indexPath), forIndexPath: indexPath) as! TextFieldOptionCell
        
        var titleLabelText : String = ""
        if indexPath.row == 0 {
            titleLabelText = NSLocalizedString("Minimum price", comment: "Options cell title")
        }else {
            titleLabelText = NSLocalizedString("Maximum price", comment: "Options cell title")
        }
        cell.titleLabel.text = titleLabelText
        
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
