//
//  BPLeaderboardTableViewController.swift
//  BubblePop
//
//  Created by AnLuoRidge on 7/5/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import UIKit

class BPLeaderboardTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var scores = [Score]()
    let yourScore: Int?
    
    init(yourScore: Int?) {
        self.yourScore = yourScore
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.yourScore = 0
        super.init(coder: aDecoder)
    }

    override func loadView() {
        super.loadView() // must be called first

        let leaderboardView = BPLeaderboardView(tableViewDelegate: self, tableViewDataSource: self, score: yourScore)
        // Link actions
        leaderboardView.restartButton.addTarget(self, action: #selector(restart), for: .touchUpInside)
        leaderboardView.backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view = leaderboardView
    }

    @objc
    func restart(sender: UIButton!) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    @objc
    func back(sender: UIButton!) {
        self.present(BPHomeViewController(), animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "High Scores"
        scores = ScoreDAO.getSortedScores()
        
        #if DEBUG
        print("All scores: \(scores)")
        #endif
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = scores[indexPath.row].name
        cell.detailTextLabel?.text = String(scores[indexPath.row].score)
        cell.detailTextLabel?.textColor = .black
        return cell
    }
}
