//
//  HistoryView.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 4/11/23.
//

import Foundation
import UIKit
import SnapKit

class HistoryView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "История заказов"
        label.font = UIFont.ttMedium(ofSize: 18)
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 57))
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(flexibleHeight(to: 10))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 90))
        }
    }
}
