//
//  MainViewController.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 26/10/23.
//

import UIKit
import SnapKit
import CoreData
import Reachability

class MainViewController: UIViewController {
    
    let contentView = MainView()
    var mainProtocol: MainProtocol
    var productItems = [ProductItem]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let reachability = try! Reachability()
    let alertView = MainAlertView()
    var blurEffectView: UIVisualEffectView?
    
    init(mainProtocol: MainProtocol) {
        self.mainProtocol = mainProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkConnection()
        deleteValues()
        save(value: 0)
        setupViews()
        setupConstraints()
        fetchData()
        releaseProducts()
    }
    
    deinit{
        reachability.stopNotifier()
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
        
    func setupViews() {
        view.addSubview(contentView)
        
        contentView.collectionView.register(CustomMainViewCell.self, forCellWithReuseIdentifier: "MyCellReuseIdentifier")
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    let models = [
        Product(image: "fruitsImage", name: "\nФрукты"),
        Product(image: "driedFruitsImage", name: "\nСухофрукты"),
        Product(image: "vegetablesImage", name: "\nОвощи"),
        Product(image: "greensImage", name: "\nЗелень"),
        Product(image: "teaImage", name: "\nЧай кофе"),
        Product(image: "milkImage", name: "Молочные продукты")
    ]
    
    func fetchData() {
        if checkCount() == 0 {
            
            mainProtocol.fetchProducts() { products in
                
            }
        }
        let fetchRequest: NSFetchRequest<ProductItem> = ProductItem.fetchRequest()
        
        do {
            productItems = try context.fetch(fetchRequest)
            contentView.collectionView.reloadData()
            productItems.sort { $0.title ?? "" < $1.title ?? "" }
            
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func releaseProducts() {
        for productItem in productItems {
            productItem.count = 0
        }
    }
    
    @objc func quitButtonPressed() {
        blurEffectView?.removeFromSuperview()
        alertView.removeFromSuperview()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomMainViewCell
        let product = models[indexPath.row]
        cell.image.image = UIImage(named: product.image)
        cell.titleLabel.text = product.name
        cell.button.tag = indexPath.row + 1
        cell.button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func buttonTapped(sender: UIButton) {
        let vc = ListViewController(row: sender.tag)
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
}
