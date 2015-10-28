//
//  WebController.swift
//  ApartmentFinder
//
//  Created by Roman Gardukevich on 27/10/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

import UIKit
import TLYShyNavBar

class WebController: UIViewController, UIWebViewDelegate {
    var loadingURLRequest : Bool = false {
        willSet{
            webView.hidden = newValue
        }
    }
    @IBOutlet var webView : UIWebView!
    var shouldHideStatusBar : Bool = false {
        didSet{
            if shouldHideStatusBar != oldValue {
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.shyNavBarManager.scrollView = self.webView.scrollView
        self.shyNavBarManager.extensionView = nil
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return self.shouldHideStatusBar
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return UIStatusBarAnimation.Slide
    }

    func swipe(swipeGesture : UISwipeGestureRecognizer){
        self.shouldHideStatusBar = self.navigationController?.navigationBar.frame.origin.y < 0;
    }

    func webViewDidStartLoad(webView: UIWebView) {
        loadingURLRequest = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        loadingURLRequest = false
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