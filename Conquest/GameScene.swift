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
        player = SKSpriteNode(color: UIColor.greenColor(), size: CGSize(width: 100, height: 100))
        player_two = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 100, height: 100))
        
        // add player to screen
        player.position = CGPoint(x: player.size.width / 2, y: size.height / 2)
        player_two.position = CGPoint(x: size.width - player_two.size.width / 2, y: size.height / 2)
        
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
        let xDist = CGFloat(player_two.position.x - player.position.x)
        let yDist = CGFloat(player_two.position.y - player.position.y)
        let distance = sqrt((xDist * xDist) + (yDist * yDist))
        
        return distance
    }
    
    func attack() {
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        moveRight()
    }
}
