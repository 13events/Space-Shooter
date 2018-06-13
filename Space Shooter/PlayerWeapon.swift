//
//  PlayerWeapon.swift
//  Space Shooter
//
//  Created by Jose Martinez on 6/8/18.
//  Copyright © 2018 Jose Martinez. All rights reserved.
//
import Foundation
import SpriteKit

class PlayerWeapon: SKSpriteNode {

    let weaponSpeed: CGFloat = 900
    
    init(scene: GameScene, texture: SKTexture, collection: inout  [PlayerWeapon]){
        super.init(texture: texture, color: UIColor.white, size: texture.size())
        self.setupPhysics()
        //collection.append(self)
        scene.addChild(self)
        
    }
    
    
    func updatePosition(){
        self.physicsBody?.velocity = CGVector(dx: 0, dy: weaponSpeed)
        
    }
    
    func setupPhysics(){
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: max(self.size.width / 2 , self.size.height / 2 ))
        self.physicsBody?.categoryBitMask = physicsCategories.playerWeapon
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = physicsCategories.bounds //notify of intersections with the bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
