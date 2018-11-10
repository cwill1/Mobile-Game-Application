//
//  GameScene.swift
//  Williams_C_GameApp
//
//  Created by CWILL on 5/16/18.
//  Copyright © 2018 DePaul. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion
//added code

var motionManager = CMMotionManager()
var destX:CGFloat  = 0.0
var destY:CGFloat = 0.0

var score = 0

let wallMask:UInt32 = 0x1 << 0 // 1
let ballMask:UInt32 = 0x1 << 1// 2
let redSquareMask:UInt32 = 0x1 << 2// 4
let greenSquareMask:UInt32 = 0x1 << 3 // 8

var gameOn = true;

let test = GameViewController()


class GameScene: SKScene, SKPhysicsContactDelegate {
    var x: CGFloat = 0, y: CGFloat = 0, r: CGFloat = 25
    var velocity: CGFloat = 1
    var dx: CGFloat = 1, dy: CGFloat = 1

    var destX2:CGFloat = 0.0
    var destY2:CGFloat = 0.0
    var rollingBall = SKSpriteNode()
    var player = SKSpriteNode()
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "WhiteBall") as! SKSpriteNode
        self.player.position = CGPoint(x:self.frame.size.width/2, y: self.frame.size.height/2)
      
      
        
        
        if motionManager.isAccelerometerAvailable == true {
            // 2
            motionManager.startAccelerometerUpdates(to: (OperationQueue.current)!, withHandler:{
                data, error in
            
                destX += CGFloat((data?.acceleration.x)! * 1.5)
                destY += CGFloat((data?.acceleration.y)! * 1.5)
            
                let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
                borderBody.friction = 0
                self.physicsBody = borderBody
                
                
              
            })
            
        }
        
     
        
    }
    
    func boundary(){
        if destX < self.frame.size.width * 0.01 || destX > self.frame.size.width - 0{
            destX = -destX
        }
        if destY < self.frame.size.height * 0.01 || destY > self.frame.size.height - self.r {
            destY = -destY
        } 
    }
    func update2() {
     
        if destX < r || destX > frame.size.width - r {
            destX = -destX
        }
        if destY < r || destY > frame.size.height - r {
            destY = -destY
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
     
        let action = SKAction.moveTo(x: destX, duration: 1)
        let actionY = SKAction.moveTo(y:destY, duration:1)
       
        
        rollingBall.run(action)
        rollingBall.run(actionY)
        
        let action2 = SKAction.moveTo(x: destX, duration: 1)
        let action3 = SKAction.moveTo(y: destY, duration: 1)
        self.player.run(action2)
        self.player.run(action3)
        
    }
  
    func didBegin(_ contact: SKPhysicsContact) {
    
        let ball = (contact.bodyA.categoryBitMask == ballMask) ? contact.bodyA : contact.bodyB
        let other = (ball == contact.bodyA) ? contact.bodyB : contact.bodyA
        
        let redSquare = (contact.bodyA.categoryBitMask == redSquareMask) ? contact.bodyA : contact.bodyB
        let other2 = (redSquare == contact.bodyA) ? contact.bodyB : contact.bodyA
        
        
       
        if(other.categoryBitMask == 4){
            print("lose a point")
            score -= 1
        }
            
        else if(other.categoryBitMask == 8){
            print("Gain a point")
            score += 1

        }
        else if(other2.categoryBitMask == 1){
            print("lose a point")
            score -= 1
        }
        else if (other.categoryBitMask == 0){
            print("hit wall")
        }
        else{
            //do nothing
        }
        test.testScore()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let redSquare2:SKSpriteNode = SKScene(fileNamed: "Scene")!.childNode(withName: "Red2")!as!SKSpriteNode
        redSquare2.physicsBody?.collisionBitMask = ballMask | redSquareMask
        
        let redSquare1:SKSpriteNode = SKScene(fileNamed: "Scene")!.childNode(withName: "Red1")!as!SKSpriteNode
        redSquare1.physicsBody?.collisionBitMask = ballMask | redSquareMask | greenSquareMask
        
        let greenSquare1:SKSpriteNode = SKScene(fileNamed: "Scene")!.childNode(withName: "Green1")!as!SKSpriteNode
        greenSquare1.physicsBody?.collisionBitMask = wallMask | ballMask | redSquareMask | greenSquareMask
    }
}
