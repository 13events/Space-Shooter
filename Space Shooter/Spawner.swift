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
        
        let spawn = SKAction.run { self.spawnRandom() }
        let waitTime = SKAction.wait(forDuration: 1.5)
        
        let spawnSequence = SKAction.sequence([spawn,waitTime])
        
        scene.run(SKAction.repeatForever(spawnSequence))
    }
    
    /// Spawns a random hazard at a random position off screen along the x-axis
    func spawnRandom(){
        
        //shuffle textures
        self.textures.shuffle()
        
        //pick a random texture
        if let texture = self.textures.first{
            
            //if enemy texture, make enemy.
            if let textureName = texture.name{
                
                if  textureName.contains("enemy") {
                    print("This is an enemy.")
                    print("\(textureName)")
                    
                    //randomly move spawn_Node
                    let randomXPos = CGFloat.random(in: -260...260)
                    
                    //set spawn_Node x position
                    spawnNode?.position.x = randomXPos
                    
                    guard let spawnPos = spawnNode?.position else { return }
                    
                    //create new Hazard from texture
                    let enemy = Enemy(texture: texture, speed: 100)
                
                    
                    //set Hazard positon to spawn_Node position
                    enemy.position = spawnPos
                    scene.addChild(enemy)
                    
                    
                } else {
                    
                    print("Created Asteroid")
                    
                    //randomly move spawn_Node
                    let randomXPos = CGFloat.random(in: -260...260)
                    
                    //set spawn_Node x position
                    spawnNode?.position.x = randomXPos
                    
                    guard let spawnPos = spawnNode?.position else { return }
                    
                    //create new Hazard from texture
                    let asteroid = Asteroid(texture: texture, asteroidSpeed: 100)
                    
                    //set Hazard positon to spawn_Node position
                    asteroid.position = spawnPos
                    scene.addChild(asteroid)
                    
                }
                
            }
            
            
        }
    }
    
}
