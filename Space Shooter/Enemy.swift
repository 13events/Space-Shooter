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
    
    //Initilizae the object with a texture and a moving speed
    init(texture:SKTexture, speed: CGFloat){
     
        super.init(texture: texture, hazardSpeed: speed)
        self.setupPhysics()
        
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
