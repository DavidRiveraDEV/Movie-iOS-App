//
//  LocalizabeViews+Extensions.swift
//  iOSTest
//
//  Created by David Rivera on 14/11/21.
//

import UIKit

extension UITextField {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        if let text = text {
            self.text = text.localize()
        }
        if let placeholder = placeholder {
            self.placeholder = placeholder.localize()
        }
    }
    
    @IBInspectable var placeHolderColor : UIColor {
        
        get {
            return self.placeHolderColor
        }
        
        set (newValue) {
            self.attributedPlaceholder = NSAttributedString(string: String.removeNil(self.placeholder), attributes: [.foregroundColor : newValue])
        }
    }
}

extension UILabel{
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        if let text = text {
            self.text = text.localize()
        }
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        if let text = text {
            self.text = text.localize()
        }
        super.prepareForInterfaceBuilder()
    }
}

extension UIButton {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        if let title = titleLabel?.text {
            self.setTitle(title.localize(), for: .normal)
        }
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        if let title = titleLabel?.text {
            self.setTitle(title.localize(), for: .normal)
        }
        super.prepareForInterfaceBuilder()
    }
}
