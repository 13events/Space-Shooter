//
//  PlayerShip.swift
//  Space Shooter
//
//  Created by Jose Martinez on 6/1/18.
//  Copyright © 2018 Jose Martinez. All rights reserved.
//

import Foundation
import SpriteKit

let leftEdge = CGFloat(-260)
let rightEdge = CGFloat(260)

class PlayerShip : SKSpriteNode {
    
    let moveSpeed:CGFloat = 3000
    //let player: PlayerShip? = nil
    
    convenience init(scene: GameScene){
        let playerTexture = SKTexture(imageNamed: "player_ship")
        let playerNode = scene.childNode(withName: "player_node")
        self.init(texture: playerTexture, color: UIColor.white, size: playerTexture.size())
        self.scale(to: CGSize(width: self.size.width / 2, height: self.size.height / 2))
        self.position = (playerNode?.position)!
        
        self.setupPhysics()
        scene.addChild(self)
        
    }
    func UpdatePosition(acceleration: CGFloat){
        
        //get physics Body position
        guard let xPos = self.physicsBody?.node?.position.x else { return }
        
        //apply velocity to physics Body
        self.physicsBody?.velocity = CGVector(dx: acceleration * moveSpeed, dy: 0)
        
        //make sure sprite and physics body stary inside edges
        if(xPos < CGFloat(leftEdge)){
            self.position.x = leftEdge
            self.physicsBody?.node?.position.x = leftEdge
        } else if ( xPos > CGFloat(rightEdge)) {
            self.position.x = rightEdge
            self.physicsBody?.node?.position.x = rightEdge
        }
        
    }
    
    func setupPhysics(){
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = physicsCategories.Player
        self.physicsBody?.collisionBitMask = physicsCategories.Bounds
    }
    
}
