//
//  GenericViewController.swift
//  BaseWebViewApp
//
//  Created by Erika Esther Torres Verdin on 08/01/18.
//  Copyright © 2018 Erika Esther Torres Verdin. All rights reserved.
//

import Foundation
import UIKit

class GenericViewController: UIViewController, UIWebViewDelegate {
    
    var myURL: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myWebView:UIWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        self.view.addSubview(myWebView)
        
        myWebView.delegate = self
        
       
        
        let myURL = URL(string: self.myURL)
        
        let myURLRequest:URLRequest = URLRequest(url: myURL!)
        
        if Reachability.isConnectedToNetwork() == true {
            myWebView.loadRequest(myURLRequest)
            myWebView.frame = self.view.frame
            myWebView.scalesPageToFit = true
            myWebView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        }
            
        else {
            print("Internet connection FAILED")
            let alert = UIAlertView(title: "Sin conexión a Internet", message: "Asegúrese que tenga acceso a internet y reinicie la aplicación", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        print("Started to load")
    }
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        print("Finished loading")
    }
    
    /*var myURL: String {
        get {
            
            return myURL
        }
        set(newValue) {
            //code to execute
        }
    }*/
    
}

