//
//  PuzzleScene6.swift
//  JigsawGame
//
//  Created by Spider on 2020/8/8.
//  Copyright © 2020 SpiderWeb. All rights reserved.
//

import UIKit
import SpriteKit

class PuzzleScene6: SKScene {
    
    //Constants
    let myId = 6
    let correctSound = "correct_sound"
    let wrongSound = "wrong_sound"
    let carName = "bulldozer"
    
    private var currentNode: SKNode!
    
    //For calculating puzzle pieces and correct locations
    var offset: CGPoint!
    var distance: CGFloat!
    let positionTolerance: CGFloat = 80
    
    //Puzzle targets
    var targetFrame1: SKSpriteNode!
    var targetFrame2: SKSpriteNode!
    var targetFrame3: SKSpriteNode!
    var targetFrame4: SKSpriteNode!
    
    //Puzzle pieces
    var piece1: SKSpriteNode!
    var piece2: SKSpriteNode!
    var piece3: SKSpriteNode!
    var piece4: SKSpriteNode!
    
    //Puzzle pieces start position
    var piece1StartPosition: CGPoint!
    var piece2StartPosition: CGPoint!
    var piece3StartPosition: CGPoint!
    var piece4StartPosition: CGPoint!
    
    //Puzzle pieces completion flag
    var piece1isComplete: Bool!
    var piece2isComplete: Bool!
    var piece3isComplete: Bool!
    var piece4isComplete: Bool!
    
    //Create some reusable SKActions that will play the sounds later
    var correctSoundAction: SKAction!
    var wrongSoundAction: SKAction!
    var changeVolumeAction: SKAction!
    var correctAudioGroup: SKAction!
    var wrongAudioGroup: SKAction!
    
    //MARK: - View life cycle
    override func didMove(to view: SKView) {
        
        //Preload sound effect
        changeVolumeAction = SKAction.changeVolume(to: 1, duration: 0.3)
        correctSoundAction = SKAction.playSoundFileNamed(correctSound, waitForCompletion: false)
        correctAudioGroup = SKAction.group([correctSoundAction,changeVolumeAction])
        wrongSoundAction = SKAction.playSoundFileNamed(wrongSound, waitForCompletion: false)
        wrongAudioGroup = SKAction.group([wrongSoundAction,changeVolumeAction])
        
        let background = SKSpriteNode(imageNamed: "main-background")
        background.position = CGPoint(x: 1218, y: 563)
        background.blendMode = .replace
        background.zPosition = -1 //place the background behind other things
        addChild(background)
        
        //Home-icon
        let returnToHome = SKSpriteNode(imageNamed: "home-icon")
        returnToHome.name = "returnToHome"
        returnToHome.size = CGSize(width: 180, height: 180)
        returnToHome.position = CGPoint(x: 350, y: 1000)
        returnToHome.blendMode = .alpha
        addChild(returnToHome)
        
        //Puzzle target locations
        targetFrame1 = createTargetFrame(at: CGPoint(x: 1018, y: 300))
        targetFrame2 = createTargetFrame(at: CGPoint(x: 1418, y: 300))
        targetFrame3 = createTargetFrame(at: CGPoint(x: 1018, y: 700))
        targetFrame4 = createTargetFrame(at: CGPoint(x: 1418, y: 700))
        addChild(targetFrame1)
        addChild(targetFrame2)
        addChild(targetFrame3)
        addChild(targetFrame4)
        
        //Glow effect
        targetFrame1.addGlow()
        targetFrame2.addGlow()
        targetFrame3.addGlow()
        targetFrame4.addGlow()
        targetFrame1.childNode(withName: "GlowEffect")?.isHidden = true
        targetFrame2.childNode(withName: "GlowEffect")?.isHidden = true
        targetFrame3.childNode(withName: "GlowEffect")?.isHidden = true
        targetFrame4.childNode(withName: "GlowEffect")?.isHidden = true
        
        //Draw lines in puzzle target frame
        //horizontal line
        let hLine = drawLine(start: CGPoint(x: 818, y: 500), end: CGPoint(x: 1618, y: 500))
        //vertical line
        let vLine = drawLine(start: CGPoint(x: 1218, y: 100), end: CGPoint(x: 1218, y: 900))
        addChild(hLine)
        addChild(vLine)
        
        //Puzzle pieces
        let pieceSize = CGSize(width: 400, height: 400)
        piece1 = createNode(at: CGPoint(x: 518, y: 280), imageNamed: "bulldozer_row-2-col-1", size: pieceSize, myName: "piece1")
        piece2 = createNode(at: CGPoint(x: 1918, y: 280), imageNamed: "bulldozer_row-2-col-2", size: pieceSize, myName: "piece2")
        piece3 = createNode(at: CGPoint(x: 518, y: 700), imageNamed: "bulldozer_row-1-col-1", size: pieceSize, myName: "piece3")
        piece4 = createNode(at: CGPoint(x: 1918, y: 700), imageNamed: "bulldozer_row-1-col-2", size: pieceSize, myName: "piece4")
        //Setting puzzle pieces start position
        piece1StartPosition = piece1.position
        piece2StartPosition = piece2.position
        piece3StartPosition = piece3.position
        piece4StartPosition = piece4.position
        addChild(piece1)
        addChild(piece2)
        addChild(piece3)
        addChild(piece4)
        //Puzzle pieces completion status
        piece1isComplete = false
        piece2isComplete = false
        piece3isComplete = false
        piece4isComplete = false
    }
    
