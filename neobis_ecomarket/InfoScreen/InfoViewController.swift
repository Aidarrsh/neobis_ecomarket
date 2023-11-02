//
//  InfoViewController.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 1/11/23.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    private let contentView = InfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override var preferredStatusBarStyle:  UIStatusBarStyle {
        .lightContent
    }
    
    func setupView() {
        view.addSubview(contentView)
        navigationController?.navigationBar.isUserInteractionEnabled = false
        navigationController?.navigationBar.isHidden = true
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}
