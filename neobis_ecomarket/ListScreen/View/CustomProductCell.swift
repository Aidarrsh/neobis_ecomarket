//
//  CustomProductCell.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 30/10/23.
//

import Foundation
import UIKit
import SnapKit

class CustomProductCell: UICollectionViewCell {
    
    var productCount = 0
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#F8F8F8")
        view.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        
        return view
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = UIScreen.main.bounds.height * 12 / 812
        image.clipsToBounds = true
        
        return image
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ttMedium(ofSize: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Яблоки с этим, с этим, с куриным бульоном"
        
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "56"
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
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIScreen.main.bounds.height * 12 / 812
        button.setTitle("Добавить", for: .normal)
        button.titleLabel?.font = UIFont.ttMedium(ofSize: 16)
        button.backgroundColor = UIColor(hex: "#75DB1B")
        
        return button
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.backgroundColor = UIColor(hex: "#75DB1B")
        button.tintColor = UIColor.white
        button.isHidden = true
        
        return button
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = UIColor(hex: "#75DB1B")
        button.tintColor = UIColor.white
        button.isHidden = true
        
        return button
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "\(productCount)"
        label.font = UIFont.ttMedium(ofSize: 18)
        label.isHidden = true
        
        return label
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
        contentView.addSubview(backView)
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(currencyLabel)
        contentView.addSubview(addButton)
        contentView.addSubview(minusButton)
        contentView.addSubview(plusButton)
        contentView.addSubview(countLabel)
    }
    
    func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 4))
            make.top.equalToSuperview().inset(flexibleHeight(to: 4))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 128))
            
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).inset(flexibleHeight(to: 4))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 4))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 90))
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(flexibleHeight(to: 24))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 4))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 52))
        }
        
        currencyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(flexibleHeight(to: 28))
            make.leading.equalTo(priceLabel.snp.trailing).offset(flexibleWidth(to: 2))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 52))
        }
        
        addButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 4))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 4))
            make.top.equalToSuperview().inset(flexibleHeight(to: 192))
        }
        
        minusButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(flexibleWidth(to: 4))
            make.bottom.equalToSuperview().inset(4)
            make.height.width.equalTo(flexibleHeight(to: 32))
        }
        
        plusButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 4))
            make.bottom.equalToSuperview().inset(4)
            make.height.width.equalTo(flexibleHeight(to: 32))
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(plusButton.snp.centerY)
            make.centerX.equalToSuperview()
        }
    }
}
