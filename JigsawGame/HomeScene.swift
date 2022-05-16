// List all car thumb images
//
//  HomeScene.swift
//  JigsawGame
//
//  Created by Spider on 2020/7/21.
//  Copyright © 2020 SpiderWeb. All rights reserved.
//

import UIKit
import SpriteKit

class HomeScene: SKScene {
    
    var car01: SKNode!
    var car02: SKNode!
    var car03: SKNode!
    var car04: SKNode!
    var car05: SKNode!
    var car06: SKNode!
    var car07: SKNode!
    var car08: SKNode!
    var car09: SKNode!
    var car10: SKNode!
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "main-background")
        background.position = CGPoint(x: 1218, y: 563)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)

        //Create 10 nodes to place car image
        //Upper row
        car01 = createNode(at: CGPoint(x: 420, y: 800), imageNamed: "taxi")
        car02 = createNode(at: CGPoint(x: 820, y: 800), imageNamed: "police_car")
        car03 = createNode(at: CGPoint(x: 1218, y: 800), imageNamed: "ambulance")
        car04 = createNode(at: CGPoint(x: 1620, y: 800), imageNamed: "fire_truck")
        car05 = createNode(at: CGPoint(x: 2020, y: 800), imageNamed: "garbage_truck")
        //Bottom row
        car06 = createNode(at: CGPoint(x: 420, y: 300), imageNamed: "bulldozer")
        car07 = createNode(at: CGPoint(x: 820, y: 300), imageNamed: "excavator")
        car08 = createNode(at: CGPoint(x: 1218, y: 300), imageNamed: "cement_mixer")
        car09 = createNode(at: CGPoint(x: 1620, y: 300), imageNamed: "road_roller")
        car10 = createNode(at: CGPoint(x: 2020, y: 300), imageNamed: "crane_car")

        addChild(car01)
        addChild(car02)
        addChild(car03)
        addChild(car04)
        addChild(car05)
        addChild(car06)
        addChild(car07)
        addChild(car08)
        addChild(car09)
        addChild(car10)
    }
    
    //MARK: - Custom function
    //Create a SpriteNode
    func createNode(at position: CGPoint, imageNamed name: String) -> SKSpriteNode {
        let nodeHolder = SKSpriteNode(imageNamed: name)
        nodeHolder.name = name //need a name to transit scene
        nodeHolder.size = CGSize(width: 350, height: 350)
        nodeHolder.position = position
        nodeHolder.blendMode = .alpha
        return nodeHolder
    }
    
    //MARK: - Touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            switch touchedNode.name {
                case car01.name: //To taxi
                    let scene = PuzzleScene1(size: self.scene!.size)
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                case car02.name: //To police_car
                    let scene = PuzzleScene2(size: self.scene!.size)
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                case car03.name: //To ambulance
                    let scene = PuzzleScene3(size: self.scene!.size)
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                case car04.name: //To fire_truck
                    let scene = PuzzleScene4(size: self.scene!.size)
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                case car05.name: //To garbage_truck
                    let scene = PuzzleScene5(size: self.scene!.size)
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                case car06.name: //To bulldozer
                    let scene = PuzzleScene6(size: self.scene!.size)
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                case car07.name: //To excavator
                    let scene = PuzzleScene7(size: self.scene!.size)
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                case car08.name: //To cement_mixer
                    let scene = PuzzleScene8(size: self.scene!.size)
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                case car09.name: //To road_roller
                    let scene = PuzzleScene9(size: self.scene!.size)
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                case car10.name: //To crane_car
                    let scene = PuzzleScene10(size: self.scene!.size)
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                default:
                    break
            }
        }
    }
    
}
