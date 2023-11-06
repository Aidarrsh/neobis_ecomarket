//
//  BagBottomScreen.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 4/11/23.
//

import Foundation
import UIKit
import SnapKit

class BagBottomSheet: UIViewController {
    private let contentView = BagBottomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(CustomBagCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        setupView()
        addTargets()
    }
    
    func setupView() {
        navigationController?.navigationBar.isUserInteractionEnabled = false
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {
        contentView.orderButton.addTarget(self, action: #selector(orderButtonPressed), for: .touchUpInside)
    }
    
    @objc func orderButtonPressed() {
        let vc = OrderViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
}

extension BagBottomSheet: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomBagCell
        
        let totalRowsInSection = tableView.numberOfRows(inSection: indexPath.section)
        
        if indexPath.row == totalRowsInSection - 1 {
            cell.hideElements()
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
}
