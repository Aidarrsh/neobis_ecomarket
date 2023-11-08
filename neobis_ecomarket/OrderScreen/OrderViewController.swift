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
    var blurEffectView: UIVisualEffectView?
    var totalPrice: Int
    var items = [ProductItem]()
    var orderNumber: Int?
    var orderString: String?
    var createdAt: String?
    var bag: BagItem?
    var orderProtocol: OrderProtocol
    
    init(orderProtocol: OrderProtocol,totalPrice: Int, items: [ProductItem]) {
        self.orderProtocol = orderProtocol
        self.totalPrice = totalPrice
        self.items = items
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
        contentView.orderButton.addTarget(self, action: #selector(orderButtonPressed), for: .touchUpInside)
    }

    func presentAlert() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView?.alpha = 0.6
        view.addSubview(blurEffectView!)
        if let orderNumber = orderNumber {
            let orderNumberString = "\(orderNumber)"
            orderString = orderNumberString
        }

        let alertView = OrderAlertView(orderText: orderString ?? "", timeText: createdAt ?? "")
        view.addSubview(alertView)
        alertView.quitButton.addTarget(self, action: #selector(quitButtonPressed), for: .touchUpInside)

        alertView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(flexibleWidth(to: 343))
            make.height.equalTo(flexibleHeight(to: 452))
        }
        
        alertView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.3) {
            alertView.transform = .identity
        }
    }
    
    @objc func quitButtonPressed() {
        deleteValues()
        save(value: 0)
        for product in items {
            product.count = 0
        }
        view.window!.rootViewController?.dismiss(animated: true)
    }

    @objc func backButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func orderButtonPressed() {
        if isButtonActive == true {
            guard let phoneNumber = contentView.numberTextField.text else { return }
            guard let address = contentView.adressTextField.text else { return }
            guard let referencePoint = contentView.orientierTextField.text else { return }
            guard let comments = contentView.commentTextField.text else { return }
            
            orderProtocol.order(products: items, phone_number: phoneNumber, adress: address, reference_point: referencePoint, comments: comments) { [weak self] result in
                switch result {
                case .success(let json):
                    self?.orderNumber = json["order_number"] as? Int
                    self?.createdAt = json["created_at"] as? String
                    DispatchQueue.main.async {
                        self?.presentAlert()
                    }
                case .failure(let error):
                    print("Error ordering: \(error)")
                }
            }
        }
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
