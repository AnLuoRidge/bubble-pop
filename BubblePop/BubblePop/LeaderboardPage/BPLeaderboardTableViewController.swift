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

    override func loadView() {
        super.loadView()
        let tableView = UITableView(frame: CGRect(x: 100, y: 60, width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height - 220))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)



        let restartButton = UIButton(type: .roundedRect)
        restartButton.frame = CGRect(x: 100, y: 0, width: 180, height: 50)
        restartButton.setTitle("Play again", for: .normal)
//        restartButton.backgroundColor = .blue
        restartButton.setTitleColor(.black, for: .normal)
        let font = UIFont.boldSystemFont(ofSize: 28)
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.lightGray
        shadow.shadowBlurRadius = 5
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black,
            .shadow: shadow
        ]
        restartButton.setAttributedTitle(NSAttributedString(string: "Play again", attributes: attributes), for: .normal)
        restartButton.layer.borderColor = UIColor.black.cgColor
        restartButton.layer.borderWidth = 1
        restartButton.layer.cornerRadius = 5
        restartButton.addTarget(self, action: #selector(restart), for: .touchUpInside)
        self.view.addSubview(restartButton)

        let backButton = UIButton(type: .system)
        backButton.setTitle("< Back", for: .normal)
        backButton.frame = CGRect(x: 300, y: 0, width: 100, height: 50)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(backButton)

        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        titleLabel.backgroundColor = .white
        titleLabel.text = "Leaderboard"
        titleLabel.textColor = .green
        view.addSubview(titleLabel)
    }

    @objc
    func restart(sender: UIButton!) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    @objc
    func back(sender: UIButton!) {
        self.present(BPHomeViewController(), animated: true)
    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        tableView.frame = CGRect(x: 100, y: 100, width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height - 120)
//
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "High Scores"
        scores = ScoreDAO.getSortedScores()

//        self.tableView.frame =  CGRect(x: 100, y: 100, width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height - 120)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "Cell")//.cellForRow(at: indexPath)
        // Configure the cell...
        cell.textLabel?.text = scores[indexPath.row].name
        cell.detailTextLabel?.text = String(scores[indexPath.row].score)
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
