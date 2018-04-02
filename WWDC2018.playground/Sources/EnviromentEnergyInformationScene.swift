//
//  EnviromentEnergyInformationScene.swift
//  wwdcWinningProject
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/03/18.
//  Copyright © 2018 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import SpriteKit

public class EnviromentEnergyInformationScene: SKScene{
    ///MARK: - Propertys
    let sceneBackgroundColor = UIColor(red: 250/255, green: 255/255, blue: 184/255, alpha: 1.0)
    
    ///MARK: - didMove
    override public func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = sceneBackgroundColor
        setupDataCenterInformation()
        createDataCenterAnimation()
        createBatteryAnimation()
        run(.sequence([.wait(forDuration: 6.0), callFacilitiesInformation(), .wait(forDuration: 5.0), createNextButton()]))
    }
    
    ///MARK: - Methods
    func update(text: String, in labelNode: SKLabelNode, at position: CGPoint) -> SKAction{
        
        let wait = SKAction.wait(forDuration: 2.0)
        let block = SKAction.run {
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            let attributedText = NSMutableAttributedString.init(string: "\(labelNode.text!) \(text)")
            attributedText.setAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28, weight: .light), NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.paragraphStyle: paragraph], range: NSMakeRange(0, (labelNode.text?.count)!))
            attributedText.setAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16, weight: .light), NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.paragraphStyle: paragraph], range: NSMakeRange(4, (labelNode.text?.count)! + (text.count) - 4))
            
            labelNode.attributedText = attributedText
            labelNode.position = CGPoint(x: position.x + 70, y: position.y - 45)
        }
        let sequence = SKAction.sequence([wait, block])
        return sequence
    }
    
    func callFacilitiesInformation() -> SKAction{
        let block = SKAction.run {
            self.setupGlobalFacilitiesInformation()
        }
        return block
    }
    
    func createNextButton() -> SKAction{
        let block = SKAction.run {
            let nextButton = SKSpriteNode(imageNamed: "nextButton")
            nextButton.name = "nextButton"
            nextButton.position = CGPoint(x: self.size.width - 100, y: 25)
            
            self.addChild(nextButton)
        }
        return block
    }
    
    func createDataCenterAnimation(){
        let dataCenterNode = childNode(withName: "dataCenterSpriteNode") as? SKSpriteNode
        let wait = SKAction.wait(forDuration: 1.0)
        var count = 1
        let block = SKAction.run {
            dataCenterNode?.texture = SKTexture(imageNamed: "datacenter\(count)")
            count += 1
        }
        let sequence = SKAction.sequence([block, wait, block, wait, block])
        dataCenterNode?.run(sequence, withKey: "dataCenterNodeAction")
    }
    
    func createBatteryAnimation(){
        let batteryNode = childNode(withName: "batteryNode") as? SKSpriteNode
        let wait = SKAction.wait(forDuration: 1.0)
        var count = 1
        let block = SKAction.run {
            batteryNode?.texture = SKTexture(imageNamed: "battery\(count)")
            count += 1
        }
        let sequence = SKAction.sequence([block, wait, block, wait, block])
        batteryNode?.run(sequence, withKey: "batteryNodeAction")
        
    }
}

///Mark: - Touches methods extension
extension EnviromentEnergyInformationScene{
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchNode = atPoint(location)
            
            if touchNode.name == "nextButton"{
                let scene = EnviromentPlanetsInformationScene(size: size)
                scene.scaleMode = .aspectFill
                let transition = SKTransition.reveal(with: .left, duration: 1.0)
                view?.presentScene(scene, transition: transition)
            }else{
                //Do nothing
            }
        }
    }
    
}


///MARK: - Setup Methods Extension
extension EnviromentEnergyInformationScene{
    func setupDataCenterInformation(){
        let dataCenterInformationLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        dataCenterInformationLabel.text = "100%"
        dataCenterInformationLabel.name = "dataCenterInformationLabel"
        dataCenterInformationLabel.position = CGPoint(x: size.width * 0.2, y: size.height * 0.8)
        dataCenterInformationLabel.numberOfLines = 4
        dataCenterInformationLabel.fontSize = 28
        dataCenterInformationLabel.fontColor = .black
        
        let dataCenterSpriteNode = SKSpriteNode(imageNamed: "datacenter0")
        dataCenterSpriteNode.name = "dataCenterSpriteNode"
        dataCenterSpriteNode.position = CGPoint(x: dataCenterInformationLabel.position.x + 250, y: dataCenterInformationLabel.position.y)
        
        addChild(dataCenterInformationLabel)
        addChild(dataCenterSpriteNode)
        dataCenterInformationLabel.run(update(text: "of apple's datacenters\n energy come from renewable forms\n of energy, like solar, water and\n wind power.", in: dataCenterInformationLabel, at: dataCenterInformationLabel.position), withKey: "dataCenterInformationLabelAction")
    }
    
    func setupGlobalFacilitiesInformation(){
        let facilitiesInformation = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        facilitiesInformation.text = "96%"
        facilitiesInformation.name = "facilitiesInformation"
        facilitiesInformation.position = CGPoint(x: size.width * 0.3, y: size.height/2 - 40)
        facilitiesInformation.numberOfLines = 3
        facilitiesInformation.fontSize = 28
        facilitiesInformation.fontColor = .black
        
        let batteryNode = SKSpriteNode(imageNamed: "battery")
        batteryNode.name = "batteryNode"
        batteryNode.position = CGPoint(x: facilitiesInformation.position.x - 100, y: facilitiesInformation.position.y - 10)
        
        addChild(facilitiesInformation)
        addChild(batteryNode)
        createBatteryAnimation()
        facilitiesInformation.run(update(text: "of the electricity that\n powers apple's global facilities comes\n from renewable sources.", in: facilitiesInformation, at: facilitiesInformation.position), withKey: "facilitiesInformationAction")
    }
}
