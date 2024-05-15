//
//  OrderBottomSheet.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 11/5/24.
//

import Foundation
import UIKit
import SnapKit

protocol OrderBottomSheetDelegate: AnyObject {
    func didSelectPaymentMethod(usingCard: Bool)
}

class OrderBottomSheet: UIViewController {
    
    weak var delegate: OrderBottomSheetDelegate?
    
    lazy var cardButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor(hex: "#75DB1B")
//        button.layer.borderColor = UIColor(hex: "#75DB1B").cgColor
        
        return button
    }()
    
    lazy var cardLabel: UILabel = {
        let label = UILabel()
        label.text = "Оплата картой"
        label.textColor = .white
        label.font = UIFont.interSemiBold(ofSize: 16)
        
        return label
    }()
    
    lazy var cardImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "creditcard")
        image.sizeToFit()
        image.contentMode = .scaleAspectFit
        image.tintColor = .white
        
        return image
    }()
    
    lazy var cashButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor(hex: "#75DB1B")
//        button.layer.borderColor = UIColor(hex: "#75DB1B").cgColor
        
        return button
    }()
    
    lazy var cashLabel: UILabel = {
        let label = UILabel()
        label.text = "Оплата наличными"
        label.textColor = .white
        label.font = UIFont.interSemiBold(ofSize: 16)
        
        return label
    }()
    
    lazy var cashImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "banknote")
        image.sizeToFit()
        image.contentMode = .scaleAspectFit
        image.tintColor = .white
        
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupButtonTargets()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(cardButton)
        view.addSubview(cardLabel)
        view.addSubview(cardImage)
        view.addSubview(cashButton)
        view.addSubview(cashLabel)
        view.addSubview(cashImage)
        
        cardButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 24))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 48))
        }
        
        cardLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cardButton.snp.centerY)
            make.leading.equalTo(cardButton.snp.leading).offset(flexibleWidth(to: 16))
        }
        
        cardImage.snp.makeConstraints { make in
            make.centerY.equalTo(cardButton.snp.centerY)
            make.trailing.equalTo(cardButton.snp.trailing).inset(flexibleWidth(to: 16))
            make.height.width.equalTo(flexibleWidth(to: 24))
        }
        
        cashButton.snp.makeConstraints { make in
            make.top.equalTo(cardButton.snp.bottom).offset(flexibleHeight(to: 8))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 48))
        }
        
        cashLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cashButton.snp.centerY)
            make.leading.equalTo(cashButton.snp.leading).offset(flexibleWidth(to: 16))
        }
        
        cashImage.snp.makeConstraints { make in
            make.centerY.equalTo(cashButton.snp.centerY)
            make.trailing.equalTo(cashButton.snp.trailing).inset(flexibleWidth(to: 16))
            make.height.width.equalTo(flexibleWidth(to: 24))
        }
    }
    
    private func setupButtonTargets() {
        cardButton.addTarget(self, action: #selector(cardButtonPressed), for: .touchUpInside)
        cashButton.addTarget(self, action: #selector(cashButtonPressed), for: .touchUpInside)
    }

    @objc private func cardButtonPressed() {
        delegate?.didSelectPaymentMethod(usingCard: true)
        dismiss(animated: true, completion: nil)
    }

    @objc private func cashButtonPressed() {
        delegate?.didSelectPaymentMethod(usingCard: false)
        dismiss(animated: true, completion: nil)
    }
}
