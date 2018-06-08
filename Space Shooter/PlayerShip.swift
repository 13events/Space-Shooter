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
        self.physicsBody?.categoryBitMask = physicsCategories.Player
        self.physicsBody?.collisionBitMask = physicsCategories.Bounds
    }
    
}
