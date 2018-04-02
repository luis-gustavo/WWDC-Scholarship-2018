//
//  EnviromentEnergyScene.swift
//  wwdcWinningProject
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/03/18.
//  Copyright © 2018 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import SpriteKit

public class EnviromentEnergyScene: SKScene{  
    ///MARK: - Propertys
    let sceneBackgroundColor = UIColor(red: 250/255, green: 255/255, blue: 184/255, alpha: 1.0)
    let buttonColor = UIColor(red: 34/255, green: 107/255, blue: 128/255, alpha: 1.0)
    var numberOfTouches = 0
    var didTouchWindMill = false
    var didTouchSun = false
    var didTouchHydro = false
  
    ///MARK: - didMove
    override public func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = sceneBackgroundColor
        setupWindMills()
        setupSun()
        setupHydro()
        setupDataCenter()
        setupFillLabel()
        setupTitleLabel()
    }
    
    ///MARK: Methods
    func rotationWindMillAction(_ duration : TimeInterval = 2.0) -> SKAction{
        let rotation = SKAction.rotate(byAngle: 360, duration: duration)
        let repeatForever = SKAction.repeatForever(rotation)
        return repeatForever
    }
    
    func scaleAction(_ scale : CGFloat = 1.2, _ duration : TimeInterval = 1.0) -> SKAction{
        let scaleUp = SKAction.scale(to: scale, duration: duration)
        let scaleDown = SKAction.scale(to: 1.0, duration: duration)
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        let repeatForever = SKAction.repeatForever(sequence)
        return repeatForever
    }
    
    func touchedWindMill(_ touchNode: SKNode) -> Bool{
        
        if (touchNode.name == "flyingWindMillOne" || touchNode.name == "flyingWindMillTwo" || touchNode.name == "flyingWindMillThree" || touchNode.name == "staticWindMillOne" || touchNode.name == "staticWindMillTwo" || touchNode.name == "staticWindMillThree") && !didTouchWindMill{
            didTouchWindMill = true
            return true
        }else{
            return false
        }
    }
    
    func touchedSun(_ touchNode: SKNode) -> Bool{
        if touchNode.name == "sun" && !didTouchSun{
            didTouchSun = true
            return true
        }else{
            return false
        }
    }
    
    func touchedHydro(_ touchNode: SKNode) -> Bool{
        if touchNode.name == "hydro" && !didTouchHydro{
            didTouchHydro = true
            return true
        }else{
            return false
        }
    }
    
    func touchedEnergySource(){
        numberOfTouches += 1
        let dataCenter = childNode(withName: "dataCenter") as? SKSpriteNode
        let fillLabel = childNode(withName: "fillLabel") as? SKLabelNode
        if numberOfTouches == 1 {
            fillLabel?.text =  "Good, go to the next one!"
            dataCenter?.texture = SKTexture(imageNamed: "datacenter1")
            dataCenter?.run(createShakeDataCenterAction(), withKey: "dataCenterAction")
        }else if numberOfTouches == 2{
            fillLabel?.text =  "Just one more!"
            dataCenter?.texture = SKTexture(imageNamed: "datacenter2")
            dataCenter?.run(createShakeDataCenterAction(), withKey: "dataCenterAction")
        }else if numberOfTouches == 3{
            fillLabel?.text =  "Nice!"
            dataCenter?.texture = SKTexture(imageNamed: "datacenter3")
            dataCenter?.run(createShakeDataCenterAction(), withKey: "dataCenterAction")
            createNextButton()
        }else{
            ///Do nothing
        }
    }
    
    func changeHydroImageAction() -> SKAction{
        let hydroTextures = [SKTexture(imageNamed: "hydro2"), SKTexture(imageNamed: "hydro3")]
        let animation = SKAction.animate(with: Array(hydroTextures[0...1]), timePerFrame: 0.1, resize: false, restore: false)
        let repeatForever = SKAction.repeatForever(animation)
        return repeatForever
    }
    
    func createNextButton(){
        let nextButton = SKSpriteNode(imageNamed: "nextButton")
        nextButton.name = "nextButton"
        nextButton.position = CGPoint(x: size.width - 100, y: 25)
        
        addChild(nextButton)
    }
    
    func createShakeDataCenterAction() -> SKAction{
        let rotateLeft = SKAction.rotate(byAngle: 0.1, duration: 0.05)
        let rotateRight = SKAction.rotate(byAngle: -0.1, duration: 0.05)
        let sequence = SKAction.sequence([rotateLeft, rotateRight, rotateRight, rotateLeft,rotateLeft, rotateRight,rotateRight, rotateLeft])
        return sequence
    }
    
    func createStar(){
        let star = SKSpriteNode(imageNamed: "star")
        star.zPosition = -1
        star.position = CGPoint(x: size.width, y: size.height)
        addChild(star)
        star.run(scaleAction(5.0, 2.0), withKey: "starAction")
    }

}

///Mark: - Touches methods extension
extension EnviromentEnergyScene{
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchNode = atPoint(location)
            
