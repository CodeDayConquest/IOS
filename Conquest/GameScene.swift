//
//  GameScene.swift
//  Conquest
//
//  Created by Tyler Ilunga on 11/7/15.
//  Copyright (c) 2015 Alpha. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var player: SKSpriteNode!
    var player_two: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        // Add Player to Screen
        
        /// Player One
        player = SKSpriteNode(color: UIColor.greenColor(), size: CGSize(width: 100, height: 100))
        player.position = CGPoint(x: player.size.width / 2, y: size.height / 2)
        
        
        /// Player Two
        player_two = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 100, height: 100))
         player_two.position = CGPoint(x: size.width - player_two.size.width / 2, y: size.height / 2)
        
        // Add objects to Screen
        self.addChild(player)
        self.addChild(player_two)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
    
    func moveLeft() {
        if player.position.x > player.size.width / 2 {
            player.position.x -= 0.5
        } else {
            print("not move")
        }
    }
    
    func moveRight() {
        if player.position.x < size.width - player.size.width / 2 {
            player.position.x += 0.5
        } else {
            print("not move")
        }
    }
    
    func distance() -> CGFloat {
        var xDist = CGFloat(player_two.position.x - player.position.x)
        var yDist = CGFloat(player_two.position.y - player.position.y)
        
        if player.position.x < player_two.position.x {
            xDist = (player_two.position.x - player_two.size.width / 2) - (player.position.x + player.size.width / 2)
        } else {
            xDist = (player.position.x - player.size.width / 2) - (player_two.position.x + player_two.size.width / 2)
        }
        
        if player.position.y < player_two.position.y {
            yDist = (player_two.position.y - player_two.size.width / 2) - (player.position.y + player.size.width / 2)
        } else {
            yDist = (player.position.y - player.size.width / 2) - (player_two.position.y + player_two.size.width / 2)
        }
        
        let distance = sqrt((xDist * xDist) + (yDist * yDist))
        
        return distance
    }
    
    func attack() {
        
        if distance() < size.width / 30
        {
            
        }
        
        
    }
    
    func randomNumber() -> Int {
        let random = Int(arc4random_uniform(UInt32(10)))
        
        return random
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        moveRight()
    }
}
