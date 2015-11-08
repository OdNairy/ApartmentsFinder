//
//  ApartmentListController.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 18/10/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import UIKit
import TLYShyNavBar
import Bolts

private let reuseIdentifier = "Cell"

func documentsDirectoryPath() -> String {
    // NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
    return documentsPath!+"/"
}

func documentsDirectoryPath(filename: String) -> String {
    return documentsDirectoryPath()+filename
}

class ApartmentListController: UICollectionViewController {
    var webController : WebController?
    var apartments = [Apartment]()
    lazy var refreshControl = UIRefreshControl()
    
    var optionsData: OptionsData = {
        // Default value initializer
        guard let options = NSKeyedUnarchiver.unarchiveObjectWithFile(documentsDirectoryPath("optionsData")) else {
            return OptionsData()
        }
        return options as! OptionsData
        }()
        {
        didSet{
            if false == NSKeyedArchiver.archiveRootObject(optionsData, toFile: documentsDirectoryPath("optionsData")) {
                print("optionsData archive failed")
            }
            updateApartmentsData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateApartmentsData()
        // Preload WebController to reduce webView load time
        webController = self.storyboard?.instantiateViewControllerWithIdentifier("WebController") as? WebController
        webController?.loadViewIfNeeded()
        
        self.shyNavBarManager.scrollView = self.collectionView

        self.collectionView?.registerNib(
            UINib(nibName: "ApartmentCell", bundle: nil),
            forCellWithReuseIdentifier: reuseIdentifier)
        
        refreshControl.addTarget(self, action: Selector("updateApartmentsData"), forControlEvents: .ValueChanged)
        self.collectionView?.addSubview(refreshControl)
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
    
    func updateApartmentsData() -> BFTask? {
        let query = Apartment.query()
        query?.orderByDescending("onlinerID")
        
        if let minPrice = optionsData.minimumPrice {
            query?.whereKey("priceUSD", greaterThanOrEqualTo: minPrice)
        }
        if let maxPrice = optionsData.maximumPrice {
            query?.whereKey("priceUSD", lessThanOrEqualTo: maxPrice)
        }
            switch (optionsData.owner) {
            case .All:
                break;
            case .Agent:
                query?.whereKey("owner", equalTo: false)
            case .Owner:
                query?.whereKey("owner", equalTo: true)
            }
        
        var task = query?.findObjectsInBackground()
        task = task!.continueWithSuccessBlock({ (task) -> AnyObject! in
            self.apartments = task.result as! [Apartment]
            return true
        })
        return task?.continueWithExecutor(BFExecutor.mainThreadExecutor(), withBlock: { (task) -> AnyObject! in
            self.collectionView?.reloadData()
            self.refreshControl.endRefreshing()
            return true
        })
    }
    
    // Unwind actions
    @IBAction func cancelOptions(segue: UIStoryboardSegue){

    }
    @IBAction func doneOptions(segue: UIStoryboardSegue){
        guard let optionsController = segue.sourceViewController as? OptionsController else {
            return
        }
        self.optionsData = optionsController.optionsData
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC =  segue.destinationViewController
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = self.view.bounds
        
        destinationVC.view.backgroundColor = UIColor.clearColor()
        destinationVC.view.insertSubview(effectView, atIndex: 0)
        destinationVC.modalPresentationStyle = .CurrentContext
        
    }
    */
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
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard (webController != nil) else { return }
        let apartment = apartments[indexPath.row]
        
        let url = NSURL(string: apartment.url)!
        let urlRequest = NSURLRequest(URL: url)
        webController?.webView.loadRequest(urlRequest)
        self.navigationController?.pushViewController(webController!, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard (segue.identifier != nil) else {return}
        
        switch (segue.identifier!){
            case "OpenOptions":
                let navigationController = segue.destinationViewController as! UINavigationController
                guard ((navigationController.topViewController?.isKindOfClass(OptionsController.self)) != nil), let optionsController = navigationController.topViewController as? OptionsController else {
                    return
                    
                }
                optionsController.optionsData = self.optionsData
                break;
            case "Map":
                let navigationController = segue.destinationViewController as! UINavigationController
                let mapController = navigationController.topViewController as! MapController
                mapController.apartments = self.apartments
                break;
        default: break;
        }
        guard segue.identifier == "OpenOptions" else {
            return
        }
        
    }
//    collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    
    
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
