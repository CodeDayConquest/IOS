//
//  Player.swift
//  Conquest
//
//  Created by Zafir Abou-Zamzam on 11/7/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode
{
    
    var playerHealth: Float
    var playerSize: CGSize
    var playerPos: CGPoint
    var playerImage: SKTexture?

    init(health: Float, size: CGSize, pos: CGPoint, playerImage: SKTexture?)
    {
        
        self.playerHealth = health
        self.playerSize = size
        self.playerPos = pos
        self.playerImage = playerImage
        
        
        super.init(texture: playerImage, color: UIColor.greenColor(), size: size)

        self.position = self.playerPos

        

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
