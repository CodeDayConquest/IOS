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
    var playerSprite: SKTexture?
    var playerLevel: Int
    var playerXP: Int
    var playerUUID: UInt64
    var matchID: UInt64
    var playerState: PlayerState = .Idle {
        didSet {
            switch (playerState) {
            case .Idle:
                print("idle")
            case .Walk:
                print("walk")
            case .Block:
                print("block")
            case .Kick:
                print("kick")
            case .Punch:
                print("punch")
            }
        }
    }
    
    var playerDirection: PlayerDirection {
        didSet {
            
        }
    }
    
    init(playerHealth: Float, playerSize: CGSize, playerPos: CGPoint, playerSprite: SKTexture?, playerLevel: Int, playerXP: Int, playerUUID: UInt64,matchID: UInt64, playerState: PlayerState, playerDirection: PlayerDirection) {
        
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
    
    func updateLevel() -> Int {
        playerLevel = Int(playerXP / 1000)
        return playerLevel
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
