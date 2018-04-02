//
//  EnviromentMenuScene.swift
//  wwdcWinningProject
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/03/18.
//  Copyright © 2018 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import SpriteKit

public class EnviromentMenuScene: SKScene{
    
    ///MARK: - didMove
    override public func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = sceneBackgroundColor
        setupScene()
    }
    
    ///MARK: - Propertys
    let sceneBackgroundColor = UIColor(red: 250/255, green: 255/255, blue: 184/255, alpha: 1.0)
}

///Mark: - Touches methods extension
extension EnviromentMenuScene{
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchNode = atPoint(location)
            
            if touchNode.name == "nextButton"{
                let scene = EnviromentEnergyScene(size: size)
                scene.scaleMode = .aspectFill
                view?.presentScene(scene)
            }else{
                //Do nothing
            }
        }
    }
    
}


///Mark: = Setup Methods Extension
extension EnviromentMenuScene{
    func setupScene(){
        let wwdcLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 10, weight: .bold).fontName)
        wwdcLabel.text = "WWDC 2018"
        wwdcLabel.fontSize = 16
        wwdcLabel.fontColor = .black
        wwdcLabel.position = CGPoint(x: size.width/2, y: size.height - 20)
        
        let socialGoodLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .bold).fontName)
        socialGoodLabel.text = "Social Good"
        socialGoodLabel.fontSize = 24
        socialGoodLabel.fontColor = .black
        socialGoodLabel.position = CGPoint(x: size.width/2, y: size.height - 50)
        
        let appleLogo = SKSpriteNode(imageNamed: "applelogo")
        appleLogo.position = CGPoint(x: size.width/2, y: size.height/2 + 30)
        
        let welcomeLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        welcomeLabel.text = "Welcome! In this playground there will be some tasks for you to\ncomplete that will teach you a lot about apple’s social policies."
        welcomeLabel.numberOfLines = 2
        welcomeLabel.fontSize = 18
        welcomeLabel.fontColor = .black
        welcomeLabel.position = CGPoint(x: size.width/2, y: size.height/2 - 130)
        
        let nextButton = SKSpriteNode(imageNamed: "nextButton")
        nextButton.name = "nextButton"
        nextButton.position = CGPoint(x: size.width - 100, y: 25)
        nextButton.alpha = 0
        nextButton.name = "nextButton"
        
        addChild(wwdcLabel)
        addChild(socialGoodLabel)
        addChild(appleLogo)
        addChild(welcomeLabel)
        addChild(nextButton)
        
        nextButton.run(.sequence([.wait(forDuration: 2.0), .fadeAlpha(to: 1.0, duration: 1.0)]))
    }
}
