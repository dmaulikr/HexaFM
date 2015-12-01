//
//  MenuScene.swift
//  ProyectoF
//
//  Created by Jose Andres Salazar on 11/29/15.
//  Copyright © 2015 Jose Andres Salazar. All rights reserved.
//

import Foundation
import SpriteKit

struct Physics1{
    
    static let ballA: UInt32 = 1;
    static let ballG: UInt32 = 7;
    static let ballR: UInt32 = 3;
    static let ballY: UInt32 = 4;
    static let ballO: UInt32 = 5;
    static let ballC: UInt32 = 6;
    static let baseA: UInt32 = 1;
    static let baseG: UInt32 = 7;
    static let baseR: UInt32 = 3;
    static let baseY: UInt32 = 4;
    static let baseO: UInt32 = 5;
    static let baseC: UInt32 = 6;
    
}


class MenuScene : SKScene, SKPhysicsContactDelegate {
    
    var RestartBtn : UIButton!
    var RestartBtn2: UIButton!
    var HighscoreLabel = UILabel()
    var Score = NSUserDefaults.standardUserDefaults()
    var highscore = Int()
    var mode1: SKSpriteNode!
    var button1: UIButton!
    var mode2: SKSpriteNode!
    var baseA: SKSpriteNode!
    var baseG: SKSpriteNode!
    var baseR: SKSpriteNode!
    var baseY: SKSpriteNode!
    var baseO: SKSpriteNode!
    var baseC: SKSpriteNode!
    var ball: SKSpriteNode!
    var Score2 = NSUserDefaults.standardUserDefaults()
    var highscore2 = Int()
    var HighscoreLabel2 = UILabel()
    var aleatorio: UInt32 = 1;
    var revisar: UInt32 = 1;
    var hexa: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        
        self.scene?.size = CGSize(width: 320, height: 568)
        

        scene?.backgroundColor = UIColor.whiteColor()
        Mode1()
        Mode2()
        
        if (Score.valueForKey("Highscore") != nil){
            highscore = Score.valueForKey("Highscore") as! NSInteger!
            HighscoreLabel.text = "Highscore:  \(highscore)"
            
        }
        if (Score2.valueForKey("Highscore2") != nil){
            highscore2 = Score2.valueForKey("Highscore2") as! NSInteger!
            HighscoreLabel2.text = "Highscore:  \(highscore2)"
            
        }


        
        HighscoreLabel = UILabel(frame: CGRect(x: 110, y: 330 , width: 125, height: 20))
        HighscoreLabel.textColor = UIColor.blackColor()
        self.view?.addSubview(HighscoreLabel)
        
        HighscoreLabel.text = "Highscore:  \(highscore)"
        
        HighscoreLabel2 = UILabel(frame: CGRect(x: 110, y: 434 , width: 125, height: 20))
        HighscoreLabel2.textColor = UIColor.blackColor()
        self.view?.addSubview(HighscoreLabel2)
        
        HighscoreLabel2.text = "Highscore:  \(highscore2)"
        BaseA()
        BaseR()
        BaseG()
        BaseY()
        BaseO()
        BaseC()
        BallA()
        Hexa()
        

