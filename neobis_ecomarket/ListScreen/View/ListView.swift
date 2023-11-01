//
//  ListView.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 29/10/23.
//

import Foundation
import UIKit
import SnapKit

class ListView: UIView {
    
    var basketCount = 0
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Продукты"
        label.font = UIFont.ttMedium(ofSize: 18)
        label.textColor = .black
        
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon"), for: .normal)
        
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Быстрый поиск"
        searchBar.searchTextField.font = UIFont.ttMedium(ofSize: 16)
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = UIColor(hex: "#F8F8F8")
        
        return searchBar
    }()
    
    lazy var sectionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 12.0
//        layout.minimumLineSpacing = 12.0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    lazy var productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (UIScreen.main.bounds.width - 48 - 16) / 2
        
        layout.itemSize = CGSize(width: itemWidth, height: 228)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.alwaysBounceVertical = true
        view.backgroundColor = .clear
        
        return view
    }()

    lazy var basketButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "#75DB1B")
        button.layer.cornerRadius = UIScreen.main.bounds.height * 25 / 812
        
        return button
    }()
    
    lazy var basketImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "basketImage")
        
        return image
    }()
    
    lazy var basketLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ttMedium(ofSize: 16)
        label.text = "Корзина"
        label.textColor = .white
        label.textAlignment = .center
        
        return label
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
        addSubview(backButton)
        addSubview(searchBar)
        addSubview(sectionCollectionView)
        addSubview(productCollectionView)
        addSubview(basketButton)
        addSubview(basketImage)
        addSubview(basketLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 57))
            make.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 54))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.width.equalTo(flexibleWidth(to: 24))
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 100))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 8))
            make.height.equalTo(flexibleHeight(to: 44))
        }
        
        sectionCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 160))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 27))
        }
        
        productCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 211))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview()
        }
        
        basketButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 714))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 191))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 50))
        }
        
        basketImage.snp.makeConstraints { make in
            make.top.bottom.equalTo(basketButton).inset(flexibleHeight(to: 12))
            make.leading.equalTo(basketButton.snp.leading).inset(flexibleWidth(to: 16))
            make.trailing.equalTo(basketButton.snp.trailing).inset(flexibleWidth(to: 128))
        }
        
        basketLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(basketButton).inset(flexibleHeight(to: 12))
            make.leading.equalTo(basketImage.snp.trailing).offset(flexibleWidth(to: 4))
            make.trailing.equalTo(basketButton.snp.trailing).inset(flexibleWidth(to: 16))
        }
    }
}
