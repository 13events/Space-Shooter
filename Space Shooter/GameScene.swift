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


class GameScene: SKScene,  SKPhysicsContactDelegate {

    let motion = CMMotionManager()
    let playerSpeed = 400
    var playerShip: PlayerShip?
    let weaponTexture = SKTexture(imageNamed: "weapon.png")
    var weapons = [PlayerWeapon]()      //TODO: Change functions to not use this array so we can remove it
    
    override func didMove(to view: SKView) {
       
        SetupAccelerometer()
        createEdgeLoop()
        setupPlayer()
        physicsWorld.contactDelegate = self  //used in physics callbacks
        
    }
    
    //MARK: Handle Touch
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
   
        let bullet = PlayerWeapon(scene: self, texture: weaponTexture, collection: &weapons)
        bullet.position = (playerShip?.position)!
        bullet.position.y += 34     //make this value into a constant or something, NO MAGiC NUMBERS!
        
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
        
        /***** Move this section into updateSprites() *****/
        for bullets in children{
            if let bullet = bullets as? PlayerWeapon{
                bullet.updatePosition()
            }
        }
        /**************************************************/
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
    
    
    /// Creates the physics edgeloop that keeps things inside the frame
    /// TODO: Change height of loop to extent above screen, important when
    /// spawning hazards
    func createEdgeLoop(){
        
        //make bounds taller than screen, so we have room to spawn our hazards.
        let physicsBounds = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height + CGFloat(400))
        
        //create the edgelooop uisng size of frame
        print("Frame Width: \(frame.width)")
        print("Frame Height: \(frame.height)")
            
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: physicsBounds)
       // self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

        //set self physicsBody category to 'Bounds'
        self.physicsBody?.categoryBitMask = physicsCategories.bounds
        self.physicsBody?.restitution = 0
    }
    
    /// Setup player sprite and sets constraints
    fileprivate func setupPlayer(){
    
        playerShip = PlayerShip(scene: self)
       
    }
 
    /// Handles calling the correct update function for each childNode in the scene.
    func updateSprites(){
        
        for child in children {
            if let node = child as? PlayerShip{
                node.UpdatePosition(acceleration: getTiltAsCGFloat())
            }
        }
        
    }
    
    /// Create a Bullet object
    /// # TODO:
    /// Change this to accept arguments such as:
    /// weapon textures, player/enemy spawn location, travel direction(up/down)
    func createBullet(){
        let bullet = PlayerWeapon(scene: self, texture: weaponTexture, collection: &weapons)
        bullet.setupPhysics()
        bullet.position = (playerShip?.position)!
        bullet.position.y += 34
        addChild(bullet)
    }
    
    /// Handles physics collisions that have begun
    /// # TODO:
    /// THIS COULD BE CLEANRED UP!
    func didBegin(_ contact: SKPhysicsContact) {
       
        //seperate physic bodies
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        /// resolve collision
        
        if ((firstBody.categoryBitMask & physicsCategories.playerWeapon != 0) && (secondBody.categoryBitMask & physicsCategories.bounds != 0)){
            print("Ball Bounds Collision")
        } else if ((firstBody.categoryBitMask & physicsCategories.bounds != 0 && (secondBody.categoryBitMask & physicsCategories.playerWeapon != 0))) {
            print("Bounds Ball Collision")
            let weapon = secondBody.node as? PlayerWeapon
            weapon?.removeFromParent()
            print("Removed weapon from screen.")
                    }
        
    }
    
    
}