        physicsWorld.contactDelegate = self
    }
    
    
    func Hexa(){
        hexa = SKSpriteNode(imageNamed: "hexa")
        hexa.position = CGPoint(x: self.frame.width / 2 , y: self.frame.height / 2 )
        hexa.size = CGSize(width: 210, height: 55)
        self.addChild(hexa)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
            RandomColor()
    }
    
    func RandomColor()
    {
        
        repeat{
            aleatorio = arc4random_uniform(6)
        }while(aleatorio == revisar)
        
        revisar = aleatorio
        
        switch (aleatorio) {
        case 0:
            let color = SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 1, duration: 0.01)
            ball.runAction(color)

            break
        case 1:
            let color = SKAction.colorizeWithColor(UIColor.blueColor(), colorBlendFactor: 1, duration: 0.01)
            ball.runAction(color)
            ball.physicsBody?.categoryBitMask = Physics1.ballA
            break
            
        case 2:
            let color = SKAction.colorizeWithColor(UIColor.brownColor(), colorBlendFactor: 1, duration: 0.01)
            ball.runAction(color)
            ball.physicsBody?.categoryBitMask = Physics1.ballC
            break
            
        case 3:
            let color = SKAction.colorizeWithColor(UIColor.lightGrayColor(), colorBlendFactor: 1, duration: 0.01)
            ball.runAction(color)
            ball.physicsBody?.categoryBitMask = Physics1.ballG
            break
            
        case 4:
            let color = SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: 1, duration: 0.01)
            ball.runAction(color)
            ball.physicsBody?.categoryBitMask = Physics1.ballR
            break
            
        case 5:
            let color = SKAction.colorizeWithColor(UIColor.orangeColor(), colorBlendFactor: 1, duration: 0.01)
            ball.runAction(color)
            ball.physicsBody?.categoryBitMask = Physics1.ballO
            break
        default: NSLog("mal")
        }
    }
    
    func Mode1(){
       
        mode1 = SKSpriteNode(imageNamed: "mode1")
        mode1.position = CGPoint(x: self.frame.width / 2 , y: self.frame.height / 2 - 100)
        mode1.size = CGSize(width: 217.7, height: 62.3)
        
        RestartBtn = UIButton(frame: CGRect(x: self.frame.width / 2, y: self.frame.height / 2 + 100, width: 170, height: 50))
        RestartBtn.center = CGPoint(x: view!.frame.size.width / 2, y: self.frame.height / 2 + 100)
        RestartBtn.setTitle("", forState: UIControlState.Normal)
        RestartBtn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        RestartBtn.addTarget(self, action: Selector("Restart"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(RestartBtn)
        self.addChild(mode1)

    }
    
    func Mode2(){
        
        mode2 = SKSpriteNode(imageNamed: "mode2")
        mode2.position = CGPoint(x: self.frame.width / 2 , y: self.frame.height / 2 - 200)
        mode2.size = CGSize(width: 217.7, height: 62.3)
        self.addChild(mode2)
        RestartBtn2 = UIButton(frame: CGRect(x: self.frame.width / 2, y: self.frame.height / 2 + 200, width: 170, height: 50))
        RestartBtn2.center = CGPoint(x: view!.frame.size.width / 2, y: self.frame.height / 2 + 200)
        RestartBtn2.setTitle("", forState: UIControlState.Normal)
        RestartBtn2.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        RestartBtn2.addTarget(self, action: Selector("Restart2"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(RestartBtn2)
    }
    
    func Restart(){
        HighscoreLabel.removeFromSuperview()
        HighscoreLabel2.removeFromSuperview()
        self.scene!.view?.presentScene(GameScene(fileNamed: "GameScene")!, transition: SKTransition.fadeWithDuration(0.1))
        ball.removeFromParent()
        baseA.removeFromParent()
        baseO.removeFromParent()
        baseR.removeFromParent()
        baseG.removeFromParent()
        baseY.removeFromParent()
        baseC.removeFromParent()
        RestartBtn.removeFromSuperview()
        RestartBtn2.removeFromSuperview()

    }
    
    func Restart2(){
        HighscoreLabel.removeFromSuperview()
        HighscoreLabel2.removeFromSuperview()
        self.scene!.view?.presentScene(CrazyScene(fileNamed: "CrazyScene")!, transition: SKTransition.fadeWithDuration(0.1))
        ball.removeFromParent()
        baseA.removeFromParent()
        baseO.removeFromParent()
        baseR.removeFromParent()
        baseG.removeFromParent()
        baseY.removeFromParent()
        baseC.removeFromParent()
        RestartBtn.removeFromSuperview()
        RestartBtn2.removeFromSuperview()
    }
    
    func BallA(){
        ball = SKSpriteNode(imageNamed: "ball")
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.restitution = 0.99
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.categoryBitMask = Physics1.ballA
        ball.physicsBody?.contactTestBitMask = Physics1.baseA
        ball.physicsBody?.contactTestBitMask = Physics1.baseG
        ball.physicsBody?.contactTestBitMask = Physics1.baseC
        ball.physicsBody?.contactTestBitMask = Physics1.baseR
        ball.physicsBody?.contactTestBitMask = Physics1.baseY
        ball.physicsBody?.contactTestBitMask = Physics1.baseO
        ball.position = CGPoint(x:self.frame.width / 2, y: self.frame.height / 2 + 120)
        ball.size = CGSize(width: 15, height: 15)
        let color = SKAction.colorizeWithColor(UIColor.blueColor(), colorBlendFactor: 1, duration: 0.01)
        self.addChild(ball)
        ball.runAction(color)
        
    }
    
    func BaseA(){
        baseA = SKSpriteNode(imageNamed: "base")
        baseA.position = CGPoint(x: self.frame.width / 2 + 1.5, y: self.frame.height / 2 + 50)
        baseA.physicsBody = SKPhysicsBody(rectangleOfSize: baseA.size)
        baseA.physicsBody?.affectedByGravity = false
        baseA.physicsBody?.dynamic = false
        baseA.physicsBody?.categoryBitMask = Physics1.baseA
        baseA.physicsBody?.contactTestBitMask = Physics1.ballA
        baseA.physicsBody?.contactTestBitMask = Physics1.ballG
        baseA.physicsBody?.contactTestBitMask = Physics1.ballC
        baseA.physicsBody?.contactTestBitMask = Physics1.ballR
        baseA.physicsBody?.contactTestBitMask = Physics1.ballY
        baseA.physicsBody?.contactTestBitMask = Physics1.ballO
        baseA.size = CGSize(width: 123, height: 14)
        self.addChild(baseA)
    }
    func BaseG(){
        baseG = SKSpriteNode(imageNamed: "baseG")
        baseG.position = CGPoint(x: self.frame.width / 2 + 85, y: self.frame.height / 2 + 98)
        baseG.physicsBody = SKPhysicsBody(rectangleOfSize: baseG.size)
        baseG.physicsBody?.affectedByGravity = false
        baseG.physicsBody?.dynamic = false
        baseG.physicsBody?.categoryBitMask = Physics1.baseG
        baseG.physicsBody?.contactTestBitMask = Physics1.ballA
        baseG.physicsBody?.contactTestBitMask = Physics1.ballG
        baseG.physicsBody?.contactTestBitMask = Physics1.ballC
        baseG.physicsBody?.contactTestBitMask = Physics1.ballR
        baseG.physicsBody?.contactTestBitMask = Physics1.ballY
        baseG.physicsBody?.contactTestBitMask = Physics1.ballO
        let rotate = SKAction.rotateByAngle(1.047197551, duration: 0.01)
        baseG.runAction(rotate)
        baseG.size = CGSize(width: 119, height: 14)
        self.addChild(baseG)
    }
    func BaseC(){
        baseC = SKSpriteNode(imageNamed: "baseC")
        baseC.position = CGPoint(x: self.frame.width / 2 + 85, y: self.frame.height / 2 + 196)
        baseC.physicsBody = SKPhysicsBody(rectangleOfSize: baseC.size)
        baseC.physicsBody?.affectedByGravity = false
        baseC.physicsBody?.dynamic = false
        baseC.physicsBody?.categoryBitMask = Physics1.baseC
        baseC.physicsBody?.contactTestBitMask = Physics1.ballA
        baseC.physicsBody?.contactTestBitMask = Physics1.ballG
        baseC.physicsBody?.contactTestBitMask = Physics1.ballC
        baseC.physicsBody?.contactTestBitMask = Physics1.ballR
        baseC.physicsBody?.contactTestBitMask = Physics1.ballY
        baseC.physicsBody?.contactTestBitMask = Physics1.ballO
        let rotate = SKAction.rotateByAngle(2.094395102, duration: 0.01)
        baseC.runAction(rotate)
        baseC.size = CGSize(width: 119, height: 14)
        
        self.addChild(baseC)
    }
    func BaseR(){
        baseR = SKSpriteNode(imageNamed: "baseR")
        baseR.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + 245)
        baseR.physicsBody = SKPhysicsBody(rectangleOfSize: baseR.size)
        baseR.physicsBody?.affectedByGravity = false
        baseR.physicsBody?.dynamic = false
        baseR.physicsBody?.categoryBitMask = Physics1.baseR
        baseR.physicsBody?.contactTestBitMask = Physics1.ballA
        baseR.physicsBody?.contactTestBitMask = Physics1.ballG
        baseR.physicsBody?.contactTestBitMask = Physics1.ballC
        baseR.physicsBody?.contactTestBitMask = Physics1.ballR
        baseR.physicsBody?.contactTestBitMask = Physics1.ballY
        baseR.physicsBody?.contactTestBitMask = Physics1.ballO
        baseR.size = CGSize(width: 119, height: 14)
        let rotate = SKAction.rotateByAngle(3.1415926254, duration: 0.01)
        baseR.runAction(rotate)
        self.addChild(baseR)
    }
    func BaseY(){
        baseY = SKSpriteNode(imageNamed: "baseA")
        baseY.position = CGPoint(x: self.frame.width / 2 - 85, y: self.frame.height / 2 + 196)
        baseY.physicsBody = SKPhysicsBody(rectangleOfSize: baseY.size)
        baseY.physicsBody?.affectedByGravity = false
        baseY.physicsBody?.dynamic = false
        baseY.physicsBody?.categoryBitMask = Physics1.baseY
        baseY.physicsBody?.contactTestBitMask = Physics1.ballA
        baseY.physicsBody?.contactTestBitMask = Physics1.ballG
        baseY.physicsBody?.contactTestBitMask = Physics1.ballC
        baseY.physicsBody?.contactTestBitMask = Physics1.ballR
        baseY.physicsBody?.contactTestBitMask = Physics1.ballY
        baseY.physicsBody?.contactTestBitMask = Physics1.ballO
        let rotate = SKAction.rotateByAngle(4.188790205, duration: 0.01)
        let color = SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 1, duration: 0.01)
        baseY.runAction(rotate)
        baseY.runAction(color)
        baseY.size = CGSize(width: 119, height: 14)
        
        self.addChild(baseY)
    }
    func BaseO(){
        baseO = SKSpriteNode(imageNamed: "baseN")
        baseO.position = CGPoint(x: self.frame.width / 2 - 85, y: self.frame.height / 2 + 98)
        baseO.physicsBody = SKPhysicsBody(rectangleOfSize: baseO.size)
        baseO.physicsBody?.affectedByGravity = false
        baseO.physicsBody?.dynamic = false
        baseO.physicsBody?.categoryBitMask = Physics1.baseO
        baseO.physicsBody?.contactTestBitMask = Physics1.ballA
        baseO.physicsBody?.contactTestBitMask = Physics1.ballG
        baseO.physicsBody?.contactTestBitMask = Physics1.ballC
        baseO.physicsBody?.contactTestBitMask = Physics1.ballR
        baseO.physicsBody?.contactTestBitMask = Physics1.ballY
        baseO.physicsBody?.contactTestBitMask = Physics1.ballO
        let rotate = SKAction.rotateByAngle(5.235987756, duration: 0.01)
        baseO.runAction(rotate)
        baseO.size = CGSize(width: 119, height: 14)
        
        self.addChild(baseO)
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        let touch : UITouch! = touches.first
        let location = touch.locationInView(self.view)
        
        //let x = location.x

        
    }
}