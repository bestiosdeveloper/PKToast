//
//  PKToast.swift
//  PKToast
//
//  Created by Pramod Kumar on 31/12/16.
//  Copyright © 2016 Pramod Kumar. All rights reserved.
//

import Foundation
import UIKit

class PKToastView: UIView {
    
    //MARK:- Properties
    //MARK:-
    private var message: String!
    private var noOfLines: CGFloat = 0.0
    private var maxLinesToShow: CGFloat = 5.0
    
    //MARK:- View Life Cycle
    //MARK:-
    init(message: String, messageFont: UIFont, messageTextColor: UIColor, inView: UIView, backColor: UIColor, borderColor: UIColor, borderWidth: CGFloat, messageInset: UIEdgeInsets) {
        super.init(frame: CGRect.zero)
        
        let newFrame = self.getMessageViewFrame(message: message, messageFont: messageFont, messageInset: messageInset, inView: inView)
        self.frame = newFrame
        self.backgroundColor = backColor
        self.message = message

        self.initialSetup(frame: newFrame, messageFont: messageFont, messageTextColor: messageTextColor, borderColor: borderColor, borderWidth: borderWidth, messageInset: messageInset)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Private Methods
    //MARK:-
    private func initialSetup(frame: CGRect, messageFont: UIFont, messageTextColor: UIColor, borderColor: UIColor, borderWidth: CGFloat, messageInset: UIEdgeInsets) {
        
        //make label to show message text
        let messageLabel = UILabel(frame: CGRect(x: messageInset.left, y: messageInset.top, width: frame.width-(messageInset.right*2), height: frame.height-(messageInset.bottom*2)))
        messageLabel.font = messageFont
        messageLabel.textColor = messageTextColor
        messageLabel.text = self.message
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.backgroundColor = UIColor.clear
        
        self.addSubview(messageLabel)
        
        //buetify message view
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = self.noOfLines <= 2.0 ? frame.height / 2 : 10.0
        self.layer.masksToBounds = true
    }
    
    private func getMessageViewFrame(message: String, messageFont: UIFont, messageInset: UIEdgeInsets, inView: UIView) ->CGRect {
        
        //make the frame for message view with respect to text
        let textSize = self.getTextSize(message: message, withFont: messageFont, bundingSize: CGSize(width: inView.bounds.width - 20.0, height: 10000), messageInset: messageInset)

        return CGRect(x: (inView.bounds.width - textSize.width) / 2, y: inView.bounds.height+10.0, width: textSize.width, height: textSize.height)
    }
    
    private func getTextSize(message: String, withFont font: UIFont, bundingSize size: CGSize, messageInset: UIEdgeInsets) -> CGSize {
        
        //getting the size of message text with respect to font and device
        let mutableParagraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        mutableParagraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        let attributes: [String : AnyObject] = [NSFontAttributeName: font, NSParagraphStyleAttributeName: mutableParagraphStyle]
        
        //get single line height
        let singleLineHeight: CGFloat = NSString(string: "A").boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil).height
        
        //get message text size
        let rect: CGRect = NSString(string: message).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        //get no of lines in message text
        self.noOfLines = rect.height / singleLineHeight
        let maxHeight: CGFloat = (self.maxLinesToShow * singleLineHeight) + (messageInset.top + messageInset.bottom)
        var height = CGFloat(ceilf(Float(rect.size.height + messageInset.top + messageInset.bottom)))
        height = height < maxHeight ? height : maxHeight
        let width = CGFloat(ceilf(Float(rect.size.width + messageInset.left + messageInset.right)))
        return CGSize(width: width, height: height)
    }
}
