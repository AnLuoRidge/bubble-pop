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
    private var gameTimer = Timer()
    private var bubbleLoop = Timer()
    var gameOverHandler: (Int) -> Void
//    var timer = Timer()
    
    var lastUpdateTime: TimeInterval = 0
    private var scoreLabel = SKLabelNode()
    private var scoreValueLabel = SKLabelNode()
    private let highestScoreLabel = SKLabelNode()
    private let highestScoreValueLabel = SKLabelNode()
    private var timeLeftLabel = SKLabelNode()
    private let timeLeftValueLabel = SKLabelNode()

    private var titleLabelY = CGFloat(400)
    private var valueLabelY = CGFloat(250)
    private var maxX = CGFloat(667)
    private let titleFontSize = CGFloat(25)
    private let titleFontName = "MarkerFelt-Wide"

    init(size: CGSize, highScore: Int, gameTime: Int, maxBubbleNum: Int, gameOverHandler: @escaping (Int) -> Void) {
        self.highScore =  highScore
        self.timeLeft = gameTime
        self.gameOverHandler = gameOverHandler
        self.maxBubbles = maxBubbleNum
        super.init(size: size)
    }
//
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        guard let scene = scene else { fatalError() }
        titleLabelY = scene.frame.maxY - 40
        valueLabelY = titleLabelY - 40
        maxX = scene.frame.maxX
        
        self.removeAllChildren()
        spawnBubbles()

        // TODO: copy to didSizeChange
        scoreLbl()
        scoreValueLbl()
        highestScoreLbl()
        highestScoreValueLbl()
        timeLeftLbl()
        timeLeftValueLbl()

        fireGameTimer()
    }


    func highestScoreLbl() {
        highestScoreLabel.position = CGPoint(x: maxX - 30, y: titleLabelY)
        highestScoreLabel.text = "HIGHEST"
        highestScoreLabel.fontColor = .black
        highestScoreLabel.horizontalAlignmentMode = .right
        highestScoreLabel.fontSize = titleFontSize - 3
        highestScoreLabel.fontName = titleFontName
        self.addChild(highestScoreLabel)
    }

    func highestScoreValueLbl() {
        highestScoreValueLabel.position = CGPoint(x: maxX - 75, y: valueLabelY)
        highestScoreValueLabel.text = String(highScore)
        highestScoreValueLabel.fontColor = .black
        highestScoreValueLabel.fontSize = 28
        highestScoreValueLabel.horizontalAlignmentMode = .center
        self.addChild(highestScoreValueLabel)
    }

    func timeLeftLbl() {
        timeLeftLabel.position = CGPoint(x: 20, y: titleLabelY)
        timeLeftLabel.horizontalAlignmentMode = .left
        timeLeftLabel.text = "Time Left"
        timeLeftLabel.fontSize = titleFontSize
        timeLeftLabel.fontName = titleFontName
        timeLeftLabel.fontColor = .black
        self.addChild(timeLeftLabel)
    }

    func timeLeftValueLbl() {
        timeLeftValueLabel.position = CGPoint(x: 80, y: valueLabelY)
        timeLeftValueLabel.horizontalAlignmentMode = .center
        timeLeftValueLabel.text = String(timeLeft)
        timeLeftValueLabel.fontSize = 28
        timeLeftValueLabel.fontColor = .black
        self.addChild(timeLeftValueLabel)
    }

    func scoreLbl() {
        scoreLabel.position = CGPoint(x: maxX / 2, y: titleLabelY)
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.text = "Score"
        scoreLabel.fontName = titleFontName
        scoreLabel.fontColor = .black
        scoreLabel.fontSize = titleFontSize
        self.addChild(scoreLabel)
    }

    func scoreValueLbl() {
        scoreValueLabel.position = CGPoint(x: maxX / 2, y: valueLabelY)
        scoreValueLabel.text = String(self.score)
        scoreValueLabel.fontSize = 40
        scoreValueLabel.horizontalAlignmentMode = .center
        scoreValueLabel.fontColor = .black
        scoreValueLabel.fontName = "Avenir-Book"
        self.addChild(scoreValueLabel)
    }

    func fireGameTimer() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.timeLeft -= 1
            self.timeLeftValueLabel.text = String(self.timeLeft)
            if self.timeLeft == 0 {
                self.gameOver()
            }})
        gameTimer.fire()
    }

    override func sceneDidLoad() {

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

        bubbleLoop = Timer.scheduledTimer(withTimeInterval: timeInterval!, repeats: true, block: { _ in
            // limit bubble num
            let otherNodes = 6
            if self.children.count > self.maxBubbles + otherNodes {
                return
            }
            // TODO: separate file - BubbleNode
            let bubble = self.bubbleNode()
            // Avoid overlap
            for oldBubble in self.children {
                if oldBubble.intersects(bubble) {
                    return
                }
            }

            bubble.name = "bubble"
            // Add bubble to the current game scene
            self.addChild(bubble)
            self.blowBubble(bubble: bubble)
        })
        bubbleLoop.fire()
    }

    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        self.removeAllChildren()
        scoreLbl()
        scoreValueLbl()
        highestScoreLbl()
        highestScoreValueLbl()
        timeLeftLbl()
        timeLeftValueLbl()
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

    func gameOver() {
        self.removeAllChildren()
        self.gameOverHandler(score)
        gameTimer.invalidate()
        bubbleLoop.invalidate()
    }

    deinit {
        gameTimer.invalidate()
        bubbleLoop.invalidate()
    }

    func touchDown(atPoint pos : CGPoint) {
        for node in self.children {
            if node.frame.contains(pos) {
                if let bubble = node as? SKShapeNode {
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
                scoreValueLabel.text = String(self.score)
                lastColorHash = bubble.fillColor.hash
                bubble.removeFromParent()
                return} else {return}
            }
        }
//        let bubbleFrame = CGRect(x: 50, y: 50, width: 50, height: 50)
//        if bubbleFrame.contains(pos) {
//        } else {
//            print(pos)
//        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
    }

    func handleGameOver() {
        UserDefaults.standard.set(["samplePlayer":score], forKey: "playerScore")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
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
