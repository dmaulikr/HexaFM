//
//  GameScene.swift
//  ProyectoF
//
//  Created by Jose Andres Salazar on 11/17/15.
//  Copyright (c) 2015 Jose Andres Salazar. All rights reserved.
//

import SpriteKit

struct Physics{
    
    static var modo = 1
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


class GameScene: SKScene, SKPhysicsContactDelegate {
    var ball: SKSpriteNode!

    var baseA: SKSpriteNode!
    var baseG: SKSpriteNode!
    var baseR: SKSpriteNode!
    var baseY: SKSpriteNode!
    var baseO: SKSpriteNode!
    var baseC: SKSpriteNode!
    
    var contador = 0
    var balll = 1

    
    var Path = UIBezierPath()
    var Path2 = UIBezierPath()
    var Path3 = UIBezierPath()
    var Path4 = UIBezierPath()
    var Path5 = UIBezierPath()
    var Path6 = UIBezierPath()
    var aleatorio: UInt32 = 1;
    var revisar: UInt32 = 1;

    
    var Score = Int()
    var ScoreLabel = UILabel()
    
    var HighscoreDefault = NSUserDefaults.standardUserDefaults()
    var Highscore = Int()
    var HighscoreLabel = UILabel()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let backgroundMusic = SKAudioNode(fileNamed: "music.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        physicsWorld.contactDelegate = self
        
        
        
        if (HighscoreDefault.valueForKey("Highscore") != nil){
            Highscore = HighscoreDefault.valueForKey("Highscore") as! NSInteger!
            HighscoreLabel.text = "Highscore:  \(Highscore)"
            
        }
        
        BaseA()
        BaseR()
        BaseG()
        BaseY()
        BaseO()
        BaseC()
        BallA()
        
        
        ScoreLabel.text = " \(Score)"
        ScoreLabel = UILabel(frame: CGRect(x: 120, y: 90, width: 125, height: 20))
        ScoreLabel.textColor = UIColor.blackColor()
        self.view?.addSubview(ScoreLabel)
        
        
        self.physicsWorld.gravity = CGVectorMake(0, -4)
        
        //self.scene?.backgroundColor = UIColor.darkGrayColor()
        let sceneBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        sceneBody.friction = 0
        self.physicsBody = sceneBody
        backgroundColor = SKColor.whiteColor()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let FirstBody: SKPhysicsBody = contact.bodyA
        let SecondBody: SKPhysicsBody = contact.bodyB
        
        if (FirstBody.categoryBitMask == SecondBody.categoryBitMask)
        {
            RandomColor()
            Score += 1
            ScoreLabel.text = "Score:  \(Score)"
            HighscoreLabel.text = NSString(format: "Highscore:  %i", Highscore) as String
            
            if (Score > Highscore)
            {
                Highscore = Score
                
                
                HighscoreDefault.setValue(Highscore, forKey: "Highscore")
                HighscoreLabel.text = NSString(format: "Highscore:  %i", Highscore) as String
            }
            
            
            HighscoreDefault.setValue(Highscore, forKey: "Highscore")
        }
        else{
          //  var Score = NSUserDefaults.standardUserDefaults()
           // Score.setValue(Score, forKey: "Score")
            
            ball.removeFromParent()
            baseA.removeFromParent()
            baseO.removeFromParent()
            baseR.removeFromParent()
            baseG.removeFromParent()
            baseY.removeFromParent()
            baseC.removeFromParent()
            ScoreLabel.removeFromSuperview()
            
            self.scene!.view?.presentScene(EndScene(fileNamed: "EndScene")!, transition: SKTransition.fadeWithDuration(0.1))
        }
        
    }
    
    
    
