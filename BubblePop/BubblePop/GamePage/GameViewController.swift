//
//  GameViewController.swift
//  BubblePop
//
//  Created by AnLuoRidge on 7/5/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import os.log

class GameViewController: UIViewController {
    private var maxBubbleNum = 15
    private var gameTime = 10
    private var highScore = 999
    private let playerName: String
    private static let randomNames = ["THE MAGICIAN", "THE HERMIT", "Anonymous"]

    convenience init() {
        self.init(playerName: GameViewController.randomNames.randomElement()!)
    }

    init(playerName name: String) {
        self.playerName = name
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        self.playerName = GameViewController.randomNames.randomElement()!
        super.init(coder: aDecoder)
    }

    override func loadView() {
        super.loadView()
        let view = SKView(frame: UIScreen.main.bounds)
        #if DEBUG
        view.showsNodeCount = true
        view.showsFPS = true
        #endif
        initialValues()
        let gameScene = GameScene(size: view.bounds.size, highScore: highScore, gameTime: gameTime, maxBubbleNum: maxBubbleNum, gameOverHandler: handleGameOver)
            // TODO: check the scaleMode
            gameScene.scaleMode = .aspectFill
            gameScene.backgroundColor = .white

            view.presentScene(gameScene)
            view.ignoresSiblingOrder = true

            self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // cast self.view to SKView
//        self.view = SKView(frame: UIScreen.main.bounds)

//        guard let view = self.view as? SKView else { return }
//        view.showsNodeCount = true
//        let gameScene = GameScene(size: view.bounds.size)
//        // TODO: check the scaleMode
//        gameScene.scaleMode = .fill
//        view.presentScene(gameScene)
//        view.ignoresSiblingOrder = true
    }

    func initialValues() {
        maxBubbleNum = UserDefaults.standard.integer(forKey: "maxBubbleNum")
        if maxBubbleNum == 0 { maxBubbleNum = 15}
        gameTime = UserDefaults.standard.integer(forKey: "gameTime")
        if gameTime == 0 { gameTime = 10 }
        if ScoreDAO.getSortedScores().count == 0 {
            highScore = 0
        } else {
            highScore = ScoreDAO.getSortedScores()[0].score
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        (self.view as? SKView)?.scene?.size = size
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // will pass into game view as a block
    func handleGameOver(score: Int) {
        #if DEBUG
        os_log("GAME OVER\nPlayer: %@, Score: %@", log: OSLog.default, type: .info, playerName, String(score))
        #endif
        ScoreDAO.saveScore(name: playerName, score: score)
        present(BPLeaderboardTableViewController(yourScore: score), animated: true)
    }
}
