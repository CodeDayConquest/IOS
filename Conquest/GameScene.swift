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
    
    var loadingScreen: SKSpriteNode! = nil
    var loadingLabel: SKLabelNode! = nil
    
    
    var hasStarted: Bool = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        // Add Player to Screen
        // Add Buttons to Screen
        
        waitForGame()
        
        loadingScreen = SKSpriteNode(color: UIColor(red: 213 / 255.0, green: 62 / 255.0, blue: 75 / 255.0, alpha: 1.0), size: CGSize(width: size.width, height: size.height))
        loadingScreen.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        loadingLabel = SKLabelNode(fontNamed: "System")
        loadingLabel.text = "Loading"
        loadingLabel.fontColor = UIColor.whiteColor()
        loadingLabel.fontSize = 100
        loadingLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));

        
        let platform = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: size.width, height: 10))
        platform.position = CGPoint(x: size.width / 2, y: size.height / 3 - platform.size.height)
        
        /// Left Button
        leftButton = SKSpriteNode(color: UIColor.purpleColor(), size: CGSize(width: size.width / 7, height: size.width / 7))
        leftButton.position = CGPoint(x: leftButton.size.width / 10 + leftButton.size.width / 2, y: leftButton.size.height / 10 + leftButton.size.width / 2)
        
        /// Right Button
        rightButton = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: size.width / 7, height: size.width / 7))
        rightButton.position = CGPoint(x: leftButton.size.width + leftButton.size.width / 10 + rightButton.size.width / 2, y: rightButton.size.height / 10 + rightButton.size.height / 2)
        
        
        /// Jump Button
        
        /// Punch Button
        punchButton = SKSpriteNode(color: UIColor.cyanColor(), size: CGSize(width: size.width / 7, height: size.width / 7))
        punchButton.position = CGPoint(x: size.width - punchButton.size.width / 2 - punchButton.size.width / 10, y: punchButton.size.height / 2 + punchButton.size.width / 10)
        
        /// Kick Button
        kickButton = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: size.width / 7, height: size.width / 7))
        kickButton.position = CGPoint(x: punchButton.position.x - kickButton.size.width, y: punchButton.position.y)
        
        /// Block Button
        blockButton = SKSpriteNode(color: UIColor.grayColor(), size: CGSize(width: size.width / 7, height: size.width / 7))
        blockButton.position = CGPoint(x: punchButton.position.x - kickButton.size.width - blockButton.size.width - blockButton.size.width / 10, y: blockButton.size.height / 2.0 + blockButton.size.width / 10.0)
        
        
        
        // Add objects to Screen

        self.addChild(platform)
        self.addChild(rightButton)
        self.addChild(leftButton)
        self.addChild(kickButton)
        self.addChild(blockButton)
        self.addChild(punchButton)
        self.addChild(loadingScreen)
        self.addChild(loadingLabel)
        
    }
    
    func waitForGame() {
        print("HELLO")
        socket.on("start") { (data: [AnyObject], ack) -> Void in
            if let objects = data[0] as? NSDictionary {
                
                self.initPlayer(objects.valueForKey("side") as! String, matchID: objects.valueForKey("matchId") as! String)
                
                self.hasStarted = true
                self.loadingLabel.hidden = true
                self.loadingScreen.hidden = true
            }
        }
    }
    
    func initPlayer(side: String, matchID: String) {
        if side == "right" {
            self.player = Player(playerHealth: 100, playerSize: CGSize(width: 100, height: 100), playerPos: CGPoint(x: size.width * 0.75, y: size.height / 2.0), playerSprite: nil, playerLevel: 1, playerXP: 100, playerUUID: "", matchID: matchID, playerState: PlayerState.Idle, playerDirection: PlayerDirection.Left)
            
            
            self.other_player = Player(playerHealth: 100, playerSize: CGSize(width: 100, height: 100), playerPos: CGPoint(x: size.width * 0.25, y: size.height / 2.0), playerSprite: nil, playerLevel: 1, playerXP: 100, playerUUID: "", matchID: matchID, playerState: PlayerState.Idle, playerDirection: PlayerDirection.Right)
            
        } else {
            
            self.player = Player(playerHealth: 100, playerSize: CGSize(width: 100, height: 100), playerPos: CGPoint(x: size.width * 0.25, y: size.height / 2.0), playerSprite: nil, playerLevel: 1, playerXP: 100, playerUUID: "", matchID: matchID, playerState: PlayerState.Idle, playerDirection: PlayerDirection.Right)
            
            self.other_player = Player(playerHealth: 100, playerSize: CGSize(width: 100, height: 100), playerPos: CGPoint(x: size.width * 0.75, y: size.height / 2.0), playerSprite: nil, playerLevel: 1, playerXP: 100, playerUUID: "", matchID: matchID, playerState: PlayerState.Idle, playerDirection: PlayerDirection.Left)

            
        }
        
        self.player.color = UIColor.whiteColor()
        self.other_player.color = UIColor.redColor()
        
        self.addChild(player)
        self.addChild(other_player)
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
                    if other_player.playerState == .Block {
                        attack(10, block: true)
                    } else {
                        attack(10, block: false)
                    }
                    
                    player.playerState = .Punch
                }
                
                if kickButton.containsPoint(location) {
                    if other_player.playerState == .Block {
                        attack(20, block: true)
                    } else {
                        attack(20, block: false)
                    }
                    
                    player.playerState = .Kick
                }
                
                if blockButton.containsPoint(location) {
                    player.playerState = .Block
                    socket.emit("blocked", player.playerState.rawValue)
                }
                
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
                
                let dict: [String: AnyObject] = ["id":player.matchID, "playerPosX":player.playerPos.x, "playerPosY":player.playerPos.y, "playerState":player.playerState.rawValue, "playerDirection":player.playerDirection.rawValue]
                
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
                
                let dict: [String: AnyObject] = ["id":player.matchID, "playerPosX":player.playerPos.x, "playerPosY":player.playerPos.y, "playerState":player.playerState.rawValue, "playerDirection":player.playerDirection.rawValue]
                
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
                var randDamage = Float(arc4random_uniform(UInt32(damage) + 1))
                var damageReduction = Float()
                
                if block {
                    damageReduction = Float(arc4random_uniform(UInt32(100) + 1))
                } else {
                    print("No block")
                }
                
                if damageReduction > randDamage {
                    randDamage = 0
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
            // movement, health
            socket.on("move") { (data: [AnyObject], ack) -> Void in
                if let objects = data[0] as? NSDictionary {
                    self.other_player.position.x = objects.valueForKey("x") as! CGFloat
                    self.other_player.position.y = objects.valueForKey("y") as! CGFloat
                    self.other_player.playerPos = CGPoint(x: self.other_player.position.x, y: self.other_player.position.y)
                } else {
                    print("ther was no movement")
                }
            }
        }
        
        override func update(currentTime: CFTimeInterval) {
            // setInfo()
//            if(!hasStarted) {
//                waitForGame()
//            }
            if !loadingLabel.hidden && (counter % 30 == 0)
            {
                if(counter <= 40)
                {
                    self.loadingLabel.text = "Loading."
                }
                else if(counter <= 60)
                {
                    self.loadingLabel.text = "Loading.."
                }
                else if(counter <= 80)
                {
                    self.loadingLabel.text = "Loading..."
                }
                else
                {
                    self.loadingLabel.text = "Loading"
                    counter = 0
                }
                
            }
            
            
            retrieveInfo()
            
            counter++
        }
}