    func BallA(){
        ball = SKSpriteNode(imageNamed: "ball")
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.restitution = 0.9865
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.categoryBitMask = Physics.ballA
        ball.physicsBody?.contactTestBitMask = Physics.baseA
        ball.physicsBody?.contactTestBitMask = Physics.baseG
        ball.physicsBody?.contactTestBitMask = Physics.baseC
        ball.physicsBody?.contactTestBitMask = Physics.baseR
        ball.physicsBody?.contactTestBitMask = Physics.baseY
        ball.physicsBody?.contactTestBitMask = Physics.baseO
        ball.position = CGPoint(x:self.frame.width / 2, y: self.frame.height / 2)
        ball.size = CGSize(width: 15, height: 15)
        let color = SKAction.colorizeWithColor(UIColor.blueColor(), colorBlendFactor: 1, duration: 0.01)
        self.addChild(ball)
        ball.runAction(color)

    }
    
    
    
    
    func BaseA(){
        baseA = SKSpriteNode(imageNamed: "base")
        baseA.position = CGPoint(x: self.frame.width / 2 + 1.5, y: self.frame.height / 2 - 97)
        baseA.physicsBody = SKPhysicsBody(rectangleOfSize: baseA.size)
        baseA.physicsBody?.affectedByGravity = false
        baseA.physicsBody?.dynamic = false
        baseA.physicsBody?.categoryBitMask = Physics.baseA
        baseA.physicsBody?.contactTestBitMask = Physics.ballA
        baseA.physicsBody?.contactTestBitMask = Physics.ballG
        baseA.physicsBody?.contactTestBitMask = Physics.ballC
        baseA.physicsBody?.contactTestBitMask = Physics.ballR
        baseA.physicsBody?.contactTestBitMask = Physics.ballY
        baseA.physicsBody?.contactTestBitMask = Physics.ballO
        baseA.size = CGSize(width: 123, height: 14)
        self.addChild(baseA)
    }
    func BaseG(){
        baseG = SKSpriteNode(imageNamed: "baseG")
        baseG.position = CGPoint(x: self.frame.width / 2 + 85, y: self.frame.height / 2 - 49)
        baseG.physicsBody = SKPhysicsBody(rectangleOfSize: baseG.size)
        baseG.physicsBody?.affectedByGravity = false
        baseG.physicsBody?.dynamic = false
        baseG.physicsBody?.categoryBitMask = Physics.baseG
        baseG.physicsBody?.contactTestBitMask = Physics.ballA
        baseG.physicsBody?.contactTestBitMask = Physics.ballG
        baseG.physicsBody?.contactTestBitMask = Physics.ballC
        baseG.physicsBody?.contactTestBitMask = Physics.ballR
        baseG.physicsBody?.contactTestBitMask = Physics.ballY
        baseG.physicsBody?.contactTestBitMask = Physics.ballO
        let rotate = SKAction.rotateByAngle(1.047197551, duration: 0.01)
        baseG.runAction(rotate)
        baseG.size = CGSize(width: 119, height: 14)
        self.addChild(baseG)
    }
    func BaseC(){
        baseC = SKSpriteNode(imageNamed: "baseC")
        baseC.position = CGPoint(x: self.frame.width / 2 + 85, y: self.frame.height / 2 + 49)
        baseC.physicsBody = SKPhysicsBody(rectangleOfSize: baseC.size)
        baseC.physicsBody?.affectedByGravity = false
        baseC.physicsBody?.dynamic = false
        baseC.physicsBody?.categoryBitMask = Physics.baseC
        baseC.physicsBody?.contactTestBitMask = Physics.ballA
        baseC.physicsBody?.contactTestBitMask = Physics.ballG
        baseC.physicsBody?.contactTestBitMask = Physics.ballC
        baseC.physicsBody?.contactTestBitMask = Physics.ballR
        baseC.physicsBody?.contactTestBitMask = Physics.ballY
        baseC.physicsBody?.contactTestBitMask = Physics.ballO
        let rotate = SKAction.rotateByAngle(2.094395102, duration: 0.01)
        baseC.runAction(rotate)
        baseC.size = CGSize(width: 119, height: 14)
        
        self.addChild(baseC)
    }
    func BaseR(){
        baseR = SKSpriteNode(imageNamed: "baseR")
        baseR.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + 97)
        baseR.physicsBody = SKPhysicsBody(rectangleOfSize: baseR.size)
        baseR.physicsBody?.affectedByGravity = false
        baseR.physicsBody?.dynamic = false
        baseR.physicsBody?.categoryBitMask = Physics.baseR
        baseR.physicsBody?.contactTestBitMask = Physics.ballA
        baseR.physicsBody?.contactTestBitMask = Physics.ballG
        baseR.physicsBody?.contactTestBitMask = Physics.ballC
        baseR.physicsBody?.contactTestBitMask = Physics.ballR
        baseR.physicsBody?.contactTestBitMask = Physics.ballY
        baseR.physicsBody?.contactTestBitMask = Physics.ballO
        baseR.size = CGSize(width: 119, height: 14)
        let rotate = SKAction.rotateByAngle(3.1415926254, duration: 0.01)
        baseR.runAction(rotate)
        self.addChild(baseR)
    }
    func BaseY(){
        baseY = SKSpriteNode(imageNamed: "baseA")
        baseY.position = CGPoint(x: self.frame.width / 2 - 85, y: self.frame.height / 2 + 49)
        baseY.physicsBody = SKPhysicsBody(rectangleOfSize: baseY.size)
        baseY.physicsBody?.affectedByGravity = false
        baseY.physicsBody?.dynamic = false
        baseY.physicsBody?.categoryBitMask = Physics.baseY
        baseY.physicsBody?.contactTestBitMask = Physics.ballA
        baseY.physicsBody?.contactTestBitMask = Physics.ballG
        baseY.physicsBody?.contactTestBitMask = Physics.ballC
        baseY.physicsBody?.contactTestBitMask = Physics.ballR
        baseY.physicsBody?.contactTestBitMask = Physics.ballY
        baseY.physicsBody?.contactTestBitMask = Physics.ballO
        let rotate = SKAction.rotateByAngle(4.188790205, duration: 0.01)
        let color = SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 1, duration: 0.01)
        baseY.runAction(rotate)
        baseY.runAction(color)
        baseY.size = CGSize(width: 119, height: 14)
        
