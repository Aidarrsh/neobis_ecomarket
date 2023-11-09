//
//  MainAlertView.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 9/11/23.
//

import Foundation
import UIKit
import SnapKit

class MainAlertView: UIView {
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = UIScreen.main.bounds.height * 20 / 812
        
        return view
    }()
    
    lazy var alertImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "networkAlert")
        
        return image
    }()
    
    lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.text = "Отсутствует интернет\nсоединение"
        label.font = UIFont.ttBold(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Попробуйте подключить мобильный\nинтернет"
        label.font = UIFont.ttRegular(ofSize: 18)
        label.textColor = UIColor(hex: "#ACABAD")
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
        addSubview(descriptionLabel)
        addSubview(quitButton)
    }
    
    func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        alertImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 24))
            make.centerX.equalToSuperview()
            make.height.equalTo(flexibleHeight(to: 224))
            make.width.equalTo(flexibleWidth(to: 224))
        }
        
        alertLabel.snp.makeConstraints { make in
            make.top.equalTo(alertImage.snp.bottom).offset(flexibleHeight(to: 16))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(alertLabel.snp.bottom).offset(flexibleHeight(to: 8))
            make.centerX.equalToSuperview()
        }
        
        quitButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 24))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 54))
        }
    }
}