            if touchedWindMill(touchNode){
                removeAction(forKey: "flyingWindMillOneAction")
                removeAction(forKey: "flyingWindMillTwoAction")
                removeAction(forKey: "flyingWindMillThreeAction")
                let flyingWindMillOne = childNode(withName: "flyingWindMillOne")
                let flyingWindMillTwo = childNode(withName: "flyingWindMillTwo")
                let flyingWindMillThree = childNode(withName: "flyingWindMillThree")
                flyingWindMillOne?.run(rotationWindMillAction(), withKey: "flyingWindMillOneAction")
                flyingWindMillTwo?.run(rotationWindMillAction(), withKey: "flyingWindMillTwoAction")
                flyingWindMillThree?.run(rotationWindMillAction(), withKey: "flyingWindMillThreeAction")
                
                touchedEnergySource()
            }else if touchedSun(touchNode){
                let sun = childNode(withName: "sun")
                sun?.removeAllActions()
                removeAction(forKey: "sunAction")
                createStar()
    
                touchedEnergySource()
            }else if touchedHydro(touchNode){
                removeAction(forKey: "hydroAction")
                let hydro = childNode(withName: "hydro")
                hydro?.run(changeHydroImageAction(), withKey: "hydroAction")
                
                touchedEnergySource()
            }else if touchNode.name == "nextButton"{
                let scene = EnviromentEnergyInformationScene(size: size)
                scene.scaleMode = .aspectFill
                let transition = SKTransition.reveal(with: .left, duration: 1.0)
                view?.presentScene(scene, transition: transition)
            }else{
                //Do nothing
            }
        }
    }
    
}

///MARK: - Setup Methods extension
extension EnviromentEnergyScene{
    func setupWindMills(){
        ///Setup first wind mill
        let flyingWindMillOne = SKSpriteNode(imageNamed: "mills")
        flyingWindMillOne.name = "flyingWindMillOne"
        let staticWindMillOne = SKSpriteNode(imageNamed: "mill2")
        staticWindMillOne.name = "staticWindMillTwo"
        flyingWindMillOne.position = CGPoint(x: 120, y: size.height - 60)
        staticWindMillOne.position = CGPoint(x: 120, y: size.height - 98)
        staticWindMillOne.zPosition = 1
        flyingWindMillOne.run(scaleAction(), withKey: "flyingWindMillOneAction")
        
        ///Setup second wind mill
        let flyingWindMillTwo = SKSpriteNode(imageNamed: "mills")
        flyingWindMillTwo.name = "flyingWindMillTwo"
        let staticWindMillTwo = SKSpriteNode(imageNamed: "mill2")
        staticWindMillTwo.name = "staticWindMillTwo"
        flyingWindMillTwo.position = CGPoint(x: 50, y: size.height - 70)
        flyingWindMillTwo.xScale = 0.75
        flyingWindMillTwo.yScale = 0.75
        staticWindMillTwo.position = CGPoint(x: 50, y: size.height - 98)
        staticWindMillTwo.zPosition = 1
        staticWindMillTwo.xScale = 0.75
        staticWindMillTwo.yScale = 0.75
        flyingWindMillTwo.run(scaleAction(), withKey: "flyingWindMillTwoAction")
        
        ///Setup third wind mill
        let flyingWindMillThree = SKSpriteNode(imageNamed: "mills")
        flyingWindMillThree.name = "flyingWindMillThree"
        let staticWindMillThree = SKSpriteNode(imageNamed: "mill2")
        staticWindMillThree.name = "staticWindMillThree"
        flyingWindMillThree.position = CGPoint(x: 190, y: size.height - 70)
        flyingWindMillThree.xScale = 0.75
        flyingWindMillThree.yScale = 0.75
        staticWindMillThree.position = CGPoint(x: 190, y: size.height - 98)
        staticWindMillThree.zPosition = 1
        staticWindMillThree.xScale = 0.75
        staticWindMillThree.yScale = 0.75
        flyingWindMillThree.run(scaleAction(), withKey: "flyingWindMillThreeAction")
        
        ///Add wind mills to the scene
        addChild(flyingWindMillOne)
        addChild(staticWindMillOne)
        addChild(flyingWindMillTwo)
        addChild(staticWindMillTwo)
        addChild(flyingWindMillThree)
        addChild(staticWindMillThree)
    }
    
    func setupSun(){
        let sun = SKSpriteNode(imageNamed: "sun")
        sun.name = "sun"
        sun.position = CGPoint(x: size.width - 80, y: size.height - 70)
        sun.run(scaleAction(), withKey: "sunAction")
        
        addChild(sun)
    }
    
    func setupHydro(){
        let hydro = SKSpriteNode(imageNamed: "hydro1")
        hydro.name = "hydro"
        hydro.position = CGPoint(x: size.width/2, y: 60)
        hydro.run(scaleAction(), withKey: "hydroAction")
        
        addChild(hydro)
    }
    
    func setupDataCenter(){
        let dataCenter = SKSpriteNode(imageNamed: "datacenter0")
        dataCenter.name = "dataCenter"
        dataCenter.position = CGPoint(x: size.width/2, y: size.height/2)
        
        addChild(dataCenter)
    }
    
    func setupFillLabel(){
        let fillLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 10, weight: .light).fontName)
        fillLabel.text = "Charge it up!"
        fillLabel.name = "fillLabel"
        fillLabel.fontColor = .black
        fillLabel.fontSize = 18
        let dataCenterPosition = childNode(withName: "dataCenter")?.position
        fillLabel.position = CGPoint(x: (dataCenterPosition?.x)!, y: (dataCenterPosition?.y)! + 50)
        
        addChild(fillLabel)
    }
    
    func setupTitleLabel(){
        let titleLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        titleLabel.text = "Click on the renewable energy sources\n\t\tto charge apple's datacenter"
        titleLabel.name = "titleLabel"
        titleLabel.fontColor = .black
        titleLabel.numberOfLines = 4
        titleLabel.fontSize = 22
        titleLabel.position = CGPoint(x: size.width/2 + 30, y: size.height - 60)
        
        addChild(titleLabel)
    }
}
