//
//  GameScene.swift
//  Conquest
//
//  Created by Tyler Ilunga on 11/7/15.
//  Copyright (c) 2015 Alpha. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var player: Player! = nil
    var player_two: Player! = nil
    
    var counter: Int = 0
    
    var rightButton: SKSpriteNode! = nil
    var leftButton: SKSpriteNode! = nil
    var jumpButton: SKSpriteNode! = nil
    var punchButton: SKSpriteNode! = nil
    var kickButton: SKSpriteNode! = nil
    var blockButton: SKSpriteNode! = nil
    
    override func didMoveToView(view: SKView)
    {
        /* Setup your scene here */
        // Add Player to Screen
        
        /// Player One
        player = Player(health: 100, size: CGSize(width: 100, height: 100), pos: CGPoint(x: size.width * 0.25, y: size.height / 2.0), playerImage: nil, level: 1, playerXP: 100);
        
        /// Player Two
        player_two = Player(health: 100, size: CGSize(width: 100, height: 100), pos: CGPoint(x: size.width * 0.75, y: size.height / 2.0), playerImage: nil, level: 1, playerXP: 100);
        
        // Add Buttons to Screen
        
        /// Right Button
        //rightButton = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: size.width / 4, height: size.height / 3))
        //rightButton.position = CGPoint(x: rightButton.size.width / 2, y: rightButton.size.height / 2)
        
        /// Left Button
        //leftButton = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: size.width / 4, height: size.height / 3))
        //leftButton.position = CGPoint(x: size.width / 2 + leftButton.size.width / 2, y: leftButton.size.height / 2)
        
        /// Jump Button
        
        /// Punch Button
        punchButton = SKSpriteNode(color: UIColor.purpleColor(), size: CGSize(width: size.width / 4, height: size.height / 3))
        punchButton.position = CGPoint(x: punchButton.size.width / 2, y: punchButton.size.height / 2)
        
        /// Kick Button
        
        /// Block Button

        // Add objects to Screen
        self.addChild(player)
        self.addChild(player_two)
        //self.addChild(rightButton)
        //self.addChild(leftButton)
        self.addChild(punchButton)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            if rightButton.containsPoint(location) {
                moveRight()
                print("right!")
            }
            
            if leftButton.containsPoint(location) {
                moveLeft()
                print("left")
            }
            
            if punchButton.containsPoint(location) {
                attack(10, block: true)
            }
            
        }
    }
    
    func moveLeft() {
        if player.position.x > player.size.width / 2 {
            player.position.x -= 10
        } else {
            print("not move")
        }
    }
    
    func moveRight() {
        if player.position.x < size.width - player.size.width / 2 {
            player.position.x += 10
        } else {
            print("not move")
        }
    }
    
    func distance() -> CGFloat {
        var xDist = CGFloat(player_two.position.x - player.position.x)
        var yDist = CGFloat(player_two.position.y - player.position.y)
        
        if player.position.x + player.size.width / 2 < player_two.position.x - player_two.size.width / 2 {
            xDist = CGFloat(player_two.position.x - player_two.size.width / 2) - CGFloat(player.position.x + player.size.width / 2)
        } else if player.position.x - player.size.width / 2 >  player_two.position.x + player_two.size.width / 2 {
            xDist = CGFloat(player.position.x - player.size.width / 2) - CGFloat(player_two.position.x + player_two.size.width / 2)
        } else {
            xDist = 0;
        }
        
        if player.position.y + player.size.height / 2 < player_two.position.y - player_two.size.height / 2 {
            yDist = CGFloat(player_two.position.y - player_two.size.height / 2) - CGFloat(player.position.y + player.size.height / 2)
        } else if player.position.y - player.size.height / 2 > player_two.position.y + player_two.size.width / 2 {
            yDist = (player.position.y - player.size.height / 2) - (player_two.position.y + player_two.size.height / 2)
        } else {
            yDist = 0
        }
        
        print("x: \(xDist), y: \(yDist)")
        
        let distance = sqrt((xDist * xDist) + (yDist * yDist))
        
        return distance
    }
    
    func attack(damage: Int, block: Bool) {
        if distance() < player.size.width {
            let randDamage = Float(arc4random_uniform(UInt32(damage)))
            var damageReduction = Float()
            
            if block {
                damageReduction = Float(arc4random_uniform(UInt32(100)))
            } else {
                print("No block")
            }
            
            player.playerHealth -= randDamage - damageReduction
        }
    }
    
    func randomNumber() -> Int {
        let random = Int(arc4random_uniform(UInt32(10)))
        return random
    }
    
    override func update(currentTime: CFTimeInterval) {
        print(distance())
        counter++
    }
}
