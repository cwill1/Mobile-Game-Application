//
//  GameViewController.swift
//  Williams_C_GameApp
//
//  Created by CWILL on 5/16/18.
//  Copyright © 2018 DePaul. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import CoreMotion

var stringScore:String? = "0"

class GameViewController: UIViewController {
let motionManager: CMMotionManager = CMMotionManager()
    @IBOutlet weak var ScoreBoard: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.ScoreBoard.text = "10"
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
   
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func testScore(){
    
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if motionManager.isAccelerometerAvailable == true {
            motionManager.startAccelerometerUpdates(to: (OperationQueue.current)!, withHandler:{
                data, error in
                if (score < -50){
                    self.ScoreBoard.text = "You Lose. Restart Game."
                }
                else if(score > 50){
                    self.ScoreBoard.text = "You Win. Restart Game"
                }
                else{
                    self.ScoreBoard.text = String(score)
                }
                
            })
        }
    }
}