    //MARK: - Custom function
    //Create Puzzle target frame
    func createTargetFrame(at position: CGPoint) -> SKSpriteNode {
        let color = UIColor.brown
        let size = CGSize(width: 400, height: 400)
        let targetFrame = SKSpriteNode(color: color, size: size)
        targetFrame.position = position
        return targetFrame
    }

    //Create a SpriteNode
    func createNode(at position: CGPoint, imageNamed name: String, size: CGSize, myName: String) -> SKSpriteNode {
        let nodeHolder = SKSpriteNode(imageNamed: name)
        nodeHolder.name = myName
        nodeHolder.size = size
        nodeHolder.position = position
        return nodeHolder
    }
    
    //Draw lines in puzzle target frame
    func drawLine(start: CGPoint, end: CGPoint) -> SKShapeNode {
        let line = SKShapeNode()
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        line.path = path.cgPath
        line.strokeColor = UIColor.white
        line.lineWidth = 4
        return line
    }

    //Create puzzle completion scene
    func createDoneScene(imageNamed name: String) {
        let doneNode = SKSpriteNode(imageNamed: name)
        doneNode.position = CGPoint(x: 1218, y: 563)
        doneNode.blendMode = .replace
        doneNode.zPosition = 2
        let rightArrow = createNode(at: CGPoint(x: 2000 , y: 600), imageNamed: "right-arrow", size: CGSize(width: 200, height: 200), myName: "right-arrow")
        rightArrow.zPosition = 3
        self.run(SKAction.wait(forDuration: 1)) {
            self.addChild(doneNode)
            self.run(SKAction.wait(forDuration: 0.3)) {
                SoundPlayer.playSound(soundName: self.carName)
                self.addChild(rightArrow)
            }
        }
    }

