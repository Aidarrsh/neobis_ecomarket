//
//  CustomHistoryBottomCell.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 9/11/23.
//

import Foundation
import UIKit
import SnapKit

class CustomHistoryBottomCell: UITableViewCell {
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#F8F8F8")
        view.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        
        return view
    }()
    
    lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "applesImage")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = UIScreen.main.bounds.height * 8 / 812

        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Яблоко"
        label.font = UIFont.ttMedium(ofSize: 16)
        
        return label
    }()
    
    lazy var priceOneLabel: UILabel = {
        let label = UILabel()
        label.text = "Цена 56 с за шт"
        label.font = UIFont.ttMedium(ofSize: 14)
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
    
    lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "1 шт"
        label.textColor = UIColor(hex: "#ACABAD")
        label.font = UIFont.ttMedium(ofSize: 12)
        
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
        addSubview(backView)
        addSubview(productImage)
        addSubview(titleLabel)
        addSubview(priceOneLabel)
        addSubview(priceLabel)
        addSubview(currencyLabel)
        addSubview(quantityLabel)
    }
    
    func setupConstraints() {
        
        backView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 8))
        }
        
        productImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 13))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 12))
            make.height.width.equalTo(flexibleHeight(to: 43))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 15.5))
            make.leading.equalTo(productImage.snp.trailing).offset(flexibleWidth(to: 8))
        }
        
        priceOneLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(flexibleHeight(to: 2))
            make.leading.equalTo(productImage.snp.trailing).offset(flexibleWidth(to: 8))
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 17))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 22))
        }
        
        currencyLabel.snp.makeConstraints { make in
            make.leading.equalTo(priceLabel.snp.trailing).offset(flexibleWidth(to: 2))
            make.top.equalToSuperview().inset(flexibleHeight(to: 23))
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 40))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 12))
        }
    }
}

