//
//  GameViewController.swift
//  Conquest
//
//  Created by Tyler Ilunga on 11/7/15.
//  Copyright (c) 2015 Alpha. All rights reserved.
//

import UIKit
import SpriteKit
import Socket_IO_Client_Swift

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            // Detect the screensize
            let sizeRect = UIScreen.mainScreen().applicationFrame
            let width = sizeRect.size.width * UIScreen.mainScreen().scale
            let height = sizeRect.size.height * UIScreen.mainScreen().scale
            
            // Scene should be shown in fullscreen mode
            let scene = GameScene(size: CGSizeMake(width, height))
            
            
            // Configure the view.
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)

        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    @IBAction func back(sender: AnyObject) {
        goBack()
    }
    
    func goBack() // goes back to main view controller
    {
        if let navController = self.navigationController {
            navController.popToRootViewControllerAnimated(false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
