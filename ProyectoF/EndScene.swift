//
//  EndingScene.swift
//  ProyectoF
//
//  Created by Jose Andres Salazar on 11/29/15.
//  Copyright © 2015 Jose Andres Salazar. All rights reserved.
//

import Foundation
import SpriteKit

class EndScene: SKScene {
    
    var HighscoreLabel = UILabel()
    var HighscoreLabel2 = UILabel()
    var Score = UserDefaults.standard
    var Score2 = UserDefaults.standard
    var highscore2 = Int()
    var highscore = Int()
    var restart: SKSpriteNode!
    var RestartB: UIButton!
    var menu: SKSpriteNode!
    var RestartB2: UIButton!
    var mode1: SKSpriteNode!
    var mode2: SKSpriteNode!
    
    
    override func didMove(to view: SKView) {

        
        scene?.backgroundColor = UIColor.white
        
        Mode1()
        Mode2()
        
        if (Score.value(forKey: "Highscore") != nil){
            highscore = Score.value(forKey: "Highscore") as! NSInteger!
            HighscoreLabel.text = "Highscore:  \(highscore)"
            
        }
        
        if(Score2.value(forKey: "Highscore2") != nil){
            highscore2 = Score2.value(forKey: "Highscore2") as! NSInteger!
            
        }

        
        HighscoreLabel = UILabel(frame: CGRect(x: 105, y: 95, width: 150, height: 20))
        HighscoreLabel.textColor = UIColor.black
        self.view?.addSubview(HighscoreLabel)
        
        HighscoreLabel2 = UILabel(frame: CGRect(x: 105, y: 185, width: 150, height: 20))
        HighscoreLabel2.textColor = UIColor.black
        self.view?.addSubview(HighscoreLabel2)
        HighscoreLabel2.text = "Highscore:  \(highscore2)"
        
        HighscoreLabel.text = "Highscore:  \(highscore)"
        Restart()
        Menu()
        
    }
    
    func Mode1(){
            mode1 = SKSpriteNode(imageNamed: "mode1")
            mode1.position = CGPoint(x: self.frame.width / 2 , y: self.frame.height / 2 + 150)
            mode1.size = CGSize(width: 130.62, height: 37.38)
            self.addChild(mode1)
    }
    
    func Mode2(){
        mode2 = SKSpriteNode(imageNamed: "mode2")
        mode2.position = CGPoint(x: self.frame.width / 2 , y: self.frame.height / 2 + 60)
        mode2.size = CGSize(width: 130.62, height: 37.38)
        self.addChild(mode2)
    }
    
    
    func Restart(){
        restart = SKSpriteNode(imageNamed: "restart")
        restart.position = CGPoint(x: self.frame.width / 2 , y: self.frame.height / 2 - 50)
        restart.size = CGSize(width: 217.7, height: 62.3)
        self.addChild(restart)
        RestartB = UIButton(frame: CGRect(x: self.frame.width / 2, y: self.frame.height / 2 + 50, width: 190, height: 40))
        RestartB.center = CGPoint(x: view!.frame.size.width / 2, y: self.frame.height / 2 + 50)
        RestartB.setTitle("", for: UIControlState())
        RestartB.setTitleColor(UIColor.darkGray, for: UIControlState())
        RestartB.addTarget(self, action: #selector(EndScene.Move), for: UIControlEvents.touchUpInside)
        self.view?.addSubview(RestartB)
        
        
    }
    
    
    func Move(){
        HighscoreLabel.removeFromSuperview()
        HighscoreLabel2.removeFromSuperview()
        if  Physics.modo==1{
        self.scene!.view?.presentScene(GameScene(fileNamed: "GameScene")!, transition: SKTransition.fade(withDuration: 0.1))
            //NSLog("\(Physics.modo)")
            RestartB.removeFromSuperview()
            RestartB2.removeFromSuperview()
        }
        else {
            self.scene!.view?.presentScene(CrazyScene(fileNamed: "CrazyScene")!, transition: SKTransition.fade(withDuration: 0.1))
            RestartB.removeFromSuperview()
            RestartB2.removeFromSuperview()
        }
        
        
        
    }

    func Menu(){
        menu = SKSpriteNode(imageNamed: "menu")
        menu.position = CGPoint(x: self.frame.width / 2 , y: self.frame.height / 2 - 150)
        menu.size = CGSize(width: 217.7, height: 62.3)
        self.addChild(menu)
        RestartB2 = UIButton(frame: CGRect(x: self.frame.width / 2, y: self.frame.height / 2 + 150, width: 190, height: 40))
        RestartB2.center = CGPoint(x: view!.frame.size.width / 2, y: self.frame.height / 2 + 150)
        RestartB2.setTitle("", for: UIControlState())
        RestartB2.setTitleColor(UIColor.darkGray, for: UIControlState())
        RestartB2.addTarget(self, action: #selector(EndScene.MoveM), for: UIControlEvents.touchUpInside)
        self.view?.addSubview(RestartB2)
        
        
    }
    
    
    func MoveM(){
        HighscoreLabel.removeFromSuperview()
        HighscoreLabel2.removeFromSuperview()
         RestartB2.removeFromSuperview()
        RestartB.removeFromSuperview()
        self.scene!.view?.presentScene(MenuScene(fileNamed: "MenuScene")!, transition: SKTransition.fade(withDuration: 0.1))
       
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        
    }
}
