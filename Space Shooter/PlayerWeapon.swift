//
//  PlayerWeapon.swift
//  Space Shooter
//
//  Created by Jose Martinez on 6/8/18.
//  Copyright © 2018 Jose Martinez. All rights reserved.
//
import Foundation
import SpriteKit

/// Class represents a player weapon, initialize with init(scene:texture:collection:)
/// Contains methods for updating position and setting up physics.
/// If you want to make changes to the object after creationg, capture the object in a let or var statement
class PlayerWeapon: SKSpriteNode {

    /// speed of weapon
    let weaponSpeed: CGFloat = 900
    
    
    /// Initialized the class object and its physics properties
    /// Adds the sprite to the SKScene object
    /// appends the sprite into a passed in array
    /// - Parameters:
    ///   - scene: The calling SKScene Object
    ///   - texture: an SKTecture used to init the sprite
    ///   - collection: SKSpriteNode array
    init(scene: GameScene, texture: SKTexture, collection: inout  [PlayerWeapon]){
        super.init(texture: texture, color: UIColor.white, size: texture.size())
        self.setupPhysics()
        //collection.append(self)
        scene.addChild(self)
        
    }
    
    
    /// Simple function that moves weapon using the weapon speed.
    func updatePosition(){
        self.physicsBody?.velocity = CGVector(dx: 0, dy: weaponSpeed)
        
    }
    
    /// Sets physic properties of the weapon object
    /// sets Circular physics body
    func setupPhysics(){
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: max(self.size.width / 2 , self.size.height / 2 ))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = physicsCategories.playerWeapon
        self.physicsBody?.collisionBitMask = physicsCategories.none
        self.physicsBody?.contactTestBitMask = physicsCategories.bounds //notify of intersections with the bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
