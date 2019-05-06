//
//  ViewController.swift
//  HelloSpace
//
//  Created by Braden Young on 4/12/19.
//  Copyright © 2019 Somewear Labs Inc. All rights reserved.
//

import SomewearCore
import SomewearUI
import RxSwift
import UIKit

class ViewController: UIViewController {
    
    private lazy var device = SomewearDevice.instance
    private lazy var statusBar = SomewearUI.instance.statusBarView(presenter: self)
    private var sendMessageButton = UIButton(type: .system)
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStatusBar()
        setupSendMessageButton()
        
        // handle status updates
        device.payload
            .subscribe(onNext: { [unowned self] value in
                self.didReceivePayload(value)
            })
            .disposed(by: disposeBag)
        
        // Only enable send message button if device is connected
        device.connectionState
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] value in
                self.sendMessageButton.isEnabled = value == .connected
            })
            .disposed(by: disposeBag)
    }
    
    private func setupStatusBar() {
        // setup status bar
        statusBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusBar)
        
        // setup constraints
        NSLayoutConstraint.activate([
            statusBar.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
            statusBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            statusBar.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
    
    private func setupSendMessageButton() {
        // setup send message button
        sendMessageButton.translatesAutoresizingMaskIntoConstraints = false
        sendMessageButton.setTitle(NSLocalizedString("Send Message", comment: "Send Message"), for: .normal)
        sendMessageButton.addTarget(self, action: #selector(didPressSendMessageButton), for: .touchUpInside)
        view.addSubview(sendMessageButton)
        
        // setup constraints
        NSLayoutConstraint.activate([
            sendMessageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendMessageButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    @objc private func didPressSendMessageButton() {
        #error("provide email to test")
        let email = ""
        let emailAddress = EmailAddress(unvalidated: email)!
        let messagePayload = MessagePayload(content: "Hello from space!", email: emailAddress)
        
        NSLog("send: start; parcelId=\(messagePayload.parcelId)")
        
        device.send(payload: messagePayload)
            .then { _ in
                NSLog("send: success; parcelId=\(messagePayload.parcelId)")
            }
            .catch { error in
                NSLog("send: failure; error=\(error)")
            }
    }
    
    private func didReceivePayload(_ payload: DevicePayload) {
        if let messagePayload = payload as? MessagePayload {
            NSLog("messageSendUpdate: parcelId=\(messagePayload.parcelId); status=\(messagePayload.status)")
        }
        else if let dataPayload = payload as? DataPayload {
            NSLog("dataSendUpdate: parcelId=\(dataPayload.parcelId); status=\(dataPayload.status)")
        }
    }
}

