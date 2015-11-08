//
//  Player.swift
//  Conquest
//
//  Created by Zafir Abou-Zamzam on 11/7/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import SpriteKit

enum PlayerState: String {
    case Idle = "idle"
    case Walk = "walk"
    case Block = "block"
    case Kick = "kick"
    case Punch = "punch"
}

enum PlayerDirection: String {
    case Left = "left"
    case Right = "right"
}

class Player: SKSpriteNode {
    
    var playerHealth: Float
    var playerSize: CGSize
    var playerPos: CGPoint
    var playerSprite: SKTexture? = nil
    var playerLevel: Int
    var playerXP: Int
    var playerUUID: String
    var matchID: String
    var playerState: PlayerState = .Idle {
        didSet {
            switch (playerState) {
            case .Idle:
                print("idle")
                playerSprite = SKTexture(imageNamed: "idle.png")
            case .Walk:
                print("walk")
                playerSprite = SKTexture(imageNamed: "walkforward.png")
            case .Block:
                print("block")
                playerSprite = SKTexture(imageNamed: "punchforward.png")
            case .Kick:
                print("kick")
                playerSprite = SKTexture(imageNamed: "walkforward.png")
            case .Punch:
                print("punch")
                playerSprite = SKTexture(imageNamed: "punchforward.png")
            }
        }
    }
    
    var playerDirection: PlayerDirection {
        didSet {
            
        }
    }
    
    init(playerHealth: Float, playerSize: CGSize, playerPos: CGPoint, playerSprite: SKTexture?, playerLevel: Int, playerXP: Int, playerUUID: String, matchID: String, playerState: PlayerState, playerDirection: PlayerDirection) {
        
        self.playerHealth = playerHealth
        self.playerSize = playerSize
        self.playerPos = playerPos
        self.playerSprite = playerSprite
        self.playerLevel = playerLevel
        self.playerXP = playerXP
        self.playerUUID = playerUUID
        self.matchID = matchID
        self.playerState = playerState
        self.playerDirection = playerDirection
        
        
        super.init(texture: playerSprite, color: UIColor.greenColor(), size: playerSize)
        
        self.position = self.playerPos
        
    }
    
    
    func addXP(xp: Int) {
        playerXP += xp
        updateLevel()
    }
    
    func setPlayerState(state: String) {
        if state == "idle" {
            playerSprite = SKTexture(imageNamed: "idle.png")
            playerState = .Idle
        } else if state == "walk" {
            playerSprite = SKTexture(imageNamed: "walkforward.png")
            playerState = .Walk
        } else if state == "block" {
            playerSprite = SKTexture(imageNamed: "idle.png")
            playerState = .Block
        } else if state == "kick" {
            playerSprite = SKTexture(imageNamed: "punchforward.png")
            playerState = .Kick
        } else if state == "punch" {
            playerSprite = SKTexture(imageNamed: "punchforward.png")
            playerState = .Punch
        }
    }
    
    func updateLevel() -> Int {
        playerLevel = Int(playerXP / 1000)
        
        return playerLevel
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
