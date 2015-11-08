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
    var blockButton: SKSpriteNode! = nil
    var attackButton: SKSpriteNode! = nil
    
    override func didMoveToView(view: SKView)
    {
        /* Setup your scene here */
        // Add Player to Screen
        
        /// Player One
        player = Player(health: 100, size: CGSize(width: 100, height: 100), pos: CGPoint(x: size.width * 0.25, y: size.height / 2.0), playerImage: nil, level: 1, playerXP: 100);
        
        /// Player Two
        player_two = Player(health: 100, size: CGSize(width: 100, height: 100), pos: CGPoint(x: size.width * 0.75, y: size.height / 2.0), playerImage: nil, level: 1, playerXP: 100);
        
        // add Buttons
        rightButton = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: size.width / 4, height: size.height / 3))
        rightButton.position = CGPoint(x: rightButton.size.width / 2, y: rightButton.size.height / 2)
        
        leftButton = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: size.width / 4, height: size.height / 3))
        leftButton.position = CGPoint(x: size.width / 2 + leftButton.size.width / 2, y: leftButton.size.height / 2)
        

        // Add objects to Screen
        self.addChild(player)
        self.addChild(player_two)
        self.addChild(rightButton)
        self.addChild(leftButton)
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
        }
        else {
            xDist = 0;
        }
        
        if player.position.y + player.size.height / 2 < player_two.position.y - player_two.size.height / 2 {
            yDist = CGFloat(player_two.position.y - player_two.size.height / 2) - CGFloat(player.position.y + player.size.height / 2)
        } else if player.position.y - player.size.height / 2 > player_two.position.y + player_two.size.width / 2 {
            yDist = (player.position.y - player.size.height / 2) - (player_two.position.y + player_two.size.height / 2)
        }
        
        else {
            yDist = 0
        }
        
        print("x: \(xDist), y: \(yDist)")
        
        let distance = sqrt((xDist * xDist) + (yDist * yDist))
        
        return distance
    }
    
    func attack() {
        
        if distance() < player.size.width * 2
        {
            
        }
        
        
    }
    
    func randomNumber() -> Int {
        let random = Int(arc4random_uniform(UInt32(10)))
        return random
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
//        if counter < 200
//        {
//            moveRight()
//        } else{
//            moveLeft()
//        }
        print(distance())
        counter++
    }
}
