//
//  InfoView.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 1/11/23.
//

import Foundation
import UIKit
import SnapKit

class InfoView: UIView {
    
    lazy var wrapView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.clipsToBounds = true
        view.contentInsetAdjustmentBehavior = .never
        view.contentInset.bottom = UIScreen.main.bounds.height + 90
        
        return view
    }()
    
    lazy var infoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "infoImage")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Инфо"
        label.font = UIFont.ttMedium(ofSize: 18)
        label.textColor = .white
        
        return label
    }()
    
    lazy var subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.ttBold(ofSize: 24)
        label.textColor = .black
        label.text = "Эко Маркет"
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ttRegular(ofSize: 16)
        label.textColor = UIColor(hex: "#ACABAD")
        label.text = "Фрукты, овощи, зелень, сухофрукты а так же сделанные из натуральных ЭКО продуктов (варенье, салаты, соления, компоты и т.д.) можете заказать удобно, качественно и по доступной цене.\nГотовы сотрудничать взаимовыгодно с магазинами. \nНаши цены как на рынке.\nМы заинтересованы в экономии ваших денег и времени.\nСтоимость доставки 150 сом и ещё добавлен для окраину города.\nПри отказе подтвержденного заказа более\n2-х раз Клиент заносится в чёрный список!!"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    lazy var callButton: UIButton = {
        let button = UIButton ()
        button.backgroundColor = UIColor(hex: "F8F8F8")
        button.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        
        return button
    }()
    
    lazy var callLabel: UILabel = {
        let label = UILabel()
        label.text = "Позвонить"
        label.textColor = .black
        label.font = UIFont.interSemiBold(ofSize: 16)
        
        return label
    }()
    
    lazy var callImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "callImage")
        
        return image
    }()
    
    lazy var whatsAppButton: UIButton = {
        let button = UIButton ()
        button.backgroundColor = UIColor(hex: "F8F8F8")
        button.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        
        return button
    }()
    
    lazy var whatsAppLabel: UILabel = {
        let label = UILabel()
        label.text = "WhatsApp"
        label.textColor = .black
        label.font = UIFont.interSemiBold(ofSize: 16)
        
        return label
    }()
    
    lazy var whatsAppImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "whatsappImage")
        
        return image
    }()
    
    lazy var instagramButton: UIButton = {
        let button = UIButton ()
        button.backgroundColor = UIColor(hex: "F8F8F8")
        button.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        
        return button
    }()
    
    lazy var instagramLabel: UILabel = {
        let label = UILabel()
        label.text = "Instagram"
        label.textColor = .black
        label.font = UIFont.interSemiBold(ofSize: 16)
        
        return label
    }()
    
    lazy var instagramImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "instagramImage")
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(wrapView)
        wrapView.addSubview(infoImage)
        wrapView.addSubview(titleLabel)
        wrapView.addSubview(subTitle)
        wrapView.addSubview(descriptionLabel)
        wrapView.addSubview(callButton)
        wrapView.addSubview(callImage)
        wrapView.addSubview(callLabel)
        wrapView.addSubview(whatsAppButton)
        wrapView.addSubview(whatsAppImage)
        wrapView.addSubview(whatsAppLabel)
        wrapView.addSubview(instagramButton)
        wrapView.addSubview(instagramImage)
        wrapView.addSubview(instagramLabel)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        wrapView.snp.makeConstraints { make in
            make.height.equalTo(scrollView.snp.height)
            make.width.equalTo(scrollView.snp.width)
        }
        
        infoImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(flexibleHeight(to: 270))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 57))
            make.centerX.equalToSuperview()
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(infoImage.snp.bottom).offset(flexibleHeight(to: 16))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(flexibleHeight(to: 8))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
        }
        
        callButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(flexibleHeight(to: 33))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 54))
        }
        
        callImage.snp.makeConstraints { make in
            make.centerY.equalTo(callButton)
            make.leading.equalTo(callButton.snp.leading).inset(flexibleWidth(to: 113))
            make.trailing.equalTo(callButton.snp.trailing).inset(flexibleWidth(to: 206))
        }
        
        callLabel.snp.makeConstraints { make in
            make.centerY.equalTo(callButton)
            make.leading.equalTo(callImage.snp.trailing).offset(flexibleWidth(to: 8))
        }
        
        whatsAppButton.snp.makeConstraints { make in
            make.top.equalTo(callButton.snp.bottom).offset(flexibleHeight(to: 12))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 54))
        }
        
        whatsAppImage.snp.makeConstraints { make in
            make.centerY.equalTo(whatsAppButton)
            make.leading.equalTo(whatsAppButton.snp.leading).inset(flexibleWidth(to: 113))
            make.trailing.equalTo(whatsAppButton.snp.trailing).inset(flexibleWidth(to: 206))
        }
        
        whatsAppLabel.snp.makeConstraints { make in
            make.centerY.equalTo(whatsAppButton)
            make.leading.equalTo(whatsAppImage.snp.trailing).offset(flexibleWidth(to: 8))
        }
        
        instagramButton.snp.makeConstraints { make in
            make.top.equalTo(whatsAppButton.snp.bottom).offset(flexibleHeight(to: 12))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 54))
        }
        
        instagramImage.snp.makeConstraints { make in
            make.centerY.equalTo(instagramButton)
            make.leading.equalTo(instagramButton.snp.leading).inset(flexibleWidth(to: 113))
            make.trailing.equalTo(instagramButton.snp.trailing).inset(flexibleWidth(to: 206))
        }
        
        instagramLabel.snp.makeConstraints { make in
            make.centerY.equalTo(instagramButton)
            make.leading.equalTo(instagramImage.snp.trailing).offset(flexibleWidth(to: 8))
        }
    }
}
