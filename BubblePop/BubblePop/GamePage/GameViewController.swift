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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill

                // Present the scene
                let gameView = SKView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                gameView.presentScene(sceneNode)
                gameView.ignoresSiblingOrder = true
                
                // TODO: Lazy load
                //                let gameView = SKView? {
                //                    view.presentScene(sceneNode)
                //
                //                    view.ignoresSiblingOrder = true
                //
                //                    view.showsFPS = true
                //                    view.showsNodeCount = true
                //                }
                view.addSubview(gameView)
                
//                // Present the scene
//                if let view = self.view as! SKView? {
//                    view.presentScene(sceneNode)
//
//                    view.ignoresSiblingOrder = true
//
//                    view.showsFPS = true
//                    view.showsNodeCount = true
//                }
            }
        }
//                        let closing = Timer.init(timeInterval: 8, repeats: false) { (Timer) in
//                            self.dismiss(animated: true, completion: nil)
//                            
//                        }
//                        closing.fire()
//        dismiss(animated: true, completion: nil)

    }
    override func viewDidAppear(_ animated: Bool) {
//        present(BPScoreViewController(), animated: true, completion: nil)
    }

    override var shouldAutorotate: Bool {
        return true
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
}
