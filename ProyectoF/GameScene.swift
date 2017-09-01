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
    
    var HighscoreDefault = UserDefaults.standard
    var Highscore = Int()
    var HighscoreLabel = UILabel()
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        let backgroundMusic = SKAudioNode(fileNamed: "music.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        physicsWorld.contactDelegate = self
        
        
        
        if (HighscoreDefault.value(forKey: "Highscore") != nil){
            Highscore = HighscoreDefault.value(forKey: "Highscore") as! NSInteger!
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
        ScoreLabel.textColor = UIColor.black
        self.view?.addSubview(ScoreLabel)
        
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -4)
        
        //self.scene?.backgroundColor = UIColor.darkGrayColor()
        let sceneBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        sceneBody.friction = 0
        self.physicsBody = sceneBody
        backgroundColor = SKColor.white
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
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
            
            self.scene!.view?.presentScene(EndScene(fileNamed: "EndScene")!, transition: SKTransition.fade(withDuration: 0.1))
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
        let color = SKAction.colorize(with: UIColor.blue, colorBlendFactor: 1, duration: 0.01)
        self.addChild(ball)
        ball.run(color)

    }
    
    
    
    
    func BaseA(){
        baseA = SKSpriteNode(imageNamed: "base")
        baseA.position = CGPoint(x: self.frame.width / 2 + 1.5, y: self.frame.height / 2 - 97)
        baseA.physicsBody = SKPhysicsBody(rectangleOf: baseA.size)
        baseA.physicsBody?.affectedByGravity = false
        baseA.physicsBody?.isDynamic = false
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
        baseG.physicsBody = SKPhysicsBody(rectangleOf: baseG.size)
        baseG.physicsBody?.affectedByGravity = false
        baseG.physicsBody?.isDynamic = false
        baseG.physicsBody?.categoryBitMask = Physics.baseG
        baseG.physicsBody?.contactTestBitMask = Physics.ballA
        baseG.physicsBody?.contactTestBitMask = Physics.ballG
        baseG.physicsBody?.contactTestBitMask = Physics.ballC
        baseG.physicsBody?.contactTestBitMask = Physics.ballR
        baseG.physicsBody?.contactTestBitMask = Physics.ballY
        baseG.physicsBody?.contactTestBitMask = Physics.ballO
        let rotate = SKAction.rotate(byAngle: 1.047197551, duration: 0.01)
        baseG.run(rotate)
        baseG.size = CGSize(width: 119, height: 14)
        self.addChild(baseG)
    }
    func BaseC(){
        baseC = SKSpriteNode(imageNamed: "baseC")
        baseC.position = CGPoint(x: self.frame.width / 2 + 85, y: self.frame.height / 2 + 49)
        baseC.physicsBody = SKPhysicsBody(rectangleOf: baseC.size)
        baseC.physicsBody?.affectedByGravity = false
        baseC.physicsBody?.isDynamic = false
        baseC.physicsBody?.categoryBitMask = Physics.baseC
        baseC.physicsBody?.contactTestBitMask = Physics.ballA
        baseC.physicsBody?.contactTestBitMask = Physics.ballG
        baseC.physicsBody?.contactTestBitMask = Physics.ballC
        baseC.physicsBody?.contactTestBitMask = Physics.ballR
        baseC.physicsBody?.contactTestBitMask = Physics.ballY
        baseC.physicsBody?.contactTestBitMask = Physics.ballO
        let rotate = SKAction.rotate(byAngle: 2.094395102, duration: 0.01)
        baseC.run(rotate)
        baseC.size = CGSize(width: 119, height: 14)
        
        self.addChild(baseC)
    }
    func BaseR(){
        baseR = SKSpriteNode(imageNamed: "baseR")
        baseR.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + 97)
        baseR.physicsBody = SKPhysicsBody(rectangleOf: baseR.size)
        baseR.physicsBody?.affectedByGravity = false
        baseR.physicsBody?.isDynamic = false
        baseR.physicsBody?.categoryBitMask = Physics.baseR
        baseR.physicsBody?.contactTestBitMask = Physics.ballA
        baseR.physicsBody?.contactTestBitMask = Physics.ballG
        baseR.physicsBody?.contactTestBitMask = Physics.ballC
        baseR.physicsBody?.contactTestBitMask = Physics.ballR
        baseR.physicsBody?.contactTestBitMask = Physics.ballY
        baseR.physicsBody?.contactTestBitMask = Physics.ballO
        baseR.size = CGSize(width: 119, height: 14)
        let rotate = SKAction.rotate(byAngle: 3.1415926254, duration: 0.01)
        baseR.run(rotate)
        self.addChild(baseR)
    }
    func BaseY(){
        baseY = SKSpriteNode(imageNamed: "baseA")
        baseY.position = CGPoint(x: self.frame.width / 2 - 85, y: self.frame.height / 2 + 49)
        baseY.physicsBody = SKPhysicsBody(rectangleOf: baseY.size)
        baseY.physicsBody?.affectedByGravity = false
        baseY.physicsBody?.isDynamic = false
        baseY.physicsBody?.categoryBitMask = Physics.baseY
        baseY.physicsBody?.contactTestBitMask = Physics.ballA
        baseY.physicsBody?.contactTestBitMask = Physics.ballG
        baseY.physicsBody?.contactTestBitMask = Physics.ballC
        baseY.physicsBody?.contactTestBitMask = Physics.ballR
        baseY.physicsBody?.contactTestBitMask = Physics.ballY
        baseY.physicsBody?.contactTestBitMask = Physics.ballO
        let rotate = SKAction.rotate(byAngle: 4.188790205, duration: 0.01)
        let color = SKAction.colorize(with: UIColor.green, colorBlendFactor: 1, duration: 0.01)
        baseY.run(rotate)
        baseY.run(color)
        baseY.size = CGSize(width: 119, height: 14)
        
        self.addChild(baseY)
    }
    func BaseO(){
        baseO = SKSpriteNode(imageNamed: "baseN")
        baseO.position = CGPoint(x: self.frame.width / 2 - 85, y: self.frame.height / 2 - 49)
        baseO.physicsBody = SKPhysicsBody(rectangleOf: baseO.size)
        baseO.physicsBody?.affectedByGravity = false
        baseO.physicsBody?.isDynamic = false
        baseO.physicsBody?.categoryBitMask = Physics.baseO
        baseO.physicsBody?.contactTestBitMask = Physics.ballA
        baseO.physicsBody?.contactTestBitMask = Physics.ballG
        baseO.physicsBody?.contactTestBitMask = Physics.ballC
        baseO.physicsBody?.contactTestBitMask = Physics.ballR
        baseO.physicsBody?.contactTestBitMask = Physics.ballY
        baseO.physicsBody?.contactTestBitMask = Physics.ballO
        let rotate = SKAction.rotate(byAngle: 5.235987756, duration: 0.01)
        baseO.run(rotate)
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
            let color = SKAction.colorize(with: UIColor.green, colorBlendFactor: 1, duration: 0.01)
            ball.run(color)
            ball.physicsBody?.categoryBitMask = Physics.ballY
            break
        case 1:
            let color = SKAction.colorize(with: UIColor.blue, colorBlendFactor: 1, duration: 0.01)
            ball.run(color)
            ball.physicsBody?.categoryBitMask = Physics.ballA
            break
            
        case 2:
            let color = SKAction.colorize(with: UIColor.brown, colorBlendFactor: 1, duration: 0.01)
            ball.run(color)
            ball.physicsBody?.categoryBitMask = Physics.ballC
            break
            
        case 3:
            let color = SKAction.colorize(with: UIColor.lightGray, colorBlendFactor: 1, duration: 0.01)
            ball.run(color)
            ball.physicsBody?.categoryBitMask = Physics.ballG
            break
            
        case 4:
            let color = SKAction.colorize(with: UIColor.red, colorBlendFactor: 1, duration: 0.01)
            ball.run(color)
            ball.physicsBody?.categoryBitMask = Physics.ballR
            break
            
        case 5:
            let color = SKAction.colorize(with: UIColor.orange, colorBlendFactor: 1, duration: 0.01)
            ball.run(color)
            ball.physicsBody?.categoryBitMask = Physics.ballO
            break
        default: NSLog("mal")
        }
    }

    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        contador += 1
        if contador > 6{
            contador = 1
        }

        Cases(contador)
        
    }

    func Cases(_ contador: Int){
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
        
        let follow1 = SKAction.follow(Path.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow2 = SKAction.follow(Path2.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow3 = SKAction.follow(Path3.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow4 = SKAction.follow(Path4.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow5 = SKAction.follow(Path5.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow6 = SKAction.follow(Path6.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        
        let rotate1 = SKAction.rotate(byAngle: 1.047197551, duration: 0.1)
        
        
        baseA.run(follow1)
        baseA.run(rotate1)
        
        
        baseG.run(follow2)
        baseG.run(rotate1)
        
        baseC.run(follow3)
        baseC.run(rotate1)
        
        baseR.run(follow4)
        baseR.run(rotate1)
        
        baseY.run(follow5)
        baseY.run(rotate1)
        
        baseO.run(follow6)
        baseO.run(rotate1)
        
    }
    
    func move2(){
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 4.7124, endAngle: 5.77, clockwise: true)
        Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:97, startAngle: 5.77, endAngle: 6.817, clockwise: true)
        Path3 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:97, startAngle: 6.817, endAngle: 7.86, clockwise: true)
        Path4 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 7.875, endAngle: 8.91, clockwise: true)
        Path5 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 8.922, endAngle: 9.955, clockwise: true)
        Path6 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 9.969, endAngle: 11, clockwise: true)
        
        let follow1 = SKAction.follow(Path.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow2 = SKAction.follow(Path2.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow3 = SKAction.follow(Path3.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow4 = SKAction.follow(Path4.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow5 = SKAction.follow(Path5.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow6 = SKAction.follow(Path6.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        
        let rotate1 = SKAction.rotate(byAngle: 1.047197551, duration: 0.1)
        
        
        
        
        baseA.run(follow2)
        baseA.run(rotate1)
        
        baseG.run(follow3)
        baseG.run(rotate1)
        
        baseC.run(follow4)
        baseC.run(rotate1)
        
        baseR.run(follow5)
        baseR.run(rotate1)
        
        baseY.run(follow6)
        baseY.run(rotate1)
        
        baseO.run(follow1)
        baseO.run(rotate1)
        
    }
    
    func move3(){
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 4.7124, endAngle: 5.77, clockwise: true)
        Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:97, startAngle: 5.77, endAngle: 6.806, clockwise: true)
        Path3 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:96, startAngle: 6.817, endAngle: 7.875, clockwise: true)
        Path4 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 7.875, endAngle: 8.91, clockwise: true)
        Path5 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 8.922, endAngle: 9.955, clockwise: true)
        Path6 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 9.969, endAngle: 11, clockwise: true)
        
        let follow1 = SKAction.follow(Path.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow2 = SKAction.follow(Path2.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow3 = SKAction.follow(Path3.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow4 = SKAction.follow(Path4.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow5 = SKAction.follow(Path5.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow6 = SKAction.follow(Path6.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        
        let rotate1 = SKAction.rotate(byAngle: 1.047197551, duration: 0.1)
        
       
        
        baseA.run(follow3)
        baseA.run(rotate1)
        
        baseG.run(follow4)
        baseG.run(rotate1)
        
        baseC.run(follow5)
        baseC.run(rotate1)
        
        baseR.run(follow6)
        baseR.run(rotate1)
        
        baseY.run(follow1)
        baseY.run(rotate1)
        
        baseO.run(follow2)
        baseO.run(rotate1)
        
    }
    
    func move4(){
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 4.7124, endAngle: 5.77, clockwise: true)
        Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:97, startAngle: 5.77, endAngle: 6.806, clockwise: true)
        Path3 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:96, startAngle: 6.817, endAngle: 7.86, clockwise: true)
        Path4 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 7.875, endAngle: 8.91, clockwise: true)
        Path5 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 8.922, endAngle: 9.955, clockwise: true)
        Path6 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 9.969, endAngle: 11, clockwise: true)
        
        let follow1 = SKAction.follow(Path.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow2 = SKAction.follow(Path2.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow3 = SKAction.follow(Path3.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow4 = SKAction.follow(Path4.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow5 = SKAction.follow(Path5.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow6 = SKAction.follow(Path6.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        
        let rotate1 = SKAction.rotate(byAngle: 1.047197551, duration: 0.1)
        
        
        baseA.run(follow4)
        baseA.run(rotate1)
        
        baseG.run(follow5)
        baseG.run(rotate1)
        
        baseC.run(follow6)
        baseC.run(rotate1)
        
        baseR.run(follow1)
        baseR.run(rotate1)
        
        baseY.run(follow2)
        baseY.run(rotate1)
        
        baseO.run(follow3)
        baseO.run(rotate1)
        
    }
    
    func move5(){
        
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 4.7124, endAngle: 5.77, clockwise: true)
        Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:97, startAngle: 5.77, endAngle: 6.806, clockwise: true)
        Path3 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:96, startAngle: 6.817, endAngle: 7.86, clockwise: true)
        Path4 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 7.875, endAngle: 8.91, clockwise: true)
        Path5 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 8.922, endAngle: 9.955, clockwise: true)
        Path6 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 9.969, endAngle: 10.99, clockwise: true)
        
        let follow1 = SKAction.follow(Path.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow2 = SKAction.follow(Path2.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow3 = SKAction.follow(Path3.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow4 = SKAction.follow(Path4.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow5 = SKAction.follow(Path5.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow6 = SKAction.follow(Path6.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        
        let rotate1 = SKAction.rotate(byAngle: 1.047197551, duration: 0.1)
        
        
        
        baseA.run(follow5)
        baseA.run(rotate1)
        
        baseG.run(follow6)
        baseG.run(rotate1)
        
        baseC.run(follow1)
        baseC.run(rotate1)
        
        baseR.run(follow2)
        baseR.run(rotate1)
        
        baseY.run(follow3)
        baseY.run(rotate1)
        
        baseO.run(follow4)
        baseO.run(rotate1)
        
    }
    
    func move6(){
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 4.7124, endAngle: 5.77, clockwise: true)
        Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:97, startAngle: 5.77, endAngle: 6.806, clockwise: true)
        Path3 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:96, startAngle: 6.817, endAngle: 7.86, clockwise: true)
        Path4 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 7.875, endAngle: 8.922, clockwise: true)
        Path5 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 8.922, endAngle: 9.955, clockwise: true)
        Path6 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y:self.frame.height/2), radius:98, startAngle: 9.969, endAngle: 10.99, clockwise: true)
        
        let follow1 = SKAction.follow(Path.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow2 = SKAction.follow(Path2.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow3 = SKAction.follow(Path3.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow4 = SKAction.follow(Path4.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow5 = SKAction.follow(Path5.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        let follow6 = SKAction.follow(Path6.cgPath, asOffset: false, orientToPath: false, speed: 2000)
        
        let rotate1 = SKAction.rotate(byAngle: 1.047197551, duration: 0.08)
        
        
        baseA.run(follow6)
        baseA.run(rotate1)
        
        baseG.run(follow1)
        baseG.run(rotate1)
        
        baseC.run(follow2)
        baseC.run(rotate1)
        
        baseR.run(follow3)
        baseR.run(rotate1)
        
        baseY.run(follow4)
        baseY.run(rotate1)
        
        baseO.run(follow5)
        baseO.run(rotate1)
        
    }
   
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
