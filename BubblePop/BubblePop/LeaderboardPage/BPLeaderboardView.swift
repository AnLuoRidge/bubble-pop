//
//  BPLeaderboardView.swift
//  BubblePop
//
//  Created by AnLuoRidge on 10/5/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import UIKit
import Foundation
import SnapKit

class BPLeaderboardView: UIView {
    private let titleLabel = UILabel()
    private var yourScoreLabel: UILabel? = UILabel()
    private let scoreTableView = UITableView()
    let restartButton = UIButton(type: .roundedRect)
    let backButton = UIButton(type: .roundedRect)
    
    init(tableViewDelegate: UITableViewDelegate, tableViewDataSource: UITableViewDataSource, score: Int?) {
        super.init(frame: CGRect.zero)

        scoreTableView.delegate = tableViewDelegate
        scoreTableView.dataSource = tableViewDataSource
//        scoreTableView.isScrollEnabled = false
        scoreTableView.allowsSelection = false
        scoreTableView.separatorStyle = .none
        scoreTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.text = "Leaderboard"
        titleLabel.textAlignment = .center
        if let yourScore = score {
            yourScoreLabel?.text = "Your score: \(yourScore)"
            yourScoreLabel?.font = UIFont.italicSystemFont(ofSize: 20)
        } else {
            yourScoreLabel = nil
        }
        
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
        restartButton.setAttributedTitle(NSAttributedString(string: "Home", attributes: attributes), for: .normal)
//        restartButton.setAttributedTitle(NSAttributedString(string: "Play again", attributes: attributes), for: .normal)
        restartButton.layer.borderColor = UIColor.gray.cgColor
        restartButton.layer.borderWidth = 1
        restartButton.layer.cornerRadius = 5
        
        backButton.setTitle("Home", for: .normal)

        addSubviews()
        makeConstraints()
        #if DEBUG
        addBorders(for: self.subviews)
        #endif
    }
    
    func addBorders(for views: [UIView]) {
        for view in views {
            view.layer.borderColor = UIColor.red.cgColor
            view.layer.borderWidth = 1
        }
    }
    
    func addSubviews() {
        let views = [
            titleLabel,
            scoreTableView,
            backButton
        ]
        for view in views {
            self.addSubview(view)
        }
        
        if let label = yourScoreLabel {
            self.addSubview(label)
            self.addSubview(restartButton)
        }
    }
    
    func makeConstraints() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(40)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        backButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-35)
        }

        if let scoreLabel = yourScoreLabel {
            scoreLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(titleLabel.snp_bottomMargin).offset(20)
            }
            scoreTableView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(scoreLabel.snp_bottomMargin).offset(27)
                make.width.equalTo(self).multipliedBy(0.7)
                make.bottom.equalTo(restartButton.snp_topMargin).offset(-20)
            }
            restartButton.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.bottom.equalTo(backButton.snp_topMargin).offset(-15)
                make.width.equalTo(200)
            }
        } else {
            scoreTableView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(titleLabel.snp_bottomMargin).offset(27)
                make.width.equalTo(self).multipliedBy(0.7)
                make.bottom.equalTo(backButton.snp_topMargin).offset(-20)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
