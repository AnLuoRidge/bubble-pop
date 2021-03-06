//
//  BPHomeViewController.swift
//  BubblePop
//
//  Created by AnLuoRidge on 7/5/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import UIKit
import SnapKit

class BPHomeViewController: UIViewController {
    private let titleLabel = UILabel()
    private let startButton = UIButton(type: .custom)
    let settingsButton = UIButton(type: .system)

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        let titleLabelFont = UIFont.boldSystemFont(ofSize: 45)
        let titleLabelAttributes: [NSAttributedString.Key: Any] = [
            .font: titleLabelFont,
            .foregroundColor: UIColor.black,
        ]
        titleLabel.attributedText = NSAttributedString(string: "Bubble Pop", attributes: titleLabelAttributes)
        view.addSubview(titleLabel)
        
        startButton.layer.borderColor = UIColor.gray.cgColor
        startButton.layer.borderWidth = 1
        startButton.layer.cornerRadius = 5
        startButton.setTitleColor(.black, for: .normal)
        let font = UIFont.boldSystemFont(ofSize: 35)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black,
        ]
        startButton.setAttributedTitle(NSAttributedString(string: "Start", attributes: attributes), for: .normal)
        view.addSubview(startButton)
        startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.addTarget(self, action: #selector(toSettings), for: .touchUpInside)
        view.addSubview(settingsButton)
        
        addConstraints()
    }
    
    func addConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(UIScreen.main.bounds.height/3)
        }
        settingsButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view).offset(-50)
            make.centerX.equalTo(self.view)
        }
        startButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(settingsButton.snp_topMargin).offset(-20)
            make.width.equalTo(160)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let width = size.width
        let height = size.height
        
        if width > height {
            titleLabel.snp.removeConstraints()
            titleLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(view)
                make.top.equalTo(view).offset(UIScreen.main.bounds.height/6)
            }
        }
    }
    
    @objc
    func start() {
        let alert = UIAlertController(title: "Your Name", message: "To be anonymous, just leave it blank 😄", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your name here..."
        })

        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            if let name = alert.textFields?.first?.text, !name.isEmpty {
                self.present(GameViewController(playerName: name), animated: true)
            } else {
                self.present(GameViewController(), animated: true)
            }
        }))
        self.present(alert, animated: true, completion: nil)

    }
    
    @objc
    func toSettings() {
        present(BPSettingsViewController(), animated: false)
    }
}
