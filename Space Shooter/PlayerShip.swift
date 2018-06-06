//
//  PlayerShip.swift
//  Space Shooter
//
//  Created by Jose Martinez on 6/1/18.
//  Copyright © 2018 Jose Martinez. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerShip : SKSpriteNode {
    
    let moveSpeed:CGFloat = 3000
    
    
    func UpdatePosition(acceleration: CGFloat){
     self.physicsBody?.velocity = CGVector(dx: acceleration * moveSpeed, dy: 0)
    }
    
    func setupPhysics(){
        self.physicsBody?.categoryBitMask = physicsCategories.Player
        self.physicsBody?.collisionBitMask = physicsCategories.Bounds
    }
    
}
