import Foundation
import UIKit
import SnapKit
import PayBoxSdk

class PaymentViewController: UIViewController, WebDelegate {
    
    func loadStarted() {
        print("Loading started")
    }
    
    func loadFinished() {
        print("Loading finished")
    }
    
    let sdk = PayboxSdk.initialize(merchantId: 503623, secretKey: "UnPLLvWsuXPyC3wd")
    
    lazy var paymentView: PaymentView = {
        let view = PaymentView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        view.autoresizesSubviews = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPaymentView()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initPayment()
    }
    
    func setupView() {
        view.backgroundColor = .purple
        view.addSubview(paymentView)
        view.addSubview(backButton)
        
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        navigationController?.navigationBar.isUserInteractionEnabled = false
        navigationController?.navigationBar.isHidden = true
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 57))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.width.equalTo(flexibleWidth(to: 24))
        }
        
        paymentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupPaymentView() {
        //Тестовый режим:
        sdk.config().testMode(enabled: true) // По умолчанию тестовый режим включен
        //Выбор региона
        sdk.config().setRegion(region: .DEFAULT) // .DEAFAULT по умолчанию
        //Выбор платежной системы:
        sdk.config().setPaymentSystem(paymentSystem: .NONE)
        //Выбор валюты платежа:
        sdk.config().setCurrencyCode(code: "KGS")
        //Активация автоклиринга:
        sdk.config().autoClearing(enabled: true)
        //Установка кодировки:
        sdk.config().setEncoding(encoding: "UTF-8") // по умолчанию UTF-8
        //Время жизни рекурентного профиля:
        sdk.config().setRecurringLifetime(lifetime: 0) //по умолчанию 0 месяцев
        //Время жизни платежной страницы, в течение которого платеж должен быть завершен:
        sdk.config().setPaymentLifetime(lifetime: 300)  //по умолчанию 300 секунд
        //Включение режима рекурентного платежа:
        sdk.config().recurringMode(enabled: false)  //по умолчанию отключен
        //Номер телефона клиента, будет отображаться на платежной странице. Если не указать, то будет предложено ввести на платежной странице:
        sdk.config().setUserPhone(userPhone: "")
        //Email клиента, будет отображаться на платежной странице. Если не указать email, то будет предложено ввести на платежной странице:
        sdk.config().setUserEmail(userEmail: "")
        //Язык платежной страницы:
        sdk.config().setLanguage(language: .ru)
        //Для передачи информации от платежного гейта:
        sdk.config().setCheckUrl(url: "https://yoursite.kg")
        sdk.config().setResultUrl(url: "https://yoursite.kg")
        sdk.config().setRefundUrl(url: "https://yoursite.kg")
        sdk.config().setClearingUrl(url: "https://yoursite.kg")
        sdk.config().setRequestMethod(requestMethod: .POST)
        
        //Для отображения Frame вместо платежной страницы
        sdk.config().setFrameRequired(isRequired: true) //false по умолчанию
        
        //Передайте экземпляр paymentView в sdk:
        sdk.setPaymentView(paymentView: paymentView)
        
        //Для отслеживания прогресса загрузки платежной страницы используйте WebDelegate:
        paymentView.delegate = self
    }
    
    func initPayment() {
        let amount: Float = 100
        let description = "some description"
        let orderId = "1234"
        let userId = "1234"
        
        sdk.createPayment(amount: amount, description: description, orderId: orderId, userId: userId, extraParams: nil) { payment, error in
            if let error = error {
                print("Payment initialization error: \(error)")
                return
            }
            if let payment = payment {
                print("Payment initialized: \(payment.paymentId)")
            }
        }
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}
