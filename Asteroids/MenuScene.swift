//
//  MenuScene.swift
//  Asteroids
//
//  Created by Lucas Kane on 4/26/16.
//  Copyright © 2016 Lucas Kane. All rights reserved.
//

import UIKit

import SpriteKit

class MenuScene: SKScene {
    
    var gameLabel : SKLabelNode?
    var playButton = SKSpriteNode()
    var playButtonMiller = SKSpriteNode()
    var playButtonLee = SKSpriteNode()

    
    let playButtonTex = SKTexture(imageNamed: "play")
    let playButtonMillerTex = SKTexture(imageNamed: "Brad")
    let playButtonLeeTex = SKTexture(imageNamed: "Lee")
    
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = SKColor.blackColor()
        
        playButton = SKSpriteNode(texture: playButtonTex)
        playButton.position = CGPointMake(frame.midX, frame.midY - 50)
        
        playButtonMiller = SKSpriteNode(texture: playButtonMillerTex)
        playButtonMiller.position = CGPointMake(frame.midX + 50, frame.midY - 200)
        playButtonMiller.size = CGSize(width: 100, height: 100)

        playButtonLee = SKSpriteNode(texture: playButtonLeeTex)
        playButtonLee.position = CGPointMake(frame.midX - 50, frame.midY - 200)
        playButtonLee.size = CGSize(width: 100, height: 100)
        
        gameLabel = SKLabelNode(fontNamed:"System")
        gameLabel?.text = "Asteroids!"
        gameLabel?.fontColor = SKColor.whiteColor()
        gameLabel?.fontSize = 65;
        gameLabel?.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 75);
        
        self.addChild(playButton)
        self.addChild(gameLabel!)
        self.addChild(playButtonMiller)
        self.addChild(playButtonLee)
    
    }
        
     override  func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            
            
            if let touch = touches.first as UITouch! {
                let pos = touch.locationInNode(self)
                let node = self.nodeAtPoint(pos)
                
                if node == playButton {
                        if let scene = GameScene(fileNamed:"GameScene") {
                            scene.scaleMode = SKSceneScaleMode.AspectFill
                            view!.presentScene(scene)
                        }
                }
        }
        
        
        if let touch = touches.first as UITouch! {
            let pos = touch.locationInNode(self)
            let node = self.nodeAtPoint(pos)
            
                if node == playButtonMiller {
                    if let scene = GameSceneMiller(fileNamed:"GameSceneMiller") {
                        scene.scaleMode = SKSceneScaleMode.AspectFill
                        view!.presentScene(scene)
                    }
                }
        }
        
        
        if let touch = touches.first as UITouch! {
            let pos = touch.locationInNode(self)
            let node = self.nodeAtPoint(pos)
            
            if node == playButtonLee {
                if let scene = GameSceneLee(fileNamed:"GameSceneLee") {
                    scene.scaleMode = SKSceneScaleMode.AspectFill
                    view!.presentScene(scene)
                }
            }
        }

        
        
        
        }
    }





