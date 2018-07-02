//
//  Asteroid.swift
//  Space Shooter
//
//  Created by Jose Martinez on 6/25/18.
//  Copyright © 2018 Jose Martinez. All rights reserved.
//

import Foundation
import SpriteKit

class Asteroid : Hazard {
    
    
    var spriteNode: SKSpriteNode? = nil
    
    var hazardSpeed: CGFloat = 100
    
    var spawnNode: SKNode? = nil
    
    var angularSpeed: CGFloat = 2.5
    
    init(){
        //call all setup functions in here
    }
    
    /// Sets up the spriteNode for this Asteriod
    ///
    /// - Parameters:
    ///   - scene: The calling SKScene
    ///   - texture: SKTexture applied to sprite
    func initSpriteNode(scene: GameScene, texture: SKTexture) {
        spriteNode = SKSpriteNode(texture: texture, color: UIColor.white, size: texture.size())
    }
    
    /// Setup the Asteroids physic properties
    func setupPhysics() {
        
        guard let sprite = spriteNode, let texture = spriteNode?.texture else
        {
            print("Uninitialized Asteroid SKSpriteNode!")
            return
        }
        
        sprite.physicsBody? = SKPhysicsBody(rectangleOf: texture.size(), center: sprite.anchorPoint)
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.categoryBitMask = physicsCategories.hazard
        sprite.physicsBody?.collisionBitMask = physicsCategories.none
        sprite.physicsBody?.contactTestBitMask = physicsCategories.player | physicsCategories.playerWeapon |                                               physicsCategories.bounds
        
        //set random angular velocity
        sprite.physicsBody?.angularVelocity = randomAngularVelocity()
        
        
        
        
        
    }
    
    func setSpawnPoint(scene: GameScene) {
       
    }
    
    func updatePosition() {
       
    }
    
    func randomAngularVelocity() -> CGFloat {
        return CGFloat(0.0)
    }
    
    
}
