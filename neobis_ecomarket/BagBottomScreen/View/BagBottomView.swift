//
//  BagBottomView.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 4/11/23.
//

import Foundation
import UIKit
import SnapKit

class BagBottomView: UIView {
    
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

        addSubview(tableView)
        addSubview(orderButton)
    }

    func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(flexibleHeight(to: 36))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview()
        }
        
        orderButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 50))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 54))
        }
    }
}
