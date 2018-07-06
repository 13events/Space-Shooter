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
    let kLockWeaponActionKey = "kLockWeaponActionKey"
    let playerSpeed = 400
    var playerShip: PlayerShip?
    let weaponTexture = SKTexture(imageNamed: "weapon.png")
    let asteroid01Texture = SKTexture(imageNamed: "Asteroid01.png")
    let triangle = SKTexture(imageNamed: "Triangle.png")
    let square = SKTexture(imageNamed: "Square.png")
    let stackedSquares = SKTexture(imageNamed: "Stacked_Square")
    let star = SKTexture(imageNamed: "Star.png")
    var weapons = [PlayerWeapon]()      //TODO: Change functions to not use this array so we can remove it.
    var hazards = [Hazard]()            //TODO: Change functions to not use this array so we can remove it.
    var spawner: Spawner?
    var scoreLabel: SKLabelNode?
    
    var score: Int = 0 {
        didSet {
            //TODO: Update score label
            print("Score: \(score)")
            guard scoreLabel != nil else {return}
            scoreLabel?.text = "\(score)"
        }
    }
    
    override func didMove(to view: SKView) {
       
        SetupAccelerometer()
        setupPhysicsBounds()
        setupPlayer()
        physicsWorld.contactDelegate = self  //used in physics callbacks
        setupScoreLabel()
        
        //init spawner object
        spawner = Spawner(scene: self, textures: [triangle, square,stackedSquares, star])
    }
    
    //MARK: Handle touch
    
    //TODO: Code spawns shot even when player is removed from scene
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
       // guard spawner != nil  else {return}
        //spawner?.spawnRandom()
        shoot(scene: self, texture: weaponTexture, collection: &weapons, duration: 0.5) //Roll this into player Class?
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    //MARK: Updata Functions
    override func update(_ currentTime: TimeInterval) {
     updateSprites()
        
    }
    
    /// Handles calling the correct update function for each childNode in the scene.
    func updateSprites(){
    
        
        for node in children {
            //check player
            if let player = node as? PlayerShip{
                player.UpdatePosition(acceleration: getTiltAsCGFloat())
            }
            //check bullets
            if let bullet = node as? PlayerWeapon{
                bullet.updatePosition()
            }
            //check hazards
            if let hazard = node as? HazardProtocol{
                hazard.updatePosition()
            }
        }
        
    }
    
    
    //MARK: Setup Functions
    
    func setupScoreLabel(){
        scoreLabel = childNode(withName: "scoreLabel") as? SKLabelNode
        scoreLabel?.text = "\(score)"
    
    }
    /// Set up accelerometer and update interval
    fileprivate func SetupAccelerometer() {
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
            self.motion.startAccelerometerUpdates()
        }
    }
    
    /// Setup player sprite
    fileprivate func setupPlayer(){
        
        playerShip = PlayerShip(scene: self)
        
    }
    
    /// Creates the physics edgeloop that keeps things inside the frame
    /// TODO: Change height of loop to extend below screen, important when
    /// spawning hazards
    func setupPhysicsBounds(){
        
        //make bounds taller than screen and shift down so we have room to spawn our hazards.
        let physicsBounds = CGRect(x: frame.origin.x, y: frame.origin.y - 200, width: frame.width, height: frame.height + CGFloat(400))
        
        //creat physics edgeloop
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: physicsBounds)
        
        //set self physicsBody category to 'Bounds'
        self.physicsBody?.categoryBitMask = physicsCategories.bounds
        self.physicsBody?.restitution = 0
    }
    
    //MARK: Helper Functions
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
    
    /// Create a Bullet object
    /// # TODO:
    /// Change this to accept arguments such as:
    /// weapon textures, player/enemy spawn location, travel direction(up/down)
    func shoot(scene: GameScene, texture: SKTexture, collection: inout [PlayerWeapon], duration: Double){
        
        //check if weapon is locked
        guard self.action(forKey: kLockWeaponActionKey) == nil else {
            print("Weapon Locked!")
            return
        }
        
        //Bullet setup
        let bullet = PlayerWeapon(scene: scene, texture: texture, collection: &collection)
       // bullet.setupPhysics()
        bullet.position = (playerShip?.position)!
        bullet.position.y += 34
        //addChild(bullet)
        
        //lock weapon
        self.run(SKAction.wait(forDuration: duration),withKey: kLockWeaponActionKey)
        
        
    }
    
    
    //MARK: Physics Delegate
    
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
        
        //check ball/bouncs collision
        if ((firstBody.categoryBitMask & physicsCategories.bounds != 0 && (secondBody.categoryBitMask & physicsCategories.playerWeapon != 0))) {
            print("Bounds Ball Collision")
            let weapon = secondBody.node as? PlayerWeapon
            weapon?.removeFromParent()
            print("Removed weapon from screen.")
            
            //check hazard/bounds collision
        } else if ((firstBody.categoryBitMask & physicsCategories.bounds != 0 && (secondBody.categoryBitMask & physicsCategories.hazard != 0))){
             print("Asteroid and Physics Bounds contact")
            if let hazard = secondBody.node as? Hazard{
                hazard.removeFromParent()
            }
            
            //check hazard/weapon collision
        } else if ((firstBody.categoryBitMask & physicsCategories.playerWeapon != 0 && (secondBody.categoryBitMask & physicsCategories.hazard != 0))){
            print("Weapon and Asteroid collision")
            if let playerWeapon = firstBody.node as? PlayerWeapon, let hazard = secondBody.node as? Hazard{
                playerWeapon.removeFromParent()
                hazard.removeFromParent()
                score += 1
            }
            
            //check player/hazard collision
        } else if ((firstBody.categoryBitMask & physicsCategories.player != 0 && (secondBody.categoryBitMask &
            physicsCategories.hazard != 0))){
            print("Hazard/Player collision")
            if let player = firstBody.node as? PlayerShip, let hazard = secondBody.node as? Hazard{
                player.removeFromParent()
                hazard.removeFromParent()
            }
            
        }
        
    }
    
    
}
