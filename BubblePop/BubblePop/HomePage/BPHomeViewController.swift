//
//  BPHomeViewController.swift
//  BubblePop
//
//  Created by AnLuoRidge on 7/5/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import UIKit
import Stevia

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
        let startBtn = UIButton()
                startBtn.titleLabel?.text = "Start"
                view.addSubview(startBtn)
        
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 400, width: UIScreen.main.bounds.width, height: 50)
        button.backgroundColor = UIColor.white
        button.setTitle("Start", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        view.addSubview(button)
//        button.addTarget(self, action: Selector(buttonClick()), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)

        
        
        // Do any additional setup after loading the view.
        
    }
    @objc
    func buttonClick() {
//        navigationController?.pushViewController(GameViewController(), animated: true)
        // 另一种跳转方式
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
