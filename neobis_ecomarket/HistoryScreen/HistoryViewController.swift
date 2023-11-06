//
//  HistoryViewController.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 4/11/23.
//

import UIKit
import SnapKit

class HistoryViewController: UIViewController {
    private let contentView = HistoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}
