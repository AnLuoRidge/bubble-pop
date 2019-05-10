//
//  BPHomeViewController.swift
//  BubblePop
//
//  Created by AnLuoRidge on 7/5/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import UIKit

class BPHomeViewController: UIViewController {

//    override func loadView() {
//        let startBtn = UIButton()
//        view.backgroundColor = .red
////        startBtn.titleLabel?.text = "Start"
////        view.addSubview(startBtn)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        let startBtn = UIButton()
//                startBtn.titleLabel?.text = "Start"
//                view.addSubview(startBtn)


        
        let startButton = UIButton(type: .custom)
        startButton.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        startButton.backgroundColor = .white
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(UIColor.gray, for: .normal)
        view.addSubview(startButton)
//        button.addTarget(self, action: Selector(buttonClick()), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(start), for: .touchUpInside)

        let settingsButton = UIButton(type: .system)
        settingsButton.frame = CGRect(x: 0, y: 300, width: UIScreen.main.bounds.width, height: 50)
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.addTarget(self, action: #selector(toSettings), for: .touchUpInside)
        view.addSubview(settingsButton)
        // Do any additional setup after loading the view.
    }
    @objc
    func start() {
//        navigationController?.pushViewController(GameViewController(), animated: true)
        let alert = UIAlertController(title: "Your Name", message: "Keep anonymous by leaving it blank", preferredStyle: .alert)

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
