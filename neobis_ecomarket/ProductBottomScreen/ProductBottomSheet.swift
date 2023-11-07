//
//  ProductBottomSheet.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 31/10/23.
//

import Foundation
import UIKit
import SnapKit
import CoreData

protocol ProductBottomSheetDelegate: AnyObject {
    func bottomSheetDismissed()
}

class ProductBottomSheet: UIViewController {
    
    weak var delegate: ProductBottomSheetDelegate?
    var priceCount = 0
    var count = 0
    let id: Int
    var productItems = [ProductItem]()
    var bag: BagItem?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.bottomSheetDismissed()
    }
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "applesImage")
        image.layer.cornerRadius = UIScreen.main.bounds.height * 12 / 812
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var productLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ttBold(ofSize: 24)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Яблоки с этим, с этим, с куриным бульоном"
        
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ttBold(ofSize: 24)
        label.textColor = UIColor(hex: "#75DB1B")
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "56 с шт"
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ttMedium(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor(hex: "ACABAD")
        label.text = "Cочный плод яблони, который употребляется в пищу в свежем и запеченном виде, служит сырьём в кулинарии и для приготовления напитков."
        
        return label
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#F8F8F8")
        
        return view
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        button.setTitle("Добавить", for: .normal)
        button.titleLabel?.font = UIFont.interSemiBold(ofSize: 16)
        button.backgroundColor = UIColor(hex: "#75DB1B")
//        button.isHidden = true
        
        return button
    }()
    
    lazy var priceCountLabel: UILabel = {
        let label = UILabel()
        label.text = "\(priceCount) c"
        label.font = UIFont.ttBold(ofSize: 24)
        label.textColor = .black
        label.isHidden = true
        
        return label
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
        label.text = "\(count)"
        label.font = UIFont.ttMedium(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.isHidden = true
        
        return label
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
        fetchData()
        addTargets()
    }
    
    func setupViews() {
        view.addSubview(image)
        view.addSubview(productLabel)
        view.addSubview(priceLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(backgroundView)
        view.addSubview(addButton)
        view.addSubview(priceCountLabel)
        view.addSubview(plusButton)
        view.addSubview(minusButton)
        view.addSubview(countLabel)
    }
    
    func setupConstraints() {
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 4))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 208))
        }
        
        productLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(flexibleHeight(to: 12))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 60))
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productLabel.snp.bottom).offset(flexibleHeight(to: 8))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 24))
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(flexibleHeight(to: 8))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 76))
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(flexibleHeight(to: 12))
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.top).inset(flexibleHeight(to: 12))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 54))
        }
        
        priceCountLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.top).inset(flexibleHeight(to: 29))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 24))
        }
        
        minusButton.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.top).inset(flexibleHeight(to: 25))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 142))
            make.height.width.equalTo(flexibleHeight(to: 32))
        }
        
        plusButton.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.top).inset(flexibleHeight(to: 25))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.width.equalTo(flexibleHeight(to: 32))
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(minusButton.snp.centerY)
            make.leading.equalTo(minusButton.snp.trailing)
            make.trailing.equalTo(plusButton.snp.leading)
        }
    }
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<ProductItem> = ProductItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            productItems = try context.fetch(fetchRequest)
            productItems.sort { $0.title ?? "" < $1.title ?? "" }
            
            if let product = productItems.first {
                if let photoURLString = product.image, let photoURL = URL(string: photoURLString) {
                    image.kf.setImage(with: photoURL) { result in }
                }
                productLabel.text = product.title
                if let priceString = product.price, let price = Double(priceString) {
                    let priceWithoutDecimal = Int(price)
                    priceLabel.text = "\(priceWithoutDecimal) c"
                } else {
                    priceLabel.text = "N/A"
                }
                descriptionLabel.text = product.descr
                if product.count != 0 {
                    addButton.isHidden = true
                    plusButton.isHidden = false
                    minusButton.isHidden = false
                    countLabel.isHidden = false
                    priceCountLabel.isHidden = false
                    countLabel.text = "\(product.count)"
                    count = Int(product.count)
                }
                if let priceString = product.price, let price = Double(priceString) {
                    priceCount = Int(Double(product.count) * price)
                    priceCountLabel.text = "\(priceCount) c"
                } else {
                    print("Could not convert product.price to Double")
                }
            }
            
        } catch {
            print("Error fetching data: \(error)")
        }
        
        let fetchBagRequest: NSFetchRequest<BagItem> = BagItem.fetchRequest()
        
        do {
            bag = try context.fetch(fetchBagRequest).first
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func addTargets() {
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonPressed), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
    }
    
    @objc func addButtonPressed() {
        count += 1
        
        countLabel.text = "\(count)"
        addButton.isHidden = true
        plusButton.isHidden = false
        minusButton.isHidden = false
        countLabel.isHidden = false
        priceCountLabel.isHidden = false
        if let product = productItems.first {
            product.count += 1
//            print(product.count)
            
            if let priceString = product.price, let price = Double(priceString) {
                bag?.sumPrice += Int32(price)
                priceCount = Int(Double(product.count) * price)
                priceCountLabel.text = "\(priceCount) c"
            } else {
                print("Could not convert product.price to Double")
            }
        }
    }
    
    @objc func plusButtonPressed() {
        if count < 50 {
            count += 1
            
            countLabel.text = "\(count)"
            addButton.isHidden = true
            plusButton.isHidden = false
            minusButton.isHidden = false
            countLabel.isHidden = false
            if let priceText = priceLabel.text, let price = Int(priceText) {
                priceCount += price
            }
            if let product = productItems.first {
                product.count += 1
                if let priceString = product.price, let price = Double(priceString) {
                    bag?.sumPrice += Int32(price)
                    priceCount = Int(Double(product.count) * price)
                    priceCountLabel.text = "\(priceCount) c"
                } else {
                    print("Could not convert product.price to Double")
                }
            }
        }
    }
    
    @objc func minusButtonPressed() {
        count -= 1
        
        countLabel.text = "\(count)"
        if let priceText = priceLabel.text, let price = Int(priceText) {
            priceCount += price
        }
        if let product = productItems.first {
            product.count -= 1
            if let priceString = product.price, let price = Double(priceString) {
                bag?.sumPrice -= Int32(price)
                priceCount = Int(Double(product.count) * price)
                priceCountLabel.text = "\(priceCount) c"
            } else {
                print("Could not convert product.price to Double")
            }
        }
        
        if count == 0 {
            addButton.isHidden = false
            plusButton.isHidden = true
            minusButton.isHidden = true
            countLabel.isHidden = true
            priceCountLabel.isHidden = true
        }
    }
}
