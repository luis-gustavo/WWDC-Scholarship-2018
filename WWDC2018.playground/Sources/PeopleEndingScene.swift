//
//  PeopleEndingScene.swift
//  wwdcWinningProject
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 30/03/18.
//  Copyright © 2018 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import SpriteKit

class PeopleEndingScene: SKScene{
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = UIColor(red: 197/255, green: 240/255, blue: 164/255, alpha: 1.0)
        
        initialSetup()
    }
    
    func initialSetup(){
        let label = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        label.name = "label"
        label.text = "     You finished it!\nCongratulations! 🎉🎉"
        label.fontSize = 24
        label.fontColor = .black
        label.numberOfLines = 2
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        let block = SKAction.run {
            self.setupScene()
        }
        label.run(.sequence([.wait(forDuration: 2.5), .move(to: CGPoint(x: size.width/2, y: size.height - 40), duration: 1.0), block]))
    }
    
    func setupScene(){
        let firstLabel = childNode(withName: "label") as? SKLabelNode
        firstLabel?.text = "About this playground"
        firstLabel?.fontColor = .black
        firstLabel?.fontSize = 22
        firstLabel?.position = CGPoint(x: size.width/2, y: size.height - 40)
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        let secondLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        secondLabel.text = "This playground tells about some of apple’s\nsocial policies, starting with enviromental\npolicies and followed by policies towards people"
        var attributedText = NSMutableAttributedString.init(string: "This playground tells about some of apple’s\nsocial policies, starting with enviromental\npolicies and followed by policies towards people")
        attributedText.setAttributes([NSAttributedStringKey.paragraphStyle: paragraph, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .light)], range: NSMakeRange(0, (secondLabel.text?.count)!))
        secondLabel.attributedText = attributedText
        secondLabel.numberOfLines = 3
        secondLabel.fontColor = .black
        secondLabel.fontSize = 18
        secondLabel.position = CGPoint(x: size.width/2, y: size.height * 0.56)
        addChild(secondLabel)
        secondLabel.alpha = 0
        secondLabel.run(.sequence([.wait(forDuration: 0.5), .fadeAlpha(to: 1.0, duration: 1.0)]))
        
        let thirdLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        thirdLabel.text = "Life is all about the people that we live with.\nWe must take care of the planet we live in and\nlove and respect the people around us"
        attributedText = NSMutableAttributedString.init(string: "Life is all about the people that we live with.\nWe must take care of the planet we live in and\nlove and respect the people around us")
        attributedText.setAttributes([NSAttributedStringKey.paragraphStyle: paragraph, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .light)], range: NSMakeRange(0, (thirdLabel.text?.count)!))
        thirdLabel.attributedText = attributedText
        thirdLabel.numberOfLines = 3
        thirdLabel.fontColor = .black
        thirdLabel.fontSize = 18
        thirdLabel.position = CGPoint(x: size.width/2, y: size.height * 0.25)
        addChild(thirdLabel)
        thirdLabel.alpha = 0
        thirdLabel.run(.sequence([.wait(forDuration: 4.0), .fadeAlpha(to: 1.0, duration: 1.0)]))
        
        let playAgainButton = SKSpriteNode(imageNamed: "playagainbutton")
        playAgainButton.name = "playAgainButton"
        playAgainButton.position = CGPoint(x: size.width/2, y: 30)
        addChild(playAgainButton)
        playAgainButton.alpha = 0
        playAgainButton.run(.sequence([.wait(forDuration:7.0), .fadeAlpha(to: 1.0, duration: 1.0)]))
    }
}

///Mark: - Touches methods extension
extension PeopleEndingScene{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchNode = atPoint(location)
            if touchNode.name == "playAgainButton"{
                let scene = EnviromentMenuScene(size: (view?.frame.size)!)
                scene.scaleMode = .aspectFill
                let transition = SKTransition.flipVertical(withDuration: 1.0)
                view?.presentScene(scene, transition: transition)
            }else{
                //Do nothing
            }
        }
    }
}
