//
//  MainMenuScene.swift
//  Space Shooter
//
//  Created by Jose Martinez on 12/7/20.
//  Copyright © 2020 Jose Martinez. All rights reserved.
//

import SpriteKit

class MainMenuScene : SKScene {
    
    override func didMove(to view: SKView) {
        let playButton = childNode(withName: "PlayButton") as? SKSpriteNode
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let locationInScene = touch!.location(in: self)
        let touchedNode = self.atPoint(locationInScene)
        let transition = SKTransition.fade(with: UIColor.black, duration: 3.0)
        
        if let nodeName = touchedNode.name {
            if nodeName == "PlayButton" {
               
                let nextScene = SKScene(fileNamed: "GameScene")
                nextScene?.scaleMode = .aspectFill
                self.view?.presentScene(nextScene!, transition: transition)
                
            }
        }
    }
}
