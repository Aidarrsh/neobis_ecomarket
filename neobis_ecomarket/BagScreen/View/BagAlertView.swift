//
//  BagAlertView.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 9/11/23.
//

import Foundation
import UIKit
import SnapKit

class BagAlertView: UIView {
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = UIScreen.main.bounds.height * 20 / 812
        
        return view
    }()
    
    lazy var alertImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bagAlert-3")
        
        return image
    }()
    
    lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.text = "Заказ может быть при\nпокупке свыше 300 с"
        label.font = UIFont.ttBold(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var quitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Oк", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#75DB1B")
        button.titleLabel?.font = UIFont.interSemiBold(ofSize: 16)
        button.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        
        return button
    }()
    
    override func layoutSubviews() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(backView)
        addSubview(alertImage)
        addSubview(alertLabel)
        addSubview(quitButton)
    }
    
    func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        alertImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 36))
            make.centerX.equalToSuperview()
            make.height.equalTo(flexibleHeight(to: 163))
            make.width.equalTo(flexibleWidth(to: 200))
        }
        
        alertLabel.snp.makeConstraints { make in
            make.top.equalTo(alertImage.snp.bottom).offset(flexibleHeight(to: 28))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
        }
        
        quitButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 24))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 54))
        }
    }
}

