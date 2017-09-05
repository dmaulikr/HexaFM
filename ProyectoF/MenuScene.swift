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
    var Score = UserDefaults.standard
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
    var Score2 = UserDefaults.standard
    var highscore2 = Int()
    var HighscoreLabel2 = UILabel()
    var aleatorio: UInt32 = 1;
    var revisar: UInt32 = 1;
    var hexa: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        self.scene?.size = CGSize(width: 320, height: 568)
       // SKSceneScaleMode.AspectFill
        

        scene?.backgroundColor = UIColor.white
        Mode1()
        Mode2()
        
        if (Score.value(forKey: "Highscore") != nil){
            highscore = Score.value(forKey: "Highscore") as! NSInteger!
            HighscoreLabel.text = "Highscore:  \(highscore)"
            
        }
        if (Score2.value(forKey: "Highscore2") != nil){
            highscore2 = Score2.value(forKey: "Highscore2") as! NSInteger!
            HighscoreLabel2.text = "Highscore:  \(highscore2)"
            
        }


        
        HighscoreLabel = UILabel(frame: CGRect(x: 110, y: 330  , width: 125, height: 20))
        //  330
        HighscoreLabel.textColor = UIColor.black
        self.view?.addSubview(HighscoreLabel)
        
        HighscoreLabel.text = "Highscore:  \(highscore)"
        
        HighscoreLabel2 = UILabel(frame: CGRect(x: 110, y: 310+120 , width: 125, height: 20))
        HighscoreLabel2.textColor = UIColor.black
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        
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
            let color = SKAction.colorize(with: UIColor.green, colorBlendFactor: 1, duration: 0.01)
            ball.run(color)

            break
        case 1:
            let color = SKAction.colorize(with: UIColor.blue, colorBlendFactor: 1, duration: 0.01)
            ball.run(color)
            ball.physicsBody?.categoryBitMask = Physics1.ballA
            break
            
        case 2:
            let color = SKAction.colorize(with: UIColor.brown, colorBlendFactor: 1, duration: 0.01)
            ball.run(color)
            ball.physicsBody?.categoryBitMask = Physics1.ballC
            break
            
        case 3:
            let color = SKAction.colorize(with: UIColor.lightGray, colorBlendFactor: 1, duration: 0.01)
            ball.run(color)
            ball.physicsBody?.categoryBitMask = Physics1.ballG
            break
            
        case 4:
            let color = SKAction.colorize(with: UIColor.red, colorBlendFactor: 1, duration: 0.01)
            ball.run(color)
            ball.physicsBody?.categoryBitMask = Physics1.ballR
            break
            
        case 5:
            let color = SKAction.colorize(with: UIColor.orange, colorBlendFactor: 1, duration: 0.01)
            ball.run(color)
            ball.physicsBody?.categoryBitMask = Physics1.ballO
            break
        default: NSLog("mal")
        }
    }
    
    func Mode1(){
       
        mode1 = SKSpriteNode(imageNamed: "mode1")
        mode1.position = CGPoint(x: self.frame.width / 2 , y: self.frame.height / 2 - 100)
        mode1.size = CGSize(width: 217.7, height: 62.3)
        mode1.name = "mode1"
        self.addChild(mode1)

    }
    
    func Mode2(){
        
        mode2 = SKSpriteNode(imageNamed: "mode2")
        mode2.position = CGPoint(x: self.frame.width / 2 , y: self.frame.height / 2 - 200)
        mode2.size = CGSize(width: 217.7, height: 62.3)
        mode2.name = "mode2"
        self.addChild(mode2)
    }
    
    func launchMode1(){
        Utilities.sharedInstance.deleteSubViews(view: self.view!)
        Utilities.sharedInstance.deleteChildren(node: self)
        self.scene!.view?.presentScene(GameScene(fileNamed: "GameScene")!, transition: SKTransition.fade(withDuration: 0.1))
    }
    
    func launchMode2(){
        Utilities.sharedInstance.deleteSubViews(view: self.view!)
        Utilities.sharedInstance.deleteChildren(node: self)
        self.scene!.view?.presentScene(CrazyScene(fileNamed: "CrazyScene")!, transition: SKTransition.fade(withDuration: 0.1))
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
        let color = SKAction.colorize(with: UIColor.blue, colorBlendFactor: 1, duration: 0.01)
        self.addChild(ball)
        ball.run(color)
        
    }
    
    func BaseA(){
        baseA = SKSpriteNode(imageNamed: "base")
        baseA.position = CGPoint(x: self.frame.width / 2 + 1.5, y: self.frame.height / 2 + 50)
        baseA.physicsBody = SKPhysicsBody(rectangleOf: baseA.size)
        baseA.physicsBody?.affectedByGravity = false
        baseA.physicsBody?.isDynamic = false
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
        baseG.physicsBody = SKPhysicsBody(rectangleOf: baseG.size)
        baseG.physicsBody?.affectedByGravity = false
        baseG.physicsBody?.isDynamic = false
        baseG.physicsBody?.categoryBitMask = Physics1.baseG
        baseG.physicsBody?.contactTestBitMask = Physics1.ballA
        baseG.physicsBody?.contactTestBitMask = Physics1.ballG
        baseG.physicsBody?.contactTestBitMask = Physics1.ballC
        baseG.physicsBody?.contactTestBitMask = Physics1.ballR
        baseG.physicsBody?.contactTestBitMask = Physics1.ballY
        baseG.physicsBody?.contactTestBitMask = Physics1.ballO
        let rotate = SKAction.rotate(byAngle: 1.047197551, duration: 0.01)
        baseG.run(rotate)
        baseG.size = CGSize(width: 119, height: 14)
        self.addChild(baseG)
    }
    func BaseC(){
        baseC = SKSpriteNode(imageNamed: "baseC")
        baseC.position = CGPoint(x: self.frame.width / 2 + 85, y: self.frame.height / 2 + 196)
        baseC.physicsBody = SKPhysicsBody(rectangleOf: baseC.size)
        baseC.physicsBody?.affectedByGravity = false
        baseC.physicsBody?.isDynamic = false
        baseC.physicsBody?.categoryBitMask = Physics1.baseC
        baseC.physicsBody?.contactTestBitMask = Physics1.ballA
        baseC.physicsBody?.contactTestBitMask = Physics1.ballG
        baseC.physicsBody?.contactTestBitMask = Physics1.ballC
        baseC.physicsBody?.contactTestBitMask = Physics1.ballR
        baseC.physicsBody?.contactTestBitMask = Physics1.ballY
        baseC.physicsBody?.contactTestBitMask = Physics1.ballO
        let rotate = SKAction.rotate(byAngle: 2.094395102, duration: 0.01)
        baseC.run(rotate)
        baseC.size = CGSize(width: 119, height: 14)
        
        self.addChild(baseC)
    }
    func BaseR(){
        baseR = SKSpriteNode(imageNamed: "baseR")
        baseR.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + 245)
        baseR.physicsBody = SKPhysicsBody(rectangleOf: baseR.size)
        baseR.physicsBody?.affectedByGravity = false
        baseR.physicsBody?.isDynamic = false
        baseR.physicsBody?.categoryBitMask = Physics1.baseR
        baseR.physicsBody?.contactTestBitMask = Physics1.ballA
        baseR.physicsBody?.contactTestBitMask = Physics1.ballG
        baseR.physicsBody?.contactTestBitMask = Physics1.ballC
        baseR.physicsBody?.contactTestBitMask = Physics1.ballR
        baseR.physicsBody?.contactTestBitMask = Physics1.ballY
        baseR.physicsBody?.contactTestBitMask = Physics1.ballO
        baseR.size = CGSize(width: 119, height: 14)
        let rotate = SKAction.rotate(byAngle: 3.1415926254, duration: 0.01)
        baseR.run(rotate)
        self.addChild(baseR)
    }
    func BaseY(){
        baseY = SKSpriteNode(imageNamed: "baseA")
        baseY.position = CGPoint(x: self.frame.width / 2 - 85, y: self.frame.height / 2 + 196)
        baseY.physicsBody = SKPhysicsBody(rectangleOf: baseY.size)
        baseY.physicsBody?.affectedByGravity = false
        baseY.physicsBody?.isDynamic = false
        baseY.physicsBody?.categoryBitMask = Physics1.baseY
        baseY.physicsBody?.contactTestBitMask = Physics1.ballA
        baseY.physicsBody?.contactTestBitMask = Physics1.ballG
        baseY.physicsBody?.contactTestBitMask = Physics1.ballC
        baseY.physicsBody?.contactTestBitMask = Physics1.ballR
        baseY.physicsBody?.contactTestBitMask = Physics1.ballY
        baseY.physicsBody?.contactTestBitMask = Physics1.ballO
        let rotate = SKAction.rotate(byAngle: 4.188790205, duration: 0.01)
        let color = SKAction.colorize(with: UIColor.green, colorBlendFactor: 1, duration: 0.01)
        baseY.run(rotate)
        baseY.run(color)
        baseY.size = CGSize(width: 119, height: 14)
        
        self.addChild(baseY)
    }
    func BaseO(){
        baseO = SKSpriteNode(imageNamed: "baseN")
        baseO.position = CGPoint(x: self.frame.width / 2 - 85, y: self.frame.height / 2 + 98)
        baseO.physicsBody = SKPhysicsBody(rectangleOf: baseO.size)
        baseO.physicsBody?.affectedByGravity = false
        baseO.physicsBody?.isDynamic = false
        baseO.physicsBody?.categoryBitMask = Physics1.baseO
        baseO.physicsBody?.contactTestBitMask = Physics1.ballA
        baseO.physicsBody?.contactTestBitMask = Physics1.ballG
        baseO.physicsBody?.contactTestBitMask = Physics1.ballC
        baseO.physicsBody?.contactTestBitMask = Physics1.ballR
        baseO.physicsBody?.contactTestBitMask = Physics1.ballY
        baseO.physicsBody?.contactTestBitMask = Physics1.ballO
        let rotate = SKAction.rotate(byAngle: 5.235987756, duration: 0.01)
        baseO.run(rotate)
        baseO.size = CGSize(width: 119, height: 14)
        
        self.addChild(baseO)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.nodes(at: positionInScene)
        
        if let name = touchedNode.first?.name
        {
            if name == "mode1"
            {
                launchMode1()
            }
            else if name == "mode2"{
                launchMode2()
            }
        }
    }


}
