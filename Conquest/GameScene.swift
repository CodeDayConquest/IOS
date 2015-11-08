//
//  GameScene.swift
//  Conquest
//
//  Created by Tyler Ilunga on 11/7/15.
//  Copyright (c) 2015 Alpha. All rights reserved.
//

import SpriteKit
import Socket_IO_Client_Swift

class GameScene: SKScene {
    
    var player: Player! = nil
    var other_player: Player! = nil
    
    var counter: Int = 0
    
    var rightButton: SKSpriteNode! = nil
    var leftButton: SKSpriteNode! = nil
    var jumpButton: SKSpriteNode! = nil
    var punchButton: SKSpriteNode! = nil
    var kickButton: SKSpriteNode! = nil
    var blockButton: SKSpriteNode! = nil
    
    //let socket = SocketIOClient(socketURL: "http://45.55.169.135:3000", options: [.Log(true), .ForcePolling(true)])
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        // Add Player to Screen
        
        /// Player One
        player = Player(playerHealth: 100, playerSize: CGSize(width: 100, height: 100), playerPos: CGPoint(x: size.width * 0.25, y: size.height / 2.0), playerSprite: nil, playerLevel: 1, playerXP: 100, playerUUID: "", matchID: "", playerState: PlayerState.Idle, playerDirection: PlayerDirection.Right)
        
        /// Player Two
        other_player =  Player(playerHealth: 100, playerSize: CGSize(width: 100, height: 100), playerPos: CGPoint(x: size.width * 0.75, y: size.height / 2.0), playerSprite: nil, playerLevel: 1, playerXP: 100, playerUUID: "", matchID: "", playerState: PlayerState.Idle, playerDirection: PlayerDirection.Left)
        
        // Add Buttons to Screen
        
        /// Right Button
        rightButton = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: size.width / 4, height: size.height / 3))
        rightButton.position = CGPoint(x: rightButton.size.width / 2, y: rightButton.size.height / 2)
        
        /// Left Button
        leftButton = SKSpriteNode(color: UIColor.purpleColor(), size: CGSize(width: size.width / 4, height: size.height / 3))
        leftButton.position = CGPoint(x: size.width / 2 + leftButton.size.width / 2, y: leftButton.size.height / 2)
        
        /// Jump Button
        
        /// Punch Button
        //punchButton = SKSpriteNode(color: UIColor.purpleColor(), size: CGSize(width: size.width / 4, height: size.height / 3))
        //punchButton.position = CGPoint(x: punchButton.size.width / 2, y: punchButton.size.height / 2)
        
        /// Kick Button
        
        /// Block Button
        
        // Add objects to Screen
        self.addChild(player)
        self.addChild(other_player)
        self.addChild(rightButton)
        self.addChild(leftButton)
        //self.addChild(punchButton)
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
            
//            if punchButton.containsPoint(location) {
//                if player.playerState == .Block {
//                    attack(10, block: true)
//                } else {
//                    attack(20, block: false)
//                }
//                
//                player.playerState = .Punch
//            }
            
        }
    }
    
    func moveLeft() {
        if player.position.x > player.size.width / 2 {
            if player.playerState == .Block {
                player.position.x -= 5
            } else {
                player.position.x -= 10
            }
            
            player.playerState = .Walk
            player.playerDirection = .Left
            player.playerPos.x = player.position.x
            
            let dict: [String: AnyObject] = ["matchID":player.matchID, "playerPosX":player.playerPos.x, "playerPosY":player.playerPos.y, "playerState":player.playerState.rawValue, "playerDirection":player.playerDirection.rawValue]
            
            socket.emit("move", dict)
            
        } else {
            print("not move")
        }
    }
    
    func moveRight() {
        if player.position.x < size.width - player.size.width / 2 {
            if player.playerState == .Block {
                player.position.x -= 5
            } else {
                player.position.x += 10
            }
            
            player.playerState = .Walk
            player.playerDirection = .Right
            player.playerPos.x = player.position.x
            
            let dict: [String: AnyObject] = ["matchID":player.matchID, "playerPosX":player.playerPos.x, "playerPosY":player.playerPos.y, "playerState":player.playerState.rawValue, "playerDirection":player.playerDirection.rawValue]
            
            socket.emit("move", dict)
            
        } else {
            print("not move")
        }
    }
    
    func distance() -> CGFloat {
        var xDist = CGFloat(other_player.position.x - player.position.x)
        var yDist = CGFloat(other_player.position.y - player.position.y)
        
        if player.position.x + player.size.width / 2 < other_player.position.x - other_player.size.width / 2 {
            xDist = CGFloat(other_player.position.x - other_player.size.width / 2) - CGFloat(player.position.x + player.size.width / 2)
        } else if player.position.x - player.size.width / 2 >  other_player.position.x + other_player.size.width / 2 {
            xDist = CGFloat(player.position.x - player.size.width / 2) - CGFloat(other_player.position.x + other_player.size.width / 2)
        } else {
            xDist = 0;
        }
        
        if player.position.y + player.size.height / 2 < other_player.position.y - other_player.size.height / 2 {
            yDist = CGFloat(other_player.position.y - other_player.size.height / 2) - CGFloat(player.position.y + player.size.height / 2)
        } else if player.position.y - player.size.height / 2 > other_player.position.y + other_player.size.width / 2 {
            yDist = (player.position.y - player.size.height / 2) - (other_player.position.y + other_player.size.height / 2)
        } else {
            yDist = 0
        }
        
        // print("x: \(xDist), y: \(yDist)")
        
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
            
            other_player.playerHealth -= randDamage - damageReduction
            socket.emit("health", other_player.playerHealth)
        }
    }
    
//    func didWin() -> Bool {
//        if player.playerHealth <= 0 {
//            return true
//        } else {
//            
//        }
//    }
    
    func setInfo() {
        let dict: [String: AnyObject] = ["playerHealth":player.playerHealth, "playerSizeHeight":player.playerSize.height, "playerSizeWidth":player.playerSize.width, "playerPosX":player.playerPos.x, "playerPosY":player.playerPos.y, "playerLevel":player.playerLevel, "playerXP":player.playerXP, "playerUUID":player.playerUUID, "matchID":player.matchID, "playerState":player.playerState.rawValue, "playerDirection":player.playerDirection.rawValue]
        
        socket.emit("all", dict)
        
        print("emit sent")
    }
    
    func retrieveInfo() {
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        // setInfo()
        counter++
    }
}
