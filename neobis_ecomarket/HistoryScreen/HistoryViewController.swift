//
//  HistoryViewController.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 4/11/23.
//

import UIKit
import SnapKit
import Reachability

class HistoryViewController: UIViewController {
    
    private let contentView = HistoryView()
    var historyProtocol: HistoryProtocol
    var ordersList = [OrderData]()
    var products = [OrderedProduct]()
    var sectionDates: [String]?
    var groupedOrders = [String: [OrderData]]()
    let alertView = MainAlertView()
    var blurEffectView: UIVisualEffectView?
    let reachability = try! Reachability()

    
    init(historyProtocol: HistoryProtocol) {
        self.historyProtocol = historyProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        checkConnection()
        configureDates()
    }
    
    func checkConnection() {
        DispatchQueue.main.async {

            self.reachability.whenReachable = { reachability in
                if reachability.connection == .wifi {
                    print("Reachable via WiFi")
                    self.blurEffectView?.removeFromSuperview()
                    self.alertView.removeFromSuperview()
                } else {
                    print("Reachable via Cellular")
                    self.blurEffectView?.removeFromSuperview()
                    self.alertView.removeFromSuperview()
                }
            }
            self.reachability.whenUnreachable = { _ in
                self.presentAlert()
            }

            do {
                try self.reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        }
    }
    
    func presentAlert() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView?.alpha = 0.6
        view.addSubview(blurEffectView!)
        view.addSubview(alertView)
        alertView.quitButton.addTarget(self, action: #selector(quitButtonPressed), for: .touchUpInside)

        alertView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(flexibleWidth(to: 343))
            make.height.equalTo(flexibleHeight(to: 458))
        }
        
        alertView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.3) {
            self.alertView.transform = .identity
        }
    }
    
    func fetchData() {
        historyProtocol.fetchOrders() { [weak self] orders in
            guard let self = self else { return }
            self.ordersList = orders
            DispatchQueue.main.async {
                self.contentView.tableView.reloadData()
                self.configureDates()
            }
        }
    }

    
    func setupView() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(CustomHistoryCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func groupOrdersByDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        groupedOrders = [:]
        for order in ordersList {
            let dateComponents = order.created_at.split(separator: " ")[0]
            let dateString = String(dateComponents)
            
            if var existingGroup = groupedOrders[dateString] {
                existingGroup.append(order)
                groupedOrders[dateString] = existingGroup
            } else {
                groupedOrders[dateString] = [order]
            }
        }
        sectionDates = Array(groupedOrders.keys).sorted(by: >)
        DispatchQueue.main.async {
            self.contentView.tableView.reloadData()
        }
    }

    func configureDates() {
        groupOrdersByDate()
        sectionDates?.removeAll()
        sectionDates = Array(groupedOrders.keys).sorted(by: >)
        DispatchQueue.main.async {
            self.contentView.tableView.reloadData()
        }
    }
    
    @objc func quitButtonPressed() {
        blurEffectView?.removeFromSuperview()
        alertView.removeFromSuperview()
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionDates?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dateString = sectionDates?[section] else {
            return 0
        }
        return groupedOrders[dateString]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dateString = sectionDates?[indexPath.section],
              let ordersInSection = groupedOrders[dateString] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomHistoryCell
        
        let order = ordersInSection.reversed()[indexPath.row]
        let doublePrice = Double(order.total_amount)
        cell.priceLabel.text = "\(Int(doublePrice ?? 0) + 150)"
        let timeString = String(order.created_at.suffix(5))
        cell.timeLabel.text = timeString
        cell.titleLabel.text = "Заказ №\(order.order_number)"

        
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let dateString = sectionDates?[section] else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        if let date = dateFormatter.date(from: dateString) {
            if Calendar.current.isDateInToday(date) {
                return "Сегодня"
            } else if Calendar.current.isDateInYesterday(date) {
                return "Вчера"
            } else {
                return dateString
            }
        } else {
            return dateString
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dateString = sectionDates?[indexPath.section],
              let ordersInSection = groupedOrders[dateString] else { return }
        let order = ordersInSection.reversed()[indexPath.row]
        let price = (Int(Double(order.total_amount) ?? 0))
        let bottomSheetVC = HistoryBottomSheet(orderNumber: order.order_number,
                                               orderTime: order.created_at,
                                               price: price,
                                               orderedProducts: order.ordered_products)
        if let sheet = bottomSheetVC.sheetPresentationController {
            sheet.detents = [
                .custom { _ in
                    return UIScreen.main.bounds.height * 562 / 812
                }, .large()
            ]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
        }
        
        present(bottomSheetVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
}
