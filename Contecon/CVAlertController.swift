//
//  CVAlertController.swift
//  PuenteVehicularGobernadores
//
//  Created by Erika Esther Torres Verdin on 11/10/17.
//  Copyright © 2017 Erika Esther Torres Verdin. All rights reserved.
//

import Foundation
import UIKit

open class CVAlertController {
    
    // MARK : - Singleton
    
    class var instance : CVAlertController {
        struct Static {
            static let inst : CVAlertController = CVAlertController()
        }
        return Static.inst
    }
    
    // MARK : - Private Functions
    
    fileprivate func topMostController() -> UIViewController? {
        
        var presentedVC = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentedVC?.presentedViewController
        {
            presentedVC = pVC
        }
        
        if presentedVC == nil {
            print("CVlertController Error: You don't have any views set. You may be calling in viewDidLoad. Try viewDidappear.")
        }
        return presentedVC
    }
    
    // MARK : - Class Functions
    
    open class func alert(_ title: String) -> UIAlertController {
        return alert(title, message: "")
    }
    
    open class func alert(_ title: String, message: String) -> UIAlertController {
        return alert(title, message: message, acceptMessage: "OK") { () -> () in
            // Do nothing
        }
    }
    
    open class func alert(_ title: String, message: String, acceptMessage: String, acceptBlock: @escaping () -> ()) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let acceptButton = UIAlertAction(title: acceptMessage, style: .default, handler: { (action: UIAlertAction) in
            acceptBlock()
        })
        alert.addAction(acceptButton)
        
        instance.topMostController()?.present(alert, animated: true, completion: nil)
        return alert
    }
    
    open class func alert(_ title: String, message: String, buttons:[String], tapBlock:((UIAlertAction,Int) -> Void)?) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert, buttons: buttons, tapBlock: tapBlock)
        instance.topMostController()?.present(alert, animated: true, completion: nil)
        return alert
    }
    
}


private extension UIAlertController {
    convenience init(title: String?, message: String?, preferredStyle: UIAlertControllerStyle, buttons:[String], tapBlock:((UIAlertAction,Int) -> Void)?) {
        self.init(title: title, message: message, preferredStyle:preferredStyle)
        _ = 0
        /*for buttonTitle in buttons {
         let action = UIAlertAction(title: buttonTitle, preferredStyle: .default, buttonIndex: buttonIndex, tapBlock: tapBlock)
         buttonIndex += 1
         self.addAction(action)
         }*/
    }
}

/*private extension UIAlertAction {
 convenience init(title: String?, preferredStyle: UIAlertActionStyle, buttonIndex:Int, tapBlock:((UIAlertAction,Int) -> Void)?) {
 self.init(title: title, style: style) {
 (action:UIAlertAction) in
 if let block = tapBlock {
 block(action,buttonIndex)
 }
 }
 }
 }*/
