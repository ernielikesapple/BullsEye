//
//  AboutViewController.swift
//  BullEye
//
//  Created by ernie on 2/10/2016.
//  Copyright © 2016 ernie. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBAction func close(){
    dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var webView : UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        
        //1st find BullsEye.html file in the application bundle,
        //then loads it into an NSData object ,
        //then ask the webview to show the contents of this data object
        
        
        
        
        if let htmlFile = NSBundle.mainBundle().pathForResource("BullsEye",ofType: "html"){
        
            if let htmlData = NSData(contentsOfFile: htmlFile){
                
                let baseURL = NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath)
                
                webView.loadData(htmlData, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
            
            }
        
        }
        
        
        
        
        
        
        
        
    }

}
