//
//  BPLeaderboardViewController.swift
//  BubblePop
//
//  Created by AnLuoRidge on 7/5/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import UIKit
//import Stevia

class BPLeaderboardViewController: UIViewController {

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Leaderboard"
        view.backgroundColor = .red
        let titleLable = UILabel()
        titleLable.frame = CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 50)
        titleLable.backgroundColor = UIColor.white
        titleLable.text = "Leaderboard"
        titleLable.textColor = .green
        view.addSubview(titleLable)
//        sv(tableView)
//        tableView.Left = view.Left
        // Do any additional setup after loading the view.
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
