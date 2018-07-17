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

/// Playershiop class represents the player
/// use init(scene:) to initialize
/// object and its physics and location
class PlayerShip : SKSpriteNode {
    
    let moveSpeed:CGFloat = 3000
    //let player: PlayerShip? = nil
    
    /// Default initializer setting texture of sprite.
    /// Sets ship to location of 'player_node'
    /// sets up physics and adds it to scene
    /// - Parameter scene: the calling SKScene object
    convenience init(scene: GameScene){
        let playerTexture = SKTexture(imageNamed: "player_ship")
        let playerNode = scene.childNode(withName: "player_node")
        self.init(texture: playerTexture, color: UIColor.white, size: playerTexture.size())
        
        //scale sprite to half size for better fit on screen
        //TODO: Create a new sprite texture that does not require scaling.
        self.scale(to: CGSize(width: self.size.width / 2, height: self.size.height / 2))
        self.position = (playerNode?.position)!
        
        self.setupPhysics()
        scene.addChild(self)
        
    }
    
    
    /// updates position of player ship using accelerometer data
    ///
    /// - Parameter acceleration: CGFloat from acelerometer in x axis
    func UpdatePosition(acceleration: CGFloat){
        
        //get physics Body current position
        guard let xPos = self.physicsBody?.node?.position.x else { return }
        
        //calculate new phyiscs velocity
        self.physicsBody?.velocity = CGVector(dx: acceleration * moveSpeed, dy: 0)
        
        //make sure sprite and physics body stay inside edges of physics edgelooop
        if(xPos < CGFloat(leftEdge)){
            self.position.x = leftEdge
            self.physicsBody?.node?.position.x = leftEdge
        } else if ( xPos > CGFloat(rightEdge)) {
            self.position.x = rightEdge
            self.physicsBody?.node?.position.x = rightEdge
        }
    }
    
    /// setup physic properties for player
    func setupPhysics(){
        
        
        guard let texture = self.texture else {print("Could not get player texture"); return}
        
        //Create a CGSize that is scaled to half the size of the original texture
        //This is done becaues we are rendering player sprite at ha;d size.
        let textureSize:CGSize = CGSize(width: texture.size().width/2, height: texture.size().height/2)
        
        self.physicsBody = SKPhysicsBody(texture: texture, size: textureSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = physicsCategories.player
        self.physicsBody?.collisionBitMask = physicsCategories.bounds
        
    }
    
}
