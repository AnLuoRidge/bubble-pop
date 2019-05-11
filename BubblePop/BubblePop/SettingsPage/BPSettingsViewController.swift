//
//  BPHomeViewController.swift
//  BubblePop
//
//  Created by AnLuoRidge on 7/5/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import UIKit
import SnapKit

class BPSettingsViewController: UIViewController {

    var maxBubbleNum = 15 {
        didSet {
            maxBubbleNumStepper.value = Double(maxBubbleNum)
            maxBubbleNumIndicatorLabel.text = String(maxBubbleNum)
        }
    } // didSet -> label
    var gameTime = 10 {
        didSet {
            gameTimeStepper.value = Double(gameTime)
            gameTimeIndicatorLabel.text = String(gameTime) + "s"
        }
    }

    let settingsLabel = UILabel()
    let stepperW = CGFloat(200)
    let commonH = CGFloat(20)
    let stepperLabelW = CGFloat(200)
    let stepperValueLabelW = CGFloat(50)
    let maxBubbleNumY = CGFloat(200)
    let marginLeft = CGFloat(30)

    let gameTimeY = CGFloat(250)
    let gameTimeLabelW = CGFloat(200)

    let maxBubbleNumIndicatorLabel = UILabel()

    let maxBubbleNumStepper = UIStepper()
    let gameTimeStepper = UIStepper()
    let gameTimeIndicatorLabel = UILabel()
    let saveButton = UIButton(type: .system)

    override func loadView() {
        super.loadView()
        
        
        let titleLabelFont = UIFont.boldSystemFont(ofSize: 45)
        let titleLabelAttributes: [NSAttributedString.Key: Any] = [
            .font: titleLabelFont,
            .foregroundColor: UIColor.black,
        ]
        settingsLabel.attributedText = NSAttributedString(string: "Settings", attributes: titleLabelAttributes)
        view.addSubview(settingsLabel)



        let maxBubbleNumLabel = UILabel()
        maxBubbleNumLabel.text = "Maximum bubbles："
        maxBubbleNumStepper.tintColor = .black
        maxBubbleNumStepper.minimumValue = 5
        maxBubbleNumStepper.maximumValue = 30
        maxBubbleNumStepper.stepValue = 5
        maxBubbleNumStepper.isContinuous = true
//        maxBubbleNumSlider.value = 15
        maxBubbleNumStepper.addTarget(self, action: #selector(maxBubbleNumStepperValueChanged), for: .valueChanged)

//        maxBubbleNumIndicatorLabel.frame = CGRect(x: 200, y: maxBubbleNumY, width: 50, height: commonH)
//        maxBubbleNumIndicatorLabel.text = "15"


        let gameTimeLabel = UILabel()
        gameTimeLabel.frame = CGRect(x: marginLeft, y: gameTimeY, width: gameTimeLabelW, height: commonH)
        gameTimeLabel.text = "Game Time："

//        let gameTimeStepper = UIStepper()
//        gameTimeStepper.frame = CGRect(x: marginLeft + gameTimeLabelW + 10, y: gameTimeY, width: stepperW, height: commonH)
        gameTimeStepper.tintColor = .black
        gameTimeStepper.minimumValue = 10
        gameTimeStepper.maximumValue = 120
        gameTimeStepper.isContinuous = true
        gameTimeStepper.stepValue = 10
//        gameTimeStepper.value = 60
        gameTimeStepper.addTarget(self, action: #selector(gameTimeStepperValueChanged), for: .valueChanged)

//        gameTimeIndicatorLabel.frame = CGRect(x: 400, y: gameTimeY, width: stepperLabelW, height: commonH)
        gameTimeIndicatorLabel.text = String(Int(gameTimeStepper.value))

        saveBtn()

//        startBtn.titleLabel?.text = "Start"
        view.addSubview(maxBubbleNumLabel)
        view.addSubview(maxBubbleNumStepper)
        view.addSubview(maxBubbleNumIndicatorLabel)
        view.addSubview(gameTimeLabel)
        view.addSubview(gameTimeStepper)
        view.addSubview(gameTimeIndicatorLabel)
        
        
        settingsLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(50)
        }
        maxBubbleNumLabel.snp.makeConstraints { (e) in
            e.left.equalTo(view).offset(30)
            e.top.equalTo(settingsLabel.snp_bottomMargin).offset(80)
        }
        maxBubbleNumIndicatorLabel.snp.makeConstraints { (e) in
            e.left.equalTo(maxBubbleNumLabel.snp_rightMargin).offset(15)
            e.top.equalTo(maxBubbleNumLabel)
        }
        maxBubbleNumStepper.snp.makeConstraints { (e) in
            e.centerY.equalTo(maxBubbleNumLabel)
            e.right.equalTo(view).offset(-30)
        }
        gameTimeLabel.snp.makeConstraints { (e) in
            e.left.equalTo(maxBubbleNumLabel)
            e.top.equalTo(maxBubbleNumLabel.snp_bottomMargin).offset(40)
        }
        gameTimeIndicatorLabel.snp.makeConstraints { (e) in
            e.top.equalTo(gameTimeLabel)
            e.left.equalTo(maxBubbleNumIndicatorLabel)
        }
        gameTimeStepper.snp.makeConstraints { (e) in
            e.top.equalTo(gameTimeLabel)
            e.right.equalTo(view).offset(-30)
        }
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        if width < height {
            saveButton.snp.makeConstraints { (e) in
                e.bottom.equalTo(view).offset(-100)
                e.centerX.equalTo(view)
                e.width.equalTo(100)
            }
        } else {
            saveButton.snp.makeConstraints { (e) in
                e.bottom.equalTo(view).offset(-50)
                e.centerX.equalTo(view)
                e.width.equalTo(100)
            }
        }
    }

    func saveBtn() {
        let font = UIFont.systemFont(ofSize: 30)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]
        saveButton.layer.borderColor = UIColor.gray.cgColor
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 5
        saveButton.setAttributedTitle(NSAttributedString(string: "Save", attributes: attributes), for: .normal)
        saveButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
        view.addSubview(saveButton)
    }

    @objc
    func backToHome() {
        saveSettings()
        dismiss(animated: false)
    }

    func addConstraints() {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        loadSettings()
    }

    func saveSettings() {
        UserDefaults.standard.set(maxBubbleNum, forKey: "maxBubbleNum")
        UserDefaults.standard.set(gameTime, forKey: "gameTime")
    }

    func loadSettings() {
        maxBubbleNum = UserDefaults.standard.integer(forKey: "maxBubbleNum")
        if maxBubbleNum == 0 { maxBubbleNum = 15}

        gameTime = UserDefaults.standard.integer(forKey: "gameTime")
        if gameTime == 0 { gameTime = 10 }
    }

    @objc func maxBubbleNumStepperValueChanged(sender: UIStepper!) {
        maxBubbleNum = Int(maxBubbleNumStepper.value)
    }
    
    @objc func gameTimeStepperValueChanged(sender: UIStepper!) {
        gameTime = Int(gameTimeStepper.value)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let width = size.width
        let height = size.height
        
        if width > height {
            saveButton.snp.removeConstraints()
            saveButton.snp.makeConstraints { (make) in
                make.centerX.equalTo(view)
                make.bottom.equalTo(view).offset(-50)
            }
        }
    }
}