        self.addChild(baseY)
    }
    func BaseO(){
        baseO = SKSpriteNode(imageNamed: "baseN")
        baseO.position = CGPoint(x: self.frame.width / 2 - 85, y: self.frame.height / 2 - 49)
        baseO.physicsBody = SKPhysicsBody(rectangleOfSize: baseO.size)
        baseO.physicsBody?.affectedByGravity = false
        baseO.physicsBody?.dynamic = false
        baseO.physicsBody?.categoryBitMask = Physics.baseO
        baseO.physicsBody?.contactTestBitMask = Physics.ballA
        baseO.physicsBody?.contactTestBitMask = Physics.ballG
        baseO.physicsBody?.contactTestBitMask = Physics.ballC
        baseO.physicsBody?.contactTestBitMask = Physics.ballR
        baseO.physicsBody?.contactTestBitMask = Physics.ballY
        baseO.physicsBody?.contactTestBitMask = Physics.ballO
        let rotate = SKAction.rotateByAngle(5.235987756, duration: 0.01)
        baseO.runAction(rotate)
        baseO.size = CGSize(width: 119, height: 14)
        
        self.addChild(baseO)
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
            ball.physicsBody?.categoryBitMask = Physics.ballY
            break
        case 1:
            let color = SKAction.colorizeWithColor(UIColor.blueColor(), colorBlendFactor: 1, duration: 0.01)
            ball.runAction(color)
            ball.physicsBody?.categoryBitMask = Physics.ballA
            break
            
        case 2:
            let color = SKAction.colorizeWithColor(UIColor.brownColor(), colorBlendFactor: 1, duration: 0.01)
            ball.runAction(color)
            ball.physicsBody?.categoryBitMask = Physics.ballC
            break
            
        case 3:
            let color = SKAction.colorizeWithColor(UIColor.lightGrayColor(), colorBlendFactor: 1, duration: 0.01)
            ball.runAction(color)
            ball.physicsBody?.categoryBitMask = Physics.ballG
            break
            
        case 4:
            let color = SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: 1, duration: 0.01)
            ball.runAction(color)
            ball.physicsBody?.categoryBitMask = Physics.ballR
            break
            
        case 5:
            let color = SKAction.colorizeWithColor(UIColor.orangeColor(), colorBlendFactor: 1, duration: 0.01)
            ball.runAction(color)
            ball.physicsBody?.categoryBitMask = Physics.ballO
            break
        default: NSLog("mal")
        }
    }

    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        ++contador
        if contador > 6{
            contador = 1
        }

        Cases(contador)
        
    }

    func Cases(contador: Int){
        switch(contador){
        case 1: move1()
            break
        case 2: move2()
            break
        case 3: move3()
            break
        case 4: move4()
            break
        case 5: move5()
            break
        case 6: move6()
            break
        default: NSLog("mal")
            
        }
        
    }
    func move1(){
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 4.7124, endAngle: 5.77, clockwise: true)
        Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 5.77, endAngle: 6.806, clockwise: true)
        Path3 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:97, startAngle: 6.817, endAngle: 7.86, clockwise: true)
        Path4 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 7.875, endAngle: 8.91, clockwise: true)
        Path5 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 8.922, endAngle: 9.955, clockwise: true)
        Path6 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 9.969, endAngle: 11, clockwise: true)
        
        let follow1 = SKAction.followPath(Path.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow2 = SKAction.followPath(Path2.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow3 = SKAction.followPath(Path3.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow4 = SKAction.followPath(Path4.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow5 = SKAction.followPath(Path5.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow6 = SKAction.followPath(Path6.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        
        let rotate1 = SKAction.rotateByAngle(1.047197551, duration: 0.1)
        
        
        baseA.runAction(follow1)
        baseA.runAction(rotate1)
        
        
        baseG.runAction(follow2)
        baseG.runAction(rotate1)
        
        baseC.runAction(follow3)
        baseC.runAction(rotate1)
        
        baseR.runAction(follow4)
        baseR.runAction(rotate1)
        
        baseY.runAction(follow5)
        baseY.runAction(rotate1)
        
        baseO.runAction(follow6)
        baseO.runAction(rotate1)
        
    }
    
    func move2(){
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 4.7124, endAngle: 5.77, clockwise: true)
        Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:97, startAngle: 5.77, endAngle: 6.817, clockwise: true)
        Path3 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:97, startAngle: 6.817, endAngle: 7.86, clockwise: true)
        Path4 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 7.875, endAngle: 8.91, clockwise: true)
        Path5 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 8.922, endAngle: 9.955, clockwise: true)
        Path6 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 9.969, endAngle: 11, clockwise: true)
        
        let follow1 = SKAction.followPath(Path.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow2 = SKAction.followPath(Path2.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow3 = SKAction.followPath(Path3.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow4 = SKAction.followPath(Path4.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow5 = SKAction.followPath(Path5.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow6 = SKAction.followPath(Path6.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        
        let rotate1 = SKAction.rotateByAngle(1.047197551, duration: 0.1)
        
        
        
        
        baseA.runAction(follow2)
        baseA.runAction(rotate1)
        
        baseG.runAction(follow3)
        baseG.runAction(rotate1)
        
        baseC.runAction(follow4)
        baseC.runAction(rotate1)
        
        baseR.runAction(follow5)
        baseR.runAction(rotate1)
        
        baseY.runAction(follow6)
        baseY.runAction(rotate1)
        
        baseO.runAction(follow1)
        baseO.runAction(rotate1)
        
    }
    
    func move3(){
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 4.7124, endAngle: 5.77, clockwise: true)
        Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:97, startAngle: 5.77, endAngle: 6.806, clockwise: true)
        Path3 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:96, startAngle: 6.817, endAngle: 7.875, clockwise: true)
        Path4 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 7.875, endAngle: 8.91, clockwise: true)
        Path5 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 8.922, endAngle: 9.955, clockwise: true)
        Path6 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 9.969, endAngle: 11, clockwise: true)
        
        let follow1 = SKAction.followPath(Path.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow2 = SKAction.followPath(Path2.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow3 = SKAction.followPath(Path3.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow4 = SKAction.followPath(Path4.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow5 = SKAction.followPath(Path5.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow6 = SKAction.followPath(Path6.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        
        let rotate1 = SKAction.rotateByAngle(1.047197551, duration: 0.1)
        
       
        
        baseA.runAction(follow3)
        baseA.runAction(rotate1)
        
        baseG.runAction(follow4)
        baseG.runAction(rotate1)
        
        baseC.runAction(follow5)
        baseC.runAction(rotate1)
        
        baseR.runAction(follow6)
        baseR.runAction(rotate1)
        
        baseY.runAction(follow1)
        baseY.runAction(rotate1)
        
        baseO.runAction(follow2)
        baseO.runAction(rotate1)
        
    }
    
    func move4(){
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 4.7124, endAngle: 5.77, clockwise: true)
        Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:97, startAngle: 5.77, endAngle: 6.806, clockwise: true)
        Path3 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:96, startAngle: 6.817, endAngle: 7.86, clockwise: true)
        Path4 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 7.875, endAngle: 8.91, clockwise: true)
        Path5 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 8.922, endAngle: 9.955, clockwise: true)
        Path6 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 9.969, endAngle: 11, clockwise: true)
        
        let follow1 = SKAction.followPath(Path.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow2 = SKAction.followPath(Path2.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow3 = SKAction.followPath(Path3.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow4 = SKAction.followPath(Path4.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow5 = SKAction.followPath(Path5.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow6 = SKAction.followPath(Path6.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        
        let rotate1 = SKAction.rotateByAngle(1.047197551, duration: 0.1)
        
        
        baseA.runAction(follow4)
        baseA.runAction(rotate1)
        
        baseG.runAction(follow5)
        baseG.runAction(rotate1)
        
        baseC.runAction(follow6)
        baseC.runAction(rotate1)
        
        baseR.runAction(follow1)
        baseR.runAction(rotate1)
        
        baseY.runAction(follow2)
        baseY.runAction(rotate1)
        
        baseO.runAction(follow3)
        baseO.runAction(rotate1)
        
    }
    
    func move5(){
        
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 4.7124, endAngle: 5.77, clockwise: true)
        Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:97, startAngle: 5.77, endAngle: 6.806, clockwise: true)
        Path3 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:96, startAngle: 6.817, endAngle: 7.86, clockwise: true)
        Path4 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 7.875, endAngle: 8.91, clockwise: true)
        Path5 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 8.922, endAngle: 9.955, clockwise: true)
        Path6 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 9.969, endAngle: 10.99, clockwise: true)
        
        let follow1 = SKAction.followPath(Path.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow2 = SKAction.followPath(Path2.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow3 = SKAction.followPath(Path3.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow4 = SKAction.followPath(Path4.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow5 = SKAction.followPath(Path5.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow6 = SKAction.followPath(Path6.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        
        let rotate1 = SKAction.rotateByAngle(1.047197551, duration: 0.1)
        
        
        
        baseA.runAction(follow5)
        baseA.runAction(rotate1)
        
        baseG.runAction(follow6)
        baseG.runAction(rotate1)
        
        baseC.runAction(follow1)
        baseC.runAction(rotate1)
        
        baseR.runAction(follow2)
        baseR.runAction(rotate1)
        
        baseY.runAction(follow3)
        baseY.runAction(rotate1)
        
        baseO.runAction(follow4)
        baseO.runAction(rotate1)
        
    }
    
    func move6(){
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 4.7124, endAngle: 5.77, clockwise: true)
        Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:97, startAngle: 5.77, endAngle: 6.806, clockwise: true)
        Path3 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:96, startAngle: 6.817, endAngle: 7.86, clockwise: true)
        Path4 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 7.875, endAngle: 8.922, clockwise: true)
        Path5 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 8.922, endAngle: 9.955, clockwise: true)
        Path6 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 9.969, endAngle: 10.99, clockwise: true)
        
        let follow1 = SKAction.followPath(Path.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow2 = SKAction.followPath(Path2.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow3 = SKAction.followPath(Path3.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow4 = SKAction.followPath(Path4.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow5 = SKAction.followPath(Path5.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow6 = SKAction.followPath(Path6.CGPath, asOffset: false, orientToPath: false, speed: 2000)
        
        let rotate1 = SKAction.rotateByAngle(1.047197551, duration: 0.08)
        
        
        baseA.runAction(follow6)
        baseA.runAction(rotate1)
        
        baseG.runAction(follow1)
        baseG.runAction(rotate1)
        
        baseC.runAction(follow2)
        baseC.runAction(rotate1)
        
        baseR.runAction(follow3)
        baseR.runAction(rotate1)
        
        baseY.runAction(follow4)
        baseY.runAction(rotate1)
        
        baseO.runAction(follow5)
        baseO.runAction(rotate1)
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
