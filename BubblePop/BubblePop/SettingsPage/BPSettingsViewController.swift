//
//  BPHomeViewController.swift
//  BubblePop
//
//  Created by AnLuoRidge on 7/5/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import UIKit
import Stevia

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


    override func loadView() {
        super.loadView()




        let maxBubbleNumLabel = UILabel(frame: CGRect(x: 30, y: maxBubbleNumY, width: stepperLabelW, height: commonH))
        maxBubbleNumLabel.text = "Maximum bubbles："
        maxBubbleNumStepper.frame = CGRect(x: 300, y: maxBubbleNumY, width: stepperW, height: 20)
        maxBubbleNumStepper.minimumValue = 5
        maxBubbleNumStepper.maximumValue = 30
        maxBubbleNumStepper.stepValue = 5
        maxBubbleNumStepper.isContinuous = true
//        maxBubbleNumSlider.value = 15
        maxBubbleNumStepper.addTarget(self, action: #selector(maxBubbleNumStepperValueChanged), for: .valueChanged)

        maxBubbleNumIndicatorLabel.frame = CGRect(x: 200, y: maxBubbleNumY, width: 50, height: commonH)
        maxBubbleNumIndicatorLabel.text = "15"


        let gameTimeLabel = UILabel()
        gameTimeLabel.frame = CGRect(x: marginLeft, y: gameTimeY, width: gameTimeLabelW, height: commonH)
        gameTimeLabel.text = "Game Time："

//        let gameTimeStepper = UIStepper()
        gameTimeStepper.frame = CGRect(x: marginLeft + gameTimeLabelW + 10, y: gameTimeY, width: stepperW, height: commonH)
        gameTimeStepper.minimumValue = 10
        gameTimeStepper.maximumValue = 120
        gameTimeStepper.isContinuous = true
        gameTimeStepper.stepValue = 10
//        gameTimeStepper.value = 60
        gameTimeStepper.addTarget(self, action: #selector(gameTimeStepperValueChanged), for: .valueChanged)

        gameTimeIndicatorLabel.frame = CGRect(x: 400, y: gameTimeY, width: stepperLabelW, height: commonH)
        gameTimeIndicatorLabel.text = String(Int(gameTimeStepper.value))

//        startBtn.titleLabel?.text = "Start"
        view.addSubview(maxBubbleNumLabel)
        view.addSubview(maxBubbleNumStepper)
        view.addSubview(maxBubbleNumIndicatorLabel)
        view.addSubview(gameTimeLabel)
        view.addSubview(gameTimeStepper)
        view.addSubview(gameTimeIndicatorLabel)
    }

//    func addSubviews
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        loadSettings()
//        view.backgroundColor = .white

        // Do any additional setup after loading the view.

    }

    func saveSettings() {
        UserDefaults.standard.set(maxBubbleNum, forKey: "maxBubbleNum")
        UserDefaults.standard.set(gameTime, forKey: "gameTime")
    }

    func loadSettings() {
        maxBubbleNum = UserDefaults.standard.integer(forKey: "maxBubbleNum")
        if maxBubbleNum == 0 { maxBubbleNum = 15}

//        maxBubbleNumIndicatorLabel.text = String(maxBubbleNum)

        gameTime = UserDefaults.standard.integer(forKey: "gameTime")
        if gameTime == 0 { gameTime = 10 }
//        gameTimeIndicatorLabel.text = String(gameTime)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveSettings()
    }

    @objc
    func maxBubbleNumStepperValueChanged(sender: UIStepper!) {
        maxBubbleNum = Int(maxBubbleNumStepper.value)
//        maxBubbleNumIndicatorLabel.text = String(maxBubbleNum)
    }
    @objc
    func gameTimeStepperValueChanged(sender: UIStepper!) {
        gameTime = Int(gameTimeStepper.value)
//        gameTimeIndicatorLabel.text = String(gameTime)
//        let step = 10.0
//        let roundedValue = round(sender.value / step) * step
//        sender.value = roundedValue
//        sender.setValue(roundedValue, animated: true)
    }

    func buttonClick() {
//        navigationController?.popToRootViewController(animated: true)
//        navigationController?.pushViewController(GameViewController(), animated: true)
        present(GameViewController(), animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
