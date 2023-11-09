//
//  InfoViewController.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 1/11/23.
//

import UIKit
import SnapKit
import Reachability

class InfoViewController: UIViewController {
    let alertView = MainAlertView()
    var blurEffectView: UIVisualEffectView?
    let reachability = try! Reachability()
    
    private let contentView = InfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkConnection()
        setupView()
        addTargets()
    }
    
    override var preferredStatusBarStyle:  UIStatusBarStyle {
        .lightContent
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
    
    func setupView() {
        view.addSubview(contentView)
        navigationController?.navigationBar.isUserInteractionEnabled = false
        navigationController?.navigationBar.isHidden = true
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {
        contentView.callButton.addTarget(self, action: #selector(callButtonPressed), for: .touchUpInside)
        contentView.whatsAppButton.addTarget(self, action: #selector(whatsAppButtonPressed), for: .touchUpInside)
        contentView.instagramButton.addTarget(self, action: #selector(instagramButtonPressed), for: .touchUpInside)
    }
    
    @objc func callButtonPressed() {
        if let phoneURL = URL(string: "tel://0500636241") {
            UIApplication.shared.open(phoneURL)
        }
    }

    @objc func whatsAppButtonPressed() {
        if let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=+996500636247") {
            UIApplication.shared.open(whatsappURL)
        }
    }

    @objc func instagramButtonPressed() {
        if let instagramURL = URL(string: "https://www.instagram.com/neobis.club/?utm_source=ig_web_button_share_sheet&igshid=OGQ5ZDc2ODk2ZA==") {
            UIApplication.shared.open(instagramURL)
        }
    }

    
    @objc func quitButtonPressed() {
        blurEffectView?.removeFromSuperview()
        alertView.removeFromSuperview()
    }
}
