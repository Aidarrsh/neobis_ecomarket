//
//  AnimatedTextField.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 4/11/23.
//

import Foundation
import UIKit
import SnapKit

class AnimatedTextField: UITextField {
    
    var floatingLabel: UILabel = UILabel()
    var defaultPlaceholderColor: UIColor = UIColor.lightGray

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
        self.autocapitalizationType = .none
        floatingLabel.textColor = defaultPlaceholderColor
        floatingLabel.font = UIFont.ttRegular(ofSize: 16)
        addSubview(floatingLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.attributedPlaceholder = nil
        if floatingLabel.superview == nil {
            addSubview(floatingLabel)
        }
        if isFirstResponder || !(text?.isEmpty ?? true) {
            floatingLabel.frame = CGRect(x: 0, y: -4, width: bounds.width, height: 12)
            floatingLabel.textColor = defaultPlaceholderColor
            floatingLabel.font = UIFont.ttMedium(ofSize: 14)
        } else {
            floatingLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
            floatingLabel.textColor = defaultPlaceholderColor
            floatingLabel.font = UIFont.ttRegular(ofSize: 16)
        }

        let bottomLine = CALayer()
        bottomLine.name = "bottomLine"
        bottomLine.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
        bottomLine.backgroundColor = UIColor(hex: "D2D1D5").cgColor
        layer.addSublayer(bottomLine)
    }

    override var placeholder: String? {
        didSet {
            floatingLabel.text = placeholder
        }
    }

    override var text: String? {
        didSet {
            layoutSubviews()
        }
    }

    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        UIView.animate(withDuration: 0.3) {
            self.layoutSubviews()
        }
        return result
    }

    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        UIView.animate(withDuration: 0.3) {
            self.layoutSubviews()
        }
        return result
    }
}
