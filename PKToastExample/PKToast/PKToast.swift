//
//  PKToast.swift
//  PKToast
//
//  Created by Pramod Kumar on 31/12/16.
//  Copyright © 2016 Pramod Kumar. All rights reserved.
//

import Foundation
import UIKit

open class PKToast {
    
    //MARK:- Private Properties
    //MARK:-
    private var messageView: PKToastView!
    private var animateToast: Bool = true, isOldView = true
    private var presentingInView: UIView!
    
    //MARK:- Public Properties
    //MARK:-
    static var shared = PKToast()
    var messageFont: UIFont = UIFont.systemFont(ofSize: 13.0)
    var messageTextColor: UIColor = UIColor.white
    var backColor: UIColor = UIColor.darkGray
    var borderColor: UIColor = UIColor.white
    var borderWidth: CGFloat = 2.0
    var messageInset: UIEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)

    
    //MARK:- Private Methods
    //MARK:-
    private init() {}
    
    private func createToastView(withMessage message: String) {
        //create the new Toast message view
        self.removeMessageView() //firstly removing old view
        self.isOldView = false
        self.messageView = PKToastView(message: message, messageFont: self.messageFont, messageTextColor: self.messageTextColor, inView: self.presentingInView, backColor: self.backColor, borderColor: self.borderColor, borderWidth: self.borderWidth, messageInset: self.messageInset)
        self.presentingInView.addSubview(self.messageView)
    }
    
    private func removeMessageView() {
        //remove view if exist
        if let _ = self.messageView {
            self.messageView.removeFromSuperview()
            self.messageView = nil
        }
    }

    //MARK:- Public Methods
    //MARK:-
    func show(message: String, animated: Bool = true, presentDuration: Double = 2.0, inViewController: UIViewController? = nil) {
        //animate state for hiding Toast
        self.animateToast = animated
        
        if let viewController = inViewController {
            self.presentingInView = viewController.view
        }
        else {
            self.presentingInView = PKGlobals.sharedAppdelegate.window
        }
        
        self.createToastView(withMessage: message.trimmedValue)
        
        self.messageView.alpha = 1.0
        
        UIView.animate(withDuration: animated ? 0.5 : 0.0, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.messageView.frame = CGRect(x: self.messageView.frame.origin.x, y: (self.messageView.frame.origin.y - (self.messageView.bounds.height+50.0)), width: self.messageView.bounds.width, height: self.messageView.bounds.height)
            
        }, completion: {
            (success) in
            self.isOldView = true
            PKGlobals.delay(presentDuration, closure: {
                self.hide()
            })
        })
    }
    
    func hide() {
        if self.isOldView {
            UIView.animate(withDuration: self.animateToast ? 0.1 : 0.0, animations: {
                self.messageView.alpha = 0.0
                
            }, completion: {
                (success) in
                self.messageView.frame = CGRect(x: self.messageView.frame.origin.x, y: (self.presentingInView.bounds.height+10.0), width: self.messageView.bounds.width, height: self.messageView.bounds.height)
            })
        }
    }
}


//MARK:- PKGlobals
//MARK:-
open class PKGlobals {
    
    static let sharedAppdelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    //MARK:- Screen Properties
    //MARK:-
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
    
    
    //method to make delay of specific time in execution
    class func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
            execute: closure
        )
    }
}

//MARK:- String Extension
//MARK:-
extension String{
    var length: Int{
        return self.characters.count
    }
    var trimmedValue: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

