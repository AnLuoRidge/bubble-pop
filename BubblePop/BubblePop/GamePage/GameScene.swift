//
//  GameScene.swift
//  BubblePop
//
//  Created by AnLuoRidge on 7/5/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation

class GameScene: SKScene {
    static let scoreBarHeight = CGFloat(120)
    static let pink = UIColor.init(red: 254/255, green: 127/255, blue: 156/255, alpha: 1) // TODO: UIColor extension
    private var score = 0
    var maxBubbles = 15
    var highScore = 0
    var timeLeft = 60
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var bubbles = [SKShapeNode]()
    var lastColorHash = 0
    var gameOverHandler: (Int) -> Void
//    var timer = Timer()
    
    private var lastUpdateTime : TimeInterval = 0
    private var scoreLabel : SKLabelNode?
    private var spinnyNode : SKShapeNode?

    init(size: CGSize, highScore: Int, gameTime: Int, gameOverHandler: @escaping (Int) -> Void) {
        self.highScore =  highScore
        self.timeLeft = gameTime
        self.gameOverHandler = gameOverHandler
        super.init(size: size)
    }
//
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.removeAllChildren()
        spawnBubbles()
        scoreLbl()
        // TODO: remove
        //let name = UserDefaults.standard.string(forKey: "samplePlayer") ?? ""
//        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
//            print("\(key) = \(value) \n")
//        }
//
//        for ()
    }


    func scoreLbl() {
        scoreLabel = SKLabelNode(text: String(self.score))
        scoreLabel?.fontSize = 40
        scoreLabel?.horizontalAlignmentMode = .center
        scoreLabel?.fontColor = .black
        // TODO: score font
//        scoreLabel?.fontName = .
        if let sceneWidth = scene?.frame.width {
            if let sceneHeight = scene?.frame.height {
                scoreLabel?.position = CGPoint(x: sceneWidth/2, y: sceneHeight - 50)
            }
        }
//        label?.position = CGPoint(x: scene?.frame.width/2, y: 0)//CGRect(x: 0, y: 0, width: 100, height: 30)
        self.addChild(scoreLabel!)
    }
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
//
//        // Get label node from scene and store it for use later
////        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
////        if let label = self.label {
////            label.alpha = 0.0
////            label.run(SKAction.fadeIn(withDuration: 2.0))
////        }
//
//        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
////        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//        self.spinnyNode = SKShapeNode.init(circleOfRadius: 40)
//
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 0
////            spinnyNode.strokeColor = .clear
//
////            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
////            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
////                                              SKAction.fadeOut(withDuration: 0.5),
////                                              ]))
//            spinnyNode.position = CGPoint(x: 50, y: 50)
//            spinnyNode.fillColor = .orange
//            self.addChild(spinnyNode)
//        }

    }
    
    func spawnBubbles() {
        let timeInterval = TimeInterval(exactly: 0.1)

        // Setup a timer to run randomly between every 0.5 to 1.2 seconds
        let timer = Timer.scheduledTimer(withTimeInterval: timeInterval!, repeats: true, block: { _ in
            // limit bubble num. -1 for offset
            if self.children.count > self.maxBubbles - 1 {
                return
            }

            let bubble = self.bubbleNode()
            for oldBubble in self.children {
                if oldBubble.intersects(bubble) {
                    return
                }
            }

            bubble.name = "bubble"

            /*
                    enumerateChildNodes(withName: "bubble") { indicatorNode, _ in
            bubbleCheck = true
        }
        */
            // Add bubble to the current game scene
            self.addChild(bubble)
//            self.bubbles.append(bubble)
//            if self.bubbles.count > 20 {
//                self.bubbles.remove(at: 0)
//            }
//            print(self.children.count)
//            print(self.children[self.children.endIndex - 1])


            // Blow bubble to top
            self.blowBubble(bubble: bubble)
//            self.label?.text = NSCoder.string(for: self.children[self.children.endIndex - 1].position)
        })
        timer.fire()
    }

    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        self.removeAllChildren()
        scoreLbl()
    }

    func bubbleNode() -> SKShapeNode {
        guard let scene = scene else { fatalError() }
        let bubble = SKShapeNode(circleOfRadius: CGFloat.random(in: 20...40))
        bubble.lineWidth = 0
        bubble.fillColor = randomColor()

        let bubbleRadius = bubble.frame.size.width / 2
        let marginLeft = scene.frame.minX + bubbleRadius
        let marginRight = scene.frame.maxX - bubbleRadius
        let x = CGFloat.random(in: marginLeft...marginRight)

//        let marginTop = scene.frame.maxY - bubbleRadius
//        let marginBottom = scene.frame.minY + bubbleRadius
        let y = CGFloat(0) //CGFloat.random(in: marginBottom...marginTop)

        let bubblePoint = CGPoint(x: x, y: y)
        bubble.position = bubblePoint//scene.convertPoint(fromView: bubblePoint)

        return bubble
    }

    func randomColor() -> UIColor {
//        Red    1    40%
//        Pink    2    30%
//        Green    5    15%
//        Blue    8    10%
//        Black    10    5%

        let randomNumber = Int.random(in: 1...100)

//        let randomNumber = Int(arc4random() % 1000) / 10.0
        switch (randomNumber) {
        case 1...40:
            return .red
        case 41...70:
            return GameScene.pink
        case 71...85:
            return .green
        case 86...95:
            return .blue
        case 96...100:
            return .black
        default:
            return .red
        }
    }

    func blowBubble(bubble: SKShapeNode) {
        guard let marginTop = scene?.frame.maxY
                else {return}

        let outY = marginTop - GameScene.scoreBarHeight
        let outPoint = CGPoint(x: bubble.position.x, y: outY)

//        let locationInScene = scene!.convertPoint(fromView: destinationPoint)

        let translateAction = SKAction.move(
                to: outPoint,
                duration: 5// TimeInterval(Float.random(in: 10...15))
        )

        // Remove the bubble when it reaches the top of the screen
        // Deduct points if bubble reaches top without a tap
        bubble.run(translateAction) {
            bubble.removeFromParent()

//            self.points -= 1
//            self.updatePoints(points: self.points)

//            self.handleGameOver(status: self.isGameOver())
        }

    }

    func touchDown(atPoint pos : CGPoint) {
        for node in self.children {
            if node.frame.contains(pos) {
                let bubble = node as! SKShapeNode
                /*
                Red	1	40%
Pink	2	30%
Green	5	15%
Blue	8	10%
Black	10	5%
                */
                var scoreEarned = 0.0
                switch (bubble.fillColor.hash) {
                case UIColor.red.hash:
                    scoreEarned = 1
                case UIColor.blue.hash:
                    scoreEarned = 8
                case UIColor.green.hash:
                    scoreEarned = 5
                case UIColor.black.hash:
                    scoreEarned = 10
                case GameScene.pink.hash:
                    scoreEarned = 2
                default: // black grey system
                    scoreEarned = 0
                }
                if bubble.fillColor.hash == lastColorHash {
                    scoreEarned *= 1.5
                }
                self.score += Int(round(scoreEarned))
                scoreLabel?.text = String(self.score)
                lastColorHash = bubble.fillColor.hash
                bubble.removeFromParent()
                return
            }
        }
//        let bubbleFrame = CGRect(x: 50, y: 50, width: 50, height: 50)
//        if bubbleFrame.contains(pos) {
//        } else {
//            print(pos)
//        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }

    func handleGameOver() {
        UserDefaults.standard.set(["samplePlayer":score], forKey: "playerScore")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
    // TODO: remove following
        gameOverHandler(self.score)
//        handleGameOver()
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
