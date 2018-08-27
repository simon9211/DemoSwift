//
//  SMAnimationTextField.swift
//  FMDemoSwift
//
//  Created by xiwang wang on 2018/8/23.
//  Copyright © 2018年 com.simon. All rights reserved.
//

import UIKit
import SnapKit

class SMAnimationTextField: UIView {
    
    weak var delegate: SMAnimationTextFieldDelegate?
    
    var textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    var placeholder: String {
        get {
            return self.placeholder
        }
        
        set(value) {
            self.placeholderLabel.text = value
        }
    }
    
    var text: String? {
        get {
            return textField.text
        }
        set(value) {
            textField.text = value
            if value != nil && value != "" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.moveUp()
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.moveDown()
                }
            }
        }
    }
    
    private var placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        return label
    }()
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = SMColor(r: 236, g: 236, b: 236, a: 1.0)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 1.0
//        view.clipRectCorner(direction: UIRectCorner.allCorners, cornerRadius: 2)
        return view
    }()
    
    private var halfHeight: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.textField)
        textField.delegate = self
        self.addSubview(self.placeholderLabel)
        self.addSubview(self.lineView)
        halfHeight = frame.height / 2.0
    }
    
    override func updateConstraints() {
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.height.equalTo(25)
            make.left.right.bottom.equalTo(self)
        }
        
        textField.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(placeholderLabel)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(2)
        }
        
        super.updateConstraints()
    }
    
    override open class var requiresConstraintBasedLayout: Bool {
        get {
            return true
        }
    }
    
    func moveUp() {
        UIView.animate(withDuration: 0.25) {
            self.placeholderLabel.transform = CGAffineTransform(translationX: 0, y: -self.placeholderLabel.height)
            self.placeholderLabel.font = UIFont.systemFont(ofSize: 14)
            self.lineView.backgroundColor = SMColor(r:66, g:134, b:255, a: 1.0)
        }
    }
    
    func moveDown() {
        UIView.animate(withDuration: 0.25) {
            self.placeholderLabel.transform = CGAffineTransform.identity
            self.placeholderLabel.font = UIFont.systemFont(ofSize: 17)
            self.lineView.backgroundColor = SMColor(r: 236, g: 236, b: 236, a: 1.0)
        }
    }
    
}

extension SMAnimationTextField : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.moveUp()
        if delegate != nil && (delegate?.responds(to: #selector(textFieldShouldBeginEditing(_:))))! {
            return (delegate?.textFieldShouldBeginEditing?(self))!
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard (textField.text == nil || textField.text == "") else {
            return
        }
        self.moveDown()
        if delegate != nil && (delegate?.responds(to: #selector(textFieldDidEndEditing(_:))))! {
            delegate?.textFieldDidBeginEditing?(self)            
        }
    }
}

@objc protocol SMAnimationTextFieldDelegate: NSObjectProtocol {
    
    @objc optional func textFieldShouldBeginEditing(_ textField: SMAnimationTextField) -> Bool
    
    @objc optional func textFieldDidBeginEditing(_ textField: SMAnimationTextField)
}

