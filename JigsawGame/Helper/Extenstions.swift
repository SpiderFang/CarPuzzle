//
//  Extenstions.swift
//  JigsawGame
//
//  Created by Spider on 2020/8/6.
//  Copyright © 2020 SpiderWeb. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

//Operator overloading for CGPoint
extension CGPoint {
    //Subtracts two CGPoint values and returns the result as a new CGPoint.
    public static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: right.x - left.x, y: right.y - left.y)
    }
    
    //Adds two CGPoint values and returns the result as a new CGPoint.
    public static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: right.x + left.x, y: right.y + left.y)
    }
}

extension SKNode {
    //Calculate distance between two nodes
    public func distanceBetweenNodes (node1: SKNode, node2: SKNode) -> CGFloat {
        //以node的中心點position算offset
        let offset = node1.position - node2.position
        //畢氏定理算距離:直角三角形中，斜邊平方等於兩股平方和
        let distance = sqrt(pow(offset.x,2) + pow(offset.y,2))
        return distance
    }
}

//Extension for glow effect
extension SKSpriteNode {
    public func addGlow(radius: CGFloat = 80) {
        let effectNode = SKEffectNode()
        effectNode.name = "GlowEffect"
        effectNode.shouldRasterize = true
        effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": radius])
        addChild(effectNode)
        effectNode.addChild(SKSpriteNode(color: UIColor.yellow, size: self.size))
    }
}

