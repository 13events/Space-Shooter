//
//  Enemy.swift
//  Space Shooter
//
//  Created by Jose Martinez on 6/25/18.
//  Copyright © 2018 Jose Martinez. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy : Hazard, HazardProtocol {
   
    let leftEdge = CGFloat(-260)
    let rightEdge = CGFloat(260)
    let center = CGFloat(0)
    
    //Initilizae the object with a texture and a moving speed
    init(texture:SKTexture, speed: CGFloat){
     
        super.init(texture: texture, hazardSpeed: speed)
        self.setupPhysics()
        
        //Basic Evasion menuvers using random timer and predetermined destinations.
        //TODO: Create random destinations rather than predetermined ones.
        //TODO: Continue implementing a custome SKAction, perhaps we can implement randomness inside here.
        let customAction = SKAction.run ({
            print("Im inside the skAction.run block inside Enemy Object.")
        })
        self.run(customAction)
        let moveLeft = SKAction.moveTo(x: leftEdge, duration: 1)
        let moveRight = SKAction.moveTo(x: rightEdge, duration: 1)
        let moveCenter = SKAction.moveTo(x: center, duration: 1)
        let waitTime = SKAction.wait(forDuration: 2, withRange: 4)
        
        let evadeSequence = SKAction.sequence([waitTime,moveLeft,waitTime,moveCenter,waitTime,moveRight, waitTime, moveCenter])
        run(SKAction.repeatForever(evadeSequence))

        
    }
    
    func setupPhysics() {
        
        if let texture = self.texture {
            
            self.physicsBody = SKPhysicsBody(rectangleOf: texture.size(), center: self.anchorPoint)
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.categoryBitMask = physicsCategories.hazard
            self.physicsBody?.collisionBitMask = physicsCategories.none
            self.physicsBody?.contactTestBitMask = physicsCategories.player | physicsCategories.playerWeapon | physicsCategories.bounds
            
            
        } else {
            print("Unable to create Enemy Physics body.")
        }
        
    }
    
    
    func updatePosition() {
        self.physicsBody?.velocity = CGVector(dx: 0, dy: -self.hazardSpeed)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
