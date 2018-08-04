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
        self.setupEvadeManeuvers()

        
    }
    
    internal func setupPhysics() {
        
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
    
    
    /// Setup the Meneuver behaviors for enemy
    fileprivate func setupEvadeManeuvers() {
        
        //TODO: Create some random move locations
        //TODO: Create SKActions with random durations and moveTo using random locations
        
        //This action creates a random move location
        let randomXMovement = SKAction.run {
            
            //get random number within app view
            var randomXLocation = CGFloat.random(in: self.center...self.rightEdge)
            
            //check that new location is at least a 50 pixel displacement from current location
            while(abs(Int32(self.position.x - randomXLocation)) < 50)
            {
                randomXLocation = CGFloat.random(in: self.center...self.rightEdge)
            }
            
            //TODO: ADD a check that randomXLocation is at least 50 pixel from current location
            let leftOrRight = Int.random(in: 0...1) //decide what direction to go
            
            if(leftOrRight == 1) {  //reverse sign to go left
                randomXLocation *= -1
            }
            
            //create a move action with random location
            let moveAction = SKAction.moveTo(x: randomXLocation, duration: 2)
            
            self.run(moveAction)
        }
        
        //setup wait action then create sequence
        let wait = SKAction.wait(forDuration: 3, withRange: 0.5)
        let sequence = SKAction.sequence([randomXMovement, wait])
        
        //run sequence on self.
        self.run(SKAction.repeatForever(sequence))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
