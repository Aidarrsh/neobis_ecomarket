//
//  OrderViewController.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 4/11/23.
//

import UIKit
import SnapKit

class OrderViewController: UIViewController {
    
    var isButtonActive = false
    private let contentView = OrderView()
    var totalPrice: Int
    
    init(totalPrice: Int) {
        self.totalPrice = totalPrice
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.price = totalPrice
        setupView()
        addTarges()
    }
    
    func setupView() {
        view.addSubview(contentView)
        navigationController?.navigationBar.isUserInteractionEnabled = false
        contentView.numberTextField.delegate = self
        contentView.adressTextField.delegate = self
        contentView.orientierTextField.delegate = self
        contentView.commentTextField.delegate = self
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTarges() {
        contentView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true)
    }
}

extension OrderViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == contentView.numberTextField {
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet.decimalDigits
            let filteredString = string.filter { allowedCharacters.contains($0.unicodeScalars.first!) }
            let combinedText = (text as NSString).replacingCharacters(in: range, with: filteredString)
            let formattedString = combinedText.chunkFormatted(withSeparator: " ")
            textField.text = formattedString
            checkTextFields()
            
            return false
        }
        checkTextFields()
        return true
    }
    
    func checkTextFields() {
            let numberText = contentView.numberTextField.text ?? ""
            let addressText = contentView.adressTextField.text ?? ""
            let orientierText = contentView.orientierTextField.text ?? ""
            let commentText = contentView.commentTextField.text ?? ""
            
            if !numberText.isEmpty && !addressText.isEmpty && !orientierText.isEmpty && !commentText.isEmpty {
                enableOrderButton()
            } else {
                disableOrderButton()
            }
        }
    
    func enableOrderButton() {
        contentView.orderButton.setTitleColor(.white, for: .normal)
        contentView.orderButton.backgroundColor = UIColor(hex: "#75DB1B")
        isButtonActive = true
    }
    
    func disableOrderButton() {
        contentView.orderButton.setTitleColor(UIColor(hex: "#ACABAD"), for: .normal)
        contentView.orderButton.backgroundColor = UIColor(hex: "##F8F8F8")
        isButtonActive = false
    }
}
