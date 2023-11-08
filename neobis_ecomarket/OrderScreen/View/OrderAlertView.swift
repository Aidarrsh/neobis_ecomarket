//
//  OrderAlertView.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 8/11/23.
//

import Foundation
import UIKit
import SnapKit

class OrderAlertView: UIView {
    
    let orderText: String
    let timeText: String
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = UIScreen.main.bounds.height * 20 / 812
        
        return view
    }()
    
    lazy var alertImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "orderAlert")
        
        return image
    }()
    
    lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ttBold(ofSize: 24)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.text = "Заказ № \(orderText) оформлен"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#ACABAD")
        label.font = UIFont.interSemiBold(ofSize: 16)
        label.text = "Дата и время \(timeText)"
        
        return label
    }()
    
    lazy var quitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти в магазин", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#75DB1B")
        button.titleLabel?.font = UIFont.interSemiBold(ofSize: 16)
        button.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        
        return button
    }()
    
    init(orderText: String, timeText: String) {
        self.orderText = orderText
        self.timeText = timeText
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(backView)
        addSubview(alertImage)
        addSubview(orderLabel)
        addSubview(timeLabel)
        addSubview(quitButton)
    }
    
    func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        alertImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 36))
            make.centerX.equalToSuperview()
            make.height.equalTo(flexibleHeight(to: 200))
            make.width.equalTo(flexibleWidth(to: 163))
        }
        
        orderLabel.snp.makeConstraints { make in
            make.top.equalTo(alertImage.snp.bottom).offset(flexibleHeight(to: 28))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(orderLabel.snp.bottom).offset(flexibleHeight(to: 12))
            make.centerX.equalToSuperview()
        }
        
        quitButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 24))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 54))
        }
    }
}