    //MARK: - Touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            //For debug
            print("touchesBegan")
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            //Transit scene
            switch touchedNode.name {
                case "returnToHome": //Transit to HomeScene
                    let scene = HomeScene(size: self.scene!.size)
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                case "right-arrow": //Transit to next puzzle
                    let nextId = (myId % 10) + 1
                    switch nextId {
                        case 1:
                            let scene = PuzzleScene1(size: self.scene!.size)
                            scene.scaleMode = .aspectFill
                            self.view?.presentScene(scene)
                        case 2:
                            let scene = PuzzleScene2(size: self.scene!.size)
                            scene.scaleMode = .aspectFill
                            self.view?.presentScene(scene)
                        case 3:
                            let scene = PuzzleScene3(size: self.scene!.size)
                            scene.scaleMode = .aspectFill
                            self.view?.presentScene(scene)
                        case 4:
                            let scene = PuzzleScene4(size: self.scene!.size)
                            scene.scaleMode = .aspectFill
                            self.view?.presentScene(scene)
                        case 5:
                            let scene = PuzzleScene5(size: self.scene!.size)
                            scene.scaleMode = .aspectFill
                            self.view?.presentScene(scene)
                        case 6:
                            let scene = PuzzleScene6(size: self.scene!.size)
                            scene.scaleMode = .aspectFill
                            self.view?.presentScene(scene)
                        case 7:
                            let scene = PuzzleScene7(size: self.scene!.size)
                            scene.scaleMode = .aspectFill
                            self.view?.presentScene(scene)
                        case 8:
                            let scene = PuzzleScene8(size: self.scene!.size)
                            scene.scaleMode = .aspectFill
                            self.view?.presentScene(scene)
                        case 9:
                            let scene = PuzzleScene9(size: self.scene!.size)
                            scene.scaleMode = .aspectFill
                            self.view?.presentScene(scene)
                        case 10:
                            let scene = PuzzleScene10(size: self.scene!.size)
                            scene.scaleMode = .aspectFill
                            self.view?.presentScene(scene)
                        default:
                            break
                    }
                default:
                    break
            }
            
