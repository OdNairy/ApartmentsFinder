//
//  ApartmentListController.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 18/10/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ApartmentListController: UICollectionViewController {
    var apartments : [Apartment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = Apartment.query()
        query?.limit = 50
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            guard let objects = objects else {
                return
            }
            self.apartments = objects as! [Apartment]
            self.collectionView?.reloadData()
        })
        self.collectionView?.registerNib(
            UINib(nibName: "ApartmentCell", bundle: nil),
            forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let collectionViewWidth = CGRectGetWidth((self.collectionView?.bounds)!)
        let collectionViewHeight = CGRectGetHeight((self.collectionView?.bounds)!)
        
        let cellSize = CGSizeMake(collectionViewWidth, collectionViewHeight/3)
        
        
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = cellSize
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.apartments.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ApartmentCell
//        cell.backgroundColor = UIColor(white: 0.8, alpha: 0.3)
        cell.layer.borderWidth = 1/UIScreen.mainScreen().scale
        cell.layer.borderColor = UIColor.blackColor().CGColor
//        cell.layer.cornerRadius = 8
        
        let apartment = apartments[indexPath.row]
        cell.configure(apartment)
        
        // Configure the cell
        
        return cell
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
}
