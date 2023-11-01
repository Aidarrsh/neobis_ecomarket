//
//  CustomMainViewCell.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 27/10/23.
//

import Foundation
import UIKit
import SnapKit

class CustomMainViewCell: UICollectionViewCell {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        button.layer.masksToBounds = true
        
        return button
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        image.clipsToBounds = true
        
        return image
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ttBold(ofSize: 20)
        label.textColor = .white
        label.lineBreakMode = .byClipping
        label.numberOfLines = 2
        return label
    }()

    lazy var gradient: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        
        return layer
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
        contentView.addSubview(image)
        gradient.frame = contentView.bounds
        contentView.layer.addSublayer(gradient)
        contentView.addSubview(button)
        contentView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 110))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 12))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 12))
        }
    }
}
