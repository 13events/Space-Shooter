//
//  Spawner.swift
//  Space Shooter
//
//  Created by Jose Martinez on 6/20/18.
//  Copyright © 2018 Jose Martinez. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Spawner{
    let leftEdge = CGFloat(-260)
    let rightEdge = CGFloat(260)
    let scene: GameScene
    let spawnNode: SKNode?
    var textures = [SKTexture]()
    
    init(scene: GameScene, textures: [SKTexture]){
        self.textures = textures
        self.scene = scene
        spawnNode = scene.childNode(withName: "Spawn_Node") //get refernece to spawn_node in SKS file
        
        let spawnTimer = SKAction.run { self.spawnRandom() }
        let waitTime = SKAction.wait(forDuration: 0.5)
        
        let spawnSequence = SKAction.sequence([spawnTimer,waitTime])
        
        scene.run(SKAction.repeatForever(spawnSequence))
    }
    
    /// Spawns a random hazard at a random position off screen along the x-axis
    func spawnRandom(){
        
        //shuffle textures
        self.textures.shuffle()
        
        //pick a random texture
        if let texture = self.textures.first{
            
            //randomly move spawn_Node
            let randomXPos = CGFloat.random(in: -260...260)
            
            //set spawn_Node x position
            spawnNode?.position.x = randomXPos
            
            guard let spawnPos = spawnNode?.position else { return }
            //create new Hazard from texture
            let hazard = Hazard(scene: scene, texture: texture)
            
            //set Hazard positon to spawn_Node position
            hazard.position = spawnPos
            
            
        }
    }
    
}
