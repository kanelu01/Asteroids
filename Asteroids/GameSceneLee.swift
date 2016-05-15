//
//  GameSceneLee.swift
//  Asteroids
//
//  Created by Lucas Kane on 5/10/16.
//  Copyright © 2016 Lucas Kane. All rights reserved.
//

import SpriteKit

class GameSceneLee: SKScene {
    var score = 0
    var highscore = 0
    var health = 5
    var gameOver : Bool?
    let maxNumberOfShips = 10
    var currentNumberOfShips : Int?
    var timeBetweenShips : Double?
    var moverSpeed = 5.0
    let moveFactor = 1.1
    var now : NSDate?
    var nextTime : NSDate?
    var gameOverLabel : SKLabelNode?
    var highScoreLabel : SKLabelNode?
    var healthLabel : SKLabelNode?
    var gameImage:UIImage? = nil
    var menuButton = SKSpriteNode()
    let menuButtonTex = SKTexture(imageNamed: "menu")
    var replayButton = SKSpriteNode()
    let replayButtonTex = SKTexture(imageNamed: "replay")
    
    
    
    
    
    
    /*
    Where ships start
    */
    override func didMoveToView(view: SKView) {
        initializeValues()
        
        var highscoreDefault = NSUserDefaults.standardUserDefaults()
        highscore = highscoreDefault.valueForKey("HighScore") as! NSInteger!
        
        self.backgroundColor = SKColor.blackColor()
    }
    
    /*
    Initial stuff
    */
    func initializeValues(){
        self.removeAllChildren()
        
        score = 0
        gameOver = false
        currentNumberOfShips = 0
        timeBetweenShips = 1.0
        moverSpeed = 5.0
        health = 5
        nextTime = NSDate()
        now = NSDate()
        
        healthLabel = SKLabelNode(fontNamed:"System")
        healthLabel?.text = "Health: \(health)"
        healthLabel?.fontSize = 30
        healthLabel?.fontColor = SKColor.blackColor()
        healthLabel?.position = CGPoint(x:CGRectGetMinX(self.frame) + 80, y:(CGRectGetMinY(self.frame) + 100));
        
        self.addChild(healthLabel!)
    }
    
    /*
    Static data in the Refresh frame
    */
    override func update(currentTime: CFTimeInterval) {
        
        healthLabel?.text="Health: \(health)"
        healthLabel?.fontColor = SKColor.redColor()
        
        now = NSDate()
        if (currentNumberOfShips < maxNumberOfShips &&
            now?.timeIntervalSince1970 > nextTime?.timeIntervalSince1970 &&
            health > 0){
                
                nextTime = now?.dateByAddingTimeInterval(NSTimeInterval(timeBetweenShips!))
                let newX = Int(arc4random()%1024)
                let newY = Int(self.frame.height+10)
                let p = CGPoint(x:newX,y:newY)
                let destination =  CGPoint(x:newX, y:0)
                
                createShip(p, destination: destination)
                
                moverSpeed = moverSpeed/moveFactor
                timeBetweenShips = timeBetweenShips!/moveFactor
        }
        checkIfShipsReachTheBottom()
        checkIfGameIsOver()
    }
    
    /*
    Basically the ship factory
    Creates a ship
    Rotates it 90º
    Adds a mover so it go downwards
    Adds the ship to the scene
    */
    func createShip(p:CGPoint, destination:CGPoint) {
        let sprite = SKSpriteNode(imageNamed: "Lee")
        sprite.name = "Destroyable"
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        sprite.position = p
        
        let duration = NSTimeInterval(moverSpeed)
        let action = SKAction.moveTo(destination, duration: duration)
        sprite.runAction(SKAction.repeatActionForever(action))
        
        /* let rotationAction = SKAction.rotateToAngle(CGFloat(3.142), duration: 0)
        sprite.runAction(SKAction.repeatAction(rotationAction, count: 0))*/
        
        currentNumberOfShips?+=1
        self.addChild(sprite)
    }
    
    /*
    Destroys a "Asteroid"
    removes the child from the scene
    
    Allows a segue to the main menu when the game ends
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            if let theName = self.nodeAtPoint(location).name {
                if theName == "Destroyable" {
                    self.removeChildrenInArray([self.nodeAtPoint(location)])
                    currentNumberOfShips?-=1
                    score+=1
                    
                    if (score > highscore){
                        highscore = score
                        var highscoreDefaultL = NSUserDefaults.standardUserDefaults()
                        highscoreDefaultL.setValue(highscore, forKey: "HighScoreL")
                        highscoreDefaultL.synchronize()
                        
                        if (highscoreDefaultL.valueForKey("HighScoreL") != nil) {
                            let highscoreL = highscoreDefaultL.valueForKey("HighscoreL")
                            highScoreLabel?.text = "HighScoreL: \(highscoreL)"
                        }
                        
                    }
                    
                    
                    
                }
            }
            /* return to menu */
            if (gameOver==true){
                let pos = touch.locationInNode(self)
                let node = self.nodeAtPoint(pos)
                
                if node == menuButton {
                    if let scene = MenuScene(fileNamed:"MenuScene") {
                        scene.scaleMode = SKSceneScaleMode.AspectFill
                        view!.presentScene(scene)
                    }
                }
                /* reset game on the replay button */
                if (gameOver==true){
                    let pos = touch.locationInNode(self)
                    let node = self.nodeAtPoint(pos)
                    
                    if node == replayButton {
                        initializeValues()
                    }
                    
                }
                
            }
            
        }
    }
    
    /*
    Check if the game is over by looking at our health
    Shows game over screen if needed
    */
    func checkIfGameIsOver(){
        if (health <= 0 && gameOver == false){
            self.removeAllChildren()
            showGameOverScreen()
            gameOver = true
        }
    }
    
    /*
    Checks if an enemy ship reaches the bottom of our screen
    */
    func checkIfShipsReachTheBottom(){
        for child in self.children {
            if(child.position.y == 0){
                self.removeChildrenInArray([child])
                currentNumberOfShips?-=1
                health -= 1
            }
        }
    }
    
    /*
    Displays the actual game over screen
    */
    func showGameOverScreen(){
        
        gameOverLabel = SKLabelNode(fontNamed:"System")
        gameOverLabel?.text = "Game Over! Score: \(score)"
        gameOverLabel?.fontColor = SKColor.redColor()
        gameOverLabel?.fontSize = 50;
        gameOverLabel?.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 100);
        
        
        highScoreLabel = SKLabelNode(fontNamed:"System")
        highScoreLabel?.text = "HighScore: \(highscore)"
        highScoreLabel?.fontColor = SKColor.redColor()
        highScoreLabel?.fontSize = 50;
        highScoreLabel?.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 50);
        
        menuButton = SKSpriteNode(texture: menuButtonTex)
        menuButton.position = CGPointMake(frame.midX, frame.midY + 25)
        
        replayButton = SKSpriteNode(texture: replayButtonTex)
        replayButton.position = CGPointMake(frame.midX, frame.midY - 150)
        
        self.addChild(menuButton)
        self.addChild(gameOverLabel!)
        self.addChild(replayButton)
        self.addChild(highScoreLabel!)
    }
    
    
    
    
    
}
