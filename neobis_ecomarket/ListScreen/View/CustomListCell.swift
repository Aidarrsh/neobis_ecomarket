//
//  CustomListCell.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 29/10/23.
//

import Foundation
import UIKit
import SnapKit

class CustomListCell: UICollectionViewCell {
    
    var buttonPressed = false
    
    lazy var roundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = UIScreen.main.bounds.width * 13.5 / 375
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hex: "D2D1D5").cgColor
        
        return view
    }()
    
    lazy var productButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont.ttMedium(ofSize: 16)
        button.setTitleColor(UIColor(hex: "#D2D1D5"), for: .normal)
        
        return button
    }()
    
    func isButtonPressed() {
        roundView.layer.borderColor = UIColor(hex: "#75DB1B").cgColor
        roundView.backgroundColor = UIColor(hex: "#75DB1B")
        productButton.setTitleColor(.white, for: .normal)
    }
    
    func unpressButton() {
        roundView.layer.borderColor = UIColor(hex: "#D2D1D5").cgColor
        roundView.backgroundColor = .clear
        productButton.setTitleColor(UIColor(hex: "#D2D1D5"), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        addSubview(roundView)
        addSubview(productButton)
        
        productButton.snp.updateConstraints { make in
            make.edges.equalToSuperview()
            
        }
        
        roundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.trailing.equalTo(productButton.snp.leading).offset(flexibleWidth(to: 12))
        }
        
        productButton.gestureRecognizers?.forEach(productButton.removeGestureRecognizer)

        // Or remove the specific gesture recognizer
        if let longPressRecognizer = productButton.gestureRecognizers?.first(where: { $0 is UILongPressGestureRecognizer }) {
            productButton.removeGestureRecognizer(longPressRecognizer)
        }

    }
}
