//
//  CustomBagCell.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 2/11/23.
//

import Foundation
import UIKit
import SnapKit

class CustomBagCell: UITableViewCell {
    
    var price = 0
    var productCount = 1
    var sum: Int {
        return price * productCount
    }
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#F8F8F8")
        view.layer.cornerRadius = UIScreen.main.bounds.height * 12 / 812
        
        return view
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "dragonFruitImage")
        image.clipsToBounds = true
        image.layer.cornerRadius = UIScreen.main.bounds.height * 8 / 812
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        if let image = UIImage(named: "trashImage") {
            let scaledImage = image.resized(to: CGSize(width: 24, height: 24))
            button.setImage(scaledImage, for: .normal)
        }
        button.layer.cornerRadius = UIScreen.main.bounds.height * 6 / 812
        button.backgroundColor = .white
        
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Драконий фрукт"
        label.font = UIFont.ttMedium(ofSize: 14)
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Цена \(price) с за шт"
        label.font = UIFont.ttMedium(ofSize: 12)
        label.textColor = UIColor(hex: "#ACABAD")
        
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "340"
        label.font = UIFont.ttBold(ofSize: 20)
        label.textColor = UIColor(hex: "#75DB1B")
        
        return label
    }()
    
    lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "c"
        label.font = UIFont.ttBold(ofSize: 14)
        label.textColor = UIColor(hex: "#75DB1B")
        
        return label
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.backgroundColor = UIColor(hex: "#75DB1B")
        button.tintColor = UIColor.white
        
        return button
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = UIColor(hex: "#75DB1B")
        button.tintColor = UIColor.white
        
        return button
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "\(productCount)"
        label.font = UIFont.ttMedium(ofSize: 18)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var sumLabel: UILabel = {
        let label = UILabel()
        label.text = "Сумма"
        label.textColor = UIColor(hex: "#ACABAD")
        label.font = UIFont.ttMedium(ofSize: 16)
        label.isHidden = true
        
        return label
    }()
    
    lazy var sumLabelCount: UILabel = {
        let label = UILabel()
        label.text = "\(sum) c"
        label.textColor = .black
        label.font = UIFont.ttMedium(ofSize: 16)
        label.isHidden = true
        
        return label
    }()
    
    lazy var deliverLabel: UILabel = {
        let label = UILabel()
        label.text = "Доставка"
        label.textColor = UIColor(hex: "#ACABAD")
        label.font = UIFont.ttMedium(ofSize: 16)
        label.isHidden = true
        
        return label
    }()
    
    lazy var deliverLabelCount: UILabel = {
        let label = UILabel()
        label.text = "150 c"
        label.textColor = .black
        label.font = UIFont.ttMedium(ofSize: 16)
        label.isHidden = true
        
        return label
    }()
    
    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Итого"
        label.textColor = UIColor(hex: "#ACABAD")
        label.font = UIFont.ttMedium(ofSize: 16)
        label.isHidden = true
        
        return label
    }()
    
    lazy var totalLabelCount: UILabel = {
        let label = UILabel()
        label.text = "\(sum + 150) c"
        label.textColor = .black
        label.font = UIFont.ttMedium(ofSize: 16)
        label.isHidden = true
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(backView)
        contentView.addSubview(image)
        contentView.addSubview(deleteButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(sumLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(currencyLabel)
        contentView.addSubview(minusButton)
        contentView.addSubview(plusButton)
        contentView.addSubview(countLabel)
        
        contentView.addSubview(sumLabelCount)
        contentView.addSubview(deliverLabel)
        contentView.addSubview(deliverLabelCount)
        contentView.addSubview(totalLabel)
        contentView.addSubview(totalLabelCount)
    }
    
    func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(flexibleHeight(to: 94))
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.top).offset(flexibleHeight(to: 4))
            make.leading.equalTo(backView.snp.leading).offset(flexibleWidth(to: 4))
            make.height.equalTo(flexibleHeight(to: 86))
            make.width.equalTo(flexibleWidth(to: 98))
        }
        
        deleteButton.snp.makeConstraints { make in
            make.leading.equalTo(backView.snp.leading).offset(flexibleWidth(to: 6))
            make.bottom.equalTo(backView.snp.bottom).inset(flexibleHeight(to: 6))
            make.height.width.equalTo(flexibleWidth(to: 32))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(flexibleWidth(to: 8))
            make.top.equalTo(backView.snp.top).inset(flexibleHeight(to: 8))
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(flexibleWidth(to: 8))
            make.top.equalTo(titleLabel.snp.bottom).offset(flexibleHeight(to: 4))
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backView.snp.bottom).inset(flexibleHeight(to: 8))
            make.leading.equalTo(image.snp.trailing).offset(flexibleWidth(to: 8))
        }
        
        currencyLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backView.snp.bottom).inset(flexibleHeight(to: 8))
            make.leading.equalTo(priceLabel.snp.trailing).offset(flexibleWidth(to: 2))
        }
        
        minusButton.snp.makeConstraints { make in
            make.bottom.equalTo(backView.snp.bottom).inset(flexibleHeight(to: 4))
            make.trailing.equalTo(backView.snp.trailing).inset(84)
            make.height.width.equalTo(flexibleWidth(to: 32))
        }
        
        plusButton.snp.makeConstraints { make in
            make.bottom.equalTo(backView.snp.bottom).inset(flexibleHeight(to: 4))
            make.trailing.equalTo(backView.snp.trailing).inset(4)
            make.height.width.equalTo(flexibleWidth(to: 32))
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(minusButton.snp.centerY)
            make.leading.equalTo(minusButton.snp.trailing)
            make.trailing.equalTo(plusButton.snp.leading)
        }
        
        sumLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        sumLabelCount.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
        }
        
        deliverLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(sumLabel.snp.bottom).offset(flexibleHeight(to: 8))
        }
        
        deliverLabelCount.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(sumLabel.snp.bottom).offset(flexibleHeight(to: 8))
        }
        
        totalLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(deliverLabel.snp.bottom).offset(flexibleHeight(to: 8))
        }
        
        totalLabelCount.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(deliverLabelCount.snp.bottom).offset(flexibleHeight(to: 8))
        }
    }
    
    func hideElements() {
        backView.isHidden = true
        image.isHidden = true
        deleteButton.isHidden = true
        titleLabel.isHidden = true
        descriptionLabel.isHidden = true
        priceLabel.isHidden = true
        currencyLabel.isHidden = true
        minusButton.isHidden = true
        plusButton.isHidden = true
        countLabel.isHidden = true
        
        sumLabel.isHidden = false
        sumLabelCount.isHidden = false
        deliverLabel.isHidden = false
        deliverLabelCount.isHidden = false
        totalLabel.isHidden = false
        totalLabelCount.isHidden = false
    }
}
