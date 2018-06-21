//
//  Hazards.swift
//  Space Shooter
//
//  Created by Jose D Martinez on 6/14/18.
//  Copyright © 2018 Jose Martinez. All rights reserved.
//

import Foundation
import SpriteKit


/// Class is used to create and spawn new hazards.
class Hazard: SKSpriteNode {
    
    let hazardSpeed: CGFloat = 100
    var spawnNode: SKNode?
    let angularSpeed: CGFloat = 2.5
    
    /// Initialize a new Hazard
    ///
    /// - Parameters:
    ///   - scene: The calling scene
    ///   - texture: SKTexture image for hazard
    ///   - hazardsCollection: Array being used to track hazards
    convenience init(scene: GameScene, texture: SKTexture, hazardsCollection: inout [Hazard]){
        self.init(texture: texture, color: UIColor.white, size: texture.size())
       
        setupPhysics()
        //set spawn point
        setSpawnPoint(scene: scene)
        //add to hazardsCollection**
        //add to scene
        scene.addChild(self)
        
    }
    
    /// Setup hazards physicsBody
    fileprivate func setupPhysics(){
        
        //check that we have a texture
        if let texture = self.texture {
            
            self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.categoryBitMask = physicsCategories.hazard
            self.physicsBody?.collisionBitMask = 0
            self.physicsBody?.contactTestBitMask = physicsCategories.player | physicsCategories.playerWeapon
                                                                                        | physicsCategories.bounds
            
            //TODO: angularVelocity value needs to be generated from random unit circle
            self.physicsBody?.angularVelocity = randomAngularVelocity()
            
            
        } else {
            print("Unable to crate Hazard Physics body")
        }
        
        
    }
    
    /// Get reference to spawn_node and set sprites position = spawn_node position
    ///
    /// - Parameter scene: The Calling SKScene
    fileprivate func setSpawnPoint(scene:GameScene){
        
        //capture spawn point
        spawnNode = scene.childNode(withName: "Spawn_Node")
        
        //set sprite location to spawnNode location
        if let spawnPosition = spawnNode?.position{
            self.position = spawnPosition
        }
    }
    
    func updatePosition(){
        self.physicsBody?.velocity = CGVector(dx: 0, dy: -hazardSpeed)
        //print("\(randomAngularVelocity() * 1.5)")
    }
    
    
    /// Generate a random angular velocity
    ///
    /// - Returns: CGFloat
    func randomAngularVelocity() -> CGFloat{
        
        var randomNumber = CGFloat.random(in: -1.5...1.5)
        
        if(randomNumber == 0){
            randomNumber += 1
        }
        return randomNumber * angularSpeed
        
    }
}
