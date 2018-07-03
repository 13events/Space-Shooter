//
//  Asteroid.swift
//  Space Shooter
//
//  Created by Jose Martinez on 6/25/18.
//  Copyright © 2018 Jose Martinez. All rights reserved.
//

import Foundation
import SpriteKit

//TODO: Explore inheritance of SKSpriteNode
class Asteroid : SKSpriteNode, Hazard {
    

    var hazardSpeed: CGFloat
    // var spawnNode: SKNode?
    
    var angularSpeed: CGFloat
    
    init(texture:SKTexture){
        
        self.hazardSpeed = 100
        self.angularSpeed = 2.5
        
        super.init(texture: texture, color: UIColor.white, size: texture.size())
        
        self.setupPhysics()
        
    }
    
    /// Setup the Asteroids physic properties
    func setupPhysics() {
        if let texture = self.texture{
            
            self.physicsBody = SKPhysicsBody(rectangleOf: texture.size(), center: self.anchorPoint)
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.categoryBitMask = physicsCategories.hazard
            self.physicsBody?.collisionBitMask = physicsCategories.none
            self.physicsBody?.contactTestBitMask = physicsCategories.player | physicsCategories.playerWeapon | physicsCategories.bounds
            
            self.physicsBody?.angularVelocity = randomAngularVelocity()
        } else {
            print("Unable to create Asteroid Physics body.")
        }
        
    }
    
    func setSpawnPoint(scene: GameScene) {
       
    }
    
    func updatePosition() {
       self.physicsBody?.velocity = CGVector(dx: 0, dy: -hazardSpeed)
    }
    
    func randomAngularVelocity() -> CGFloat {
        var randomNumber = CGFloat.random(in: -1.5...1.5)
        
        if(randomNumber == 0){  //TODO: Check between -1 and 1
            randomNumber += 1
        }
        return randomNumber * angularSpeed
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
