//
//  GameScene.swift
//  Space Shooter
//
//  Created by Jose Martinez on 5/28/18.
//  Copyright © 2018 Jose Martinez. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    let motion = CMMotionManager()
    var timer = Timer()
    var player: SKSpriteNode?
    
    let playerSpeed = 400
    
    
    override func didMove(to view: SKView) {
        SetupAccelerometer()
        setupPlayer()
     
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
       
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    fileprivate func SetupAccelerometer() {
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
            self.motion.startAccelerometerUpdates()
        }
    }
    
    fileprivate func getTilt() -> Double{
        
        guard let data = motion.accelerometerData else {return 0}
        let x = data.acceleration.x
        return x
        
    }
    
    fileprivate func getTilt() -> Float{
        // Called before each frame is rendered
        
        guard let data = motion.accelerometerData else {return 0}
        let x = data.acceleration.x
        return Float(x)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
     
       updatePlayer()
        
    }
    
    fileprivate func updatePlayer(){
        let destinationX = (self.player?.position.x)! + CGFloat(getTilt() * Float(playerSpeed))
        
        let action = SKAction.moveTo(x: destinationX, duration: 0.25)
        player?.run(action)
        
    }
    
    fileprivate func setupPlayer(){
        
         player = childNode(withName: "player") as? SKSpriteNode
        
        let xRange = SKRange(lowerLimit: -(self.view?.bounds.width)! / 2 - 60, upperLimit: (self.view?.bounds.width)! / 2 + 60)
        
        player?.constraints = [SKConstraint.positionX(xRange)]
        
    }
}
