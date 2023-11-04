//
//  BagView.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 2/11/23.
//

import Foundation
import UIKit
import SnapKit

class BagView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ttMedium(ofSize: 18)
        label.textColor = .black
        label.text = "Корзина"
        
        return label
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.ttMedium(ofSize: 18)
        
        return button
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(CustomBagCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        return view
    }()
    
    lazy var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Оформить заказ", for: .normal)
        button.backgroundColor = UIColor(hex: "#75DB1B")
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
        addSubview(clearButton)
        addSubview(tableView)
        addSubview(orderButton)
    }

    func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 57))
            make.centerX.equalToSuperview()
            make.height.equalTo(flexibleHeight(to: 18))
        }
        
        clearButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 57))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 18))
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(flexibleHeight(to: 37))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview()
        }
        
        orderButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 652))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 54))
        }
    }
}