            //Determine which piece be touched
            //piece會互相遮掩,因此touchesBegan的時候改變它的zPosition拉到最上層(0->1),touchesEnded再設回0
            switch touchedNode.name {
                case "piece1":
                    self.currentNode = touchedNode
                    self.currentNode.zPosition = 1
                case "piece2":
                    self.currentNode = touchedNode
                    self.currentNode.zPosition = 1
                case "piece3":
                    self.currentNode = touchedNode
                    self.currentNode.zPosition = 1
                case "piece4":
                    self.currentNode = touchedNode
                    self.currentNode.zPosition = 1
                default:
                    break
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //For debug
        print("touchesMoved")
        if let touch = touches.first, let node = currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
            
            switch node.name {
                case "piece1":
                    let distance = distanceBetweenNodes (node1: node, node2: targetFrame1)
                    if distance < positionTolerance {
                        targetFrame1.childNode(withName: "GlowEffect")?.isHidden = false
                    } else {
                        targetFrame1.childNode(withName: "GlowEffect")?.isHidden = true
                    }
                case "piece2":
                    let distance = distanceBetweenNodes(node1: node, node2: targetFrame2)
                    if distance < positionTolerance {
                        targetFrame2.childNode(withName: "GlowEffect")?.isHidden = false
                    } else {
                        targetFrame2.childNode(withName: "GlowEffect")?.isHidden = true
                    }
                case "piece3":
                    let distance = distanceBetweenNodes(node1: node, node2: targetFrame3)
                    if distance < positionTolerance {
                        targetFrame3.childNode(withName: "GlowEffect")?.isHidden = false
                    } else {
                        targetFrame3.childNode(withName: "GlowEffect")?.isHidden = true
                    }
                case "piece4":
                    let distance = distanceBetweenNodes(node1: node, node2: targetFrame4)
                    if distance < positionTolerance {
                        targetFrame4.childNode(withName: "GlowEffect")?.isHidden = false
                    } else {
                        targetFrame4.childNode(withName: "GlowEffect")?.isHidden = true
                    }
                default:
                    break
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //For debug
        print("touchesEnded")
        if let node = currentNode {
            switch node.name {
                case "piece1":
                    //Get distance between correct location
                    let distance = distanceBetweenNodes (node1: node, node2: targetFrame1)
                    if distance < positionTolerance {
                        //touchdown! Snap to correct location when distance < threshold
                        let moveTo = SKAction.move(to: targetFrame1.position, duration: 0.1)
                        node.run(moveTo)
                        node.run(correctAudioGroup)
                        targetFrame1.childNode(withName: "GlowEffect")?.isHidden = true
                        piece1isComplete = true
                        //When place to correct location, make the piece can't be moved
                        piece1.isUserInteractionEnabled = true //SKNode the default value is false.
                    } else { //bounce back to this piece start position
                        let moveBack = SKAction.move(to: piece1StartPosition, duration: 0)
                        node.run(moveBack)
                        node.run(wrongAudioGroup)
                        targetFrame1.childNode(withName: "GlowEffect")?.isHidden = true
                    }
                    //Reset zPosition
                    node.zPosition = 0

                    //Check puzzle completion or not
                    if (piece1isComplete && piece2isComplete && piece3isComplete && piece4isComplete) {
                        //For debug
                        print("Here is piece1, Puzzle Complete!")
                        //Puzzle completion
                        createDoneScene(imageNamed: "bulldozer_complete")
                    }
                case "piece2":
                    //Get distance between correct location
                    let distance = distanceBetweenNodes(node1: node, node2: targetFrame2)
                    if distance < positionTolerance { //snap to correct position
                        let moveTo = SKAction.move(to: targetFrame2.position, duration: 0.1)
                        node.run(moveTo)
                        node.run(correctAudioGroup)
                        targetFrame2.childNode(withName: "GlowEffect")?.isHidden = true
                        piece2isComplete = true
                        piece2.isUserInteractionEnabled = true
                    } else { //bounce back to this piece start position
                        let moveBack = SKAction.move(to: piece2StartPosition, duration: 0)
                        node.run(moveBack)
                        node.run(wrongAudioGroup)
                        targetFrame2.childNode(withName: "GlowEffect")?.isHidden = true
                    }
                    //Reset zPosition
                    node.zPosition = 0

                    //Check puzzle completion or not
                    if (piece1isComplete && piece2isComplete && piece3isComplete && piece4isComplete) {
                        //For debug
                        print("Here is piece2, Puzzle Complete!")
                        //Puzzle completion
                        createDoneScene(imageNamed: "bulldozer_complete")
                    }
                case "piece3":
                    //Get distance between correct location
                    let distance = distanceBetweenNodes(node1: node, node2: targetFrame3)
                    if distance < positionTolerance { //snap to correct position
                        let moveTo = SKAction.move(to: targetFrame3.position, duration: 0.1)
                        node.run(moveTo)
                        node.run(correctAudioGroup)
                        targetFrame3.childNode(withName: "GlowEffect")?.isHidden = true
                        piece3isComplete = true
                        piece3.isUserInteractionEnabled = true
                    } else { //bounce back to this piece start position
                        let moveBack = SKAction.move(to: piece3StartPosition, duration: 0)
                        node.run(moveBack)
                        node.run(wrongAudioGroup)
                        targetFrame3.childNode(withName: "GlowEffect")?.isHidden = true
                    }
                    //Reset zPosition
                    node.zPosition = 0

                    //Check puzzle completion or not
                    if (piece1isComplete && piece2isComplete && piece3isComplete && piece4isComplete) {
                        //For debug
                        print("Here is piece3, Puzzle Complete!")
                        //Puzzle completion
                        createDoneScene(imageNamed: "bulldozer_complete")
                    }
                case "piece4":
                    //Get distance between correct location
                    let distance = distanceBetweenNodes(node1: node, node2: targetFrame4)
                    if distance < positionTolerance { //snap to correct position
                        let moveTo = SKAction.move(to: targetFrame4.position, duration: 0.1)
                        node.run(moveTo)
                        node.run(correctAudioGroup)
                        targetFrame4.childNode(withName: "GlowEffect")?.isHidden = true
                        piece4isComplete = true
                        piece4.isUserInteractionEnabled = true
                    } else { //bounce back to this piece start position
                        let moveBack = SKAction.move(to: piece4StartPosition, duration: 0)
                        node.run(moveBack)
                        node.run(wrongAudioGroup)
                        targetFrame4.childNode(withName: "GlowEffect")?.isHidden = true
                    }
                    //Reset zPosition
                    node.zPosition = 0

                    //Check puzzle completion or not
                    if (piece1isComplete && piece2isComplete && piece3isComplete && piece4isComplete) {
                        //For debug
                        print("Here is piece4, Puzzle Complete!")
                        //Puzzle completion
                        createDoneScene(imageNamed: "bulldozer_complete")
                    }
                default:
                    break
            }
        }
        self.currentNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //For debug
        print("touchesCancelled")
        self.currentNode = nil
    }
    
}

