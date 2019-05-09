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

class GameViewController: UIViewController {

    override func loadView() {
        super.loadView()
        let highScore = 999
        let gameTime = 10
        let view = SKView(frame: UIScreen.main.bounds)
        view.showsNodeCount = true
        let gameScene = GameScene(size: view.bounds.size, highScore: highScore, gameTime: gameTime, gameOverHandler: handleGameOver)
            // TODO: check the scaleMode
            gameScene.scaleMode = .fill
            gameScene.backgroundColor = .white
            gameScene.highScore = 999

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

    override func viewDidAppear(_ animated: Bool) {
//        present(BPScoreViewController(), animated: true, completion: nil)
    }

    override var shouldAutorotate: Bool {
        return true
    }
//
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        (self.view as? SKView)?.scene?.size = size
//        guard let view = self.view as? SKView else { return }
//        let scene = view.scene!
//        let gameScene = scene as! GameScene
//        gameScene.refresh()

//        if var gameScene = view.scene {
//            gameScene = gameScene as! GameScene
//            gameScene.clear()
//        }

//        gameScene.clear()
    }

//
//    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
//        super.willAnimateRotation(to: toInterfaceOrientation, duration: duration)
//        loadView()
//    }

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

    // pass into game view as a block
    func handleGameOver(score: Int) {
        print("Player: xxxx, GameVC received the gameOver and score is \(score)")
    }
}
