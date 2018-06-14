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
    let playerSpeed = 600
    var random = GKRandomDistribution.init(lowestValue: -375, highestValue: 375)
    var playerShip: PlayerShip?
    
    override func didMove(to view: SKView) {
       
        SetupAccelerometer()
        createEdgeLoop()
        setupPlayer()
        
    }
    
    //MARK: Handle Touch
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
     
        
    }
    
    /// Update objects after physics haas been simulated
    override func didSimulatePhysics() {
       // playerShip?.UpdatePosition(acceleration: getTiltAsCGFloat())
        
        updateSprites()
        
    }
    
    //MARK:
    
    /// Set up accelerometer and update interval
    fileprivate func SetupAccelerometer() {
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
            self.motion.startAccelerometerUpdates()
        }
    }
    
    /// Get x value from accelerometer
    ///
    /// - Returns: Returns a Double representing the tilt of accelerometer in the x-axis
    fileprivate func getTilt() -> Double{
        
        guard let data = motion.accelerometerData else {return 0}
        let x = data.acceleration.x
        return x
    }
    
    fileprivate func getTiltAsCGFloat() -> CGFloat{
        guard let data = motion.accelerometerData else { return 0 }
        let x = data.acceleration.x
        return CGFloat(x)
    }
    
    /// Get x value from accelerometer as float
    ///
    /// - Returns: Returns a Float representing the tilt of the accelerometer in the x-axis
    fileprivate func getTilt() -> Float{
        // Called before each frame is rendered
        
        guard let data = motion.accelerometerData else {return 0}
        let x = data.acceleration.x
        return Float(x)
        
    }
    
    
    func createEdgeLoop(){
        
        //create the edgelooop uisng size of frame
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

        //set self physicsBody category to 'Bounds'
        self.physicsBody?.categoryBitMask = physicsCategories.Bounds
        self.physicsBody?.restitution = 0
    }
    
    /// Setup player sprite and sets constraints
    
    fileprivate func setupPlayer(){
        
        //get player node from SKS file
       // playerShip = childNode(withName: "player") as? PlayerShip
        playerShip = PlayerShip(scene: self)
       // playerShip?.position = CGPoint(x: 0, y: -606)
        //playerShip?.setupPhysics()
    }
 
    func updateSprites(){
        for child in children {
            if let node = child as? PlayerShip{
                node.UpdatePosition(acceleration: getTiltAsCGFloat())
            }
        
        }
    }
    
}
