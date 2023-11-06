//
//  OrderView.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 4/11/23.
//

import Foundation
import UIKit
import SnapKit

class OrderView: UIView {
    
    var price = 340
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Оформление заказа"
        label.font = UIFont.ttMedium(ofSize: 18)
        label.textColor = .black
        
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon"), for: .normal)
        
        return button
    }()
    
    lazy var numberTextField: AnimatedTextField = {
        let field = AnimatedTextField()
        field.placeholder = "Номер телефона"
        field.font = UIFont.ttRegular(ofSize: 16)
        field.keyboardType = .numberPad
        
        return field
    }()
    
    lazy var adressTextField: AnimatedTextField = {
        let field = AnimatedTextField()
        field.placeholder = "Адрес"
        field.font = UIFont.ttRegular(ofSize: 16)
        
        return field
    }()
    
    lazy var orientierTextField: AnimatedTextField = {
        let field = AnimatedTextField()
        field.placeholder = "Ориентир"
        field.font = UIFont.ttRegular(ofSize: 16)
        
        return field
    }()
    
    lazy var commentTextField: AnimatedTextField = {
        let field = AnimatedTextField()
        field.placeholder = "Комментарии"
        field.font = UIFont.ttRegular(ofSize: 16)
        
        return field
    }()
    
    lazy var sumLabel: UILabel = {
        let label = UILabel()
        
        let priceString = String(price)
        let attributedString = NSMutableAttributedString(string: "Сумма заказа \(priceString) c")
        label.font = UIFont.ttBold(ofSize: 20)
        
        let biggerAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.ttBold(ofSize: 24),
            .foregroundColor: UIColor.black
        ]
        
        attributedString.addAttributes(biggerAttributes, range: NSRange(location: 13, length: priceString.count))
        
        label.attributedText = attributedString
        
        return label
    }()

    lazy var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Заказать доставку", for: .normal)
        button.setTitleColor(UIColor(hex: "#ACABAD"), for: .normal)
        button.backgroundColor = UIColor(hex: "##F8F8F8")
        button.titleLabel?.font = UIFont.interSemiBold(ofSize: 16)
        button.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(backButton)
        addSubview(numberTextField)
        addSubview(adressTextField)
        addSubview(orientierTextField)
        addSubview(commentTextField)
        addSubview(sumLabel)
        addSubview(orderButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 57))
            make.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 57))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.width.equalTo(flexibleWidth(to: 24))
        }
        
        numberTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 112))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 39))
        }
        
        adressTextField.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(flexibleHeight(to: 20))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 39))
        }
        
        orientierTextField.snp.makeConstraints { make in
            make.top.equalTo(adressTextField.snp.bottom).offset(flexibleHeight(to: 20))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 39))
        }
        
        commentTextField.snp.makeConstraints { make in
            make.top.equalTo(orientierTextField.snp.bottom).offset(flexibleHeight(to: 20))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 39))
        }
        
        sumLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 120))
            make.centerX.equalToSuperview()
        }
        
        orderButton.snp.makeConstraints { make in
            make.top.equalTo(sumLabel.snp.bottom).offset(flexibleHeight(to: 16))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 54))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
}
