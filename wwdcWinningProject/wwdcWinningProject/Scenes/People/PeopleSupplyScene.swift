//
//  PeopleSupplyScene.swift
//  wwdcWinningProject
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 27/03/18.
//  Copyright © 2018 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import SpriteKit

class PeopleSupplyScene: SKScene{
    
    ///MARK: - Propertys
    let backgroundSceneColor = UIColor(red: 197/255, green: 240/255, blue: 164/255, alpha: 1.0)
    let lightFontName = UIFont.systemFont(ofSize: 20, weight: .light).fontName
    var totalJobs = 0
    
    ///MARK: - didMove
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = backgroundSceneColor
        setupScene()
    }
    
    ///MARK: - Methods
    func scaleAction(_ up :CGFloat = 1.5) -> SKAction{
        let scaleUp = SKAction.scale(to: up, duration: 1.0)
        let scaleDown = SKAction.scale(to: 1.0, duration: 1.0)
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        let repeatForever = SKAction.repeatForever(sequence)
        return repeatForever
    }
    
    func update(text: String) -> SKAction{
        let jobsLabel = childNode(withName: "jobsLabel") as? SKLabelNode
        let blockText = SKAction.run {
            jobsLabel?.text = "Over \(text) jobs in US"
        }
        return SKAction.sequence([.wait(forDuration: 1.0), blockText])
    }
    
    func moveJobsLabelUp(){
        let titleLabel = childNode(withName: "titleLabel") as? SKLabelNode
        titleLabel?.run(.fadeAlpha(to: 0.0, duration: 1.0))
        let jobsLabel = childNode(withName: "jobsLabel") as? SKLabelNode
        jobsLabel?.run(.sequence([.wait(forDuration: 2.0), .move(to: CGPoint(x: size.width/2, y: size.height * 0.8), duration: 1.0)]))
        createTexts()
    }
    
    func createTexts(){
        let suppliersBlock = SKAction.run {
            let firstLabel = SKLabelNode(fontNamed: self.lightFontName)
            firstLabel.fontColor = .black
            firstLabel.numberOfLines = 4
            firstLabel.position = CGPoint(x: self.size.width * 0.3, y: self.size.height * 0.25)
            let attributedText = NSMutableAttributedString.init(string: "14,7m\napple's supplier employees have\nbeen trained on workplace\nprotections since 2007")
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            attributedText.setAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28, weight: .light), NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.paragraphStyle: paragraph], range: NSMakeRange(0, 5))
            attributedText.setAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .light), NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.paragraphStyle: paragraph], range: NSMakeRange(6, 80))
            firstLabel.attributedText = attributedText
            firstLabel.alpha = 0
            self.addChild(firstLabel)
            firstLabel.run(.fadeAlpha(to: 1.0, duration: 1.0))
        }
        
        let healthBlock = SKAction.run{
            let secondLabel = SKLabelNode(fontNamed: self.lightFontName)
            secondLabel.fontColor = .black
            secondLabel.numberOfLines = 4
            secondLabel.position = CGPoint(x: self.size.width * 0.7, y: self.size.height * 0.25)
            let attributedTextSecond = NSMutableAttributedString.init(string: "4k+\nparticipants received\npreventive and women's\nhealth training")
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            attributedTextSecond.setAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28, weight: .light), NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.paragraphStyle: paragraph], range: NSMakeRange(0, 3))
            attributedTextSecond.setAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .light), NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.paragraphStyle: paragraph], range: NSMakeRange(4, 60))
            secondLabel.attributedText = attributedTextSecond
            secondLabel.alpha = 0
            self.addChild(secondLabel)
            secondLabel.run(.fadeAlpha(to: 1.0, duration: 1.0))
        }
        
        self.run(.sequence([.wait(forDuration: 3.0), suppliersBlock, .wait(forDuration: 5.0), healthBlock, .wait(forDuration: 5.0), createNextButton()]))
    }
    
    func tranformNumberToTextFormat(amount: Int) -> String{
        if amount == 80000{
            return "80,000"
        }else if amount == 450000{
            return "450,000"
        }else if amount == 1530000{
            return "1,530,000"
        }else if amount == 530000{
            return "530,000"
        }else if amount == 1610000{
            return "1,610,000"
        }else if amount == 1980000{
            return "1,980,000"
        }else{
            moveJobsLabelUp()
            return "2,000,000"
        }
    }
    
    func addTotalJobs(amount: Int){
        let jobsLabel = childNode(withName: "jobsLabel") as? SKLabelNode
        
        switch totalJobs {
        case 0:
            jobsLabel?.run(.sequence([update(text: tranformNumberToTextFormat(amount: amount)), .fadeAlpha(to: 1.0, duration: 1.0)]))
            totalJobs += amount
        case 80000:
            jobsLabel?.run(update(text: tranformNumberToTextFormat(amount: totalJobs + amount)))
            totalJobs += amount
        case 450000:
            jobsLabel?.run(update(text: tranformNumberToTextFormat(amount: totalJobs + amount)))
            totalJobs += amount
        case 1530000:
            jobsLabel?.run(update(text: tranformNumberToTextFormat(amount: totalJobs + amount)))
            totalJobs += amount
        case 530000:
            jobsLabel?.run(update(text: tranformNumberToTextFormat(amount: totalJobs + amount)))
            totalJobs += amount
        case 1610000:
            jobsLabel?.run(update(text: tranformNumberToTextFormat(amount: totalJobs + amount)))
            totalJobs += amount
        case 1980000:
            jobsLabel?.run(update(text: tranformNumberToTextFormat(amount: totalJobs + amount)))
            totalJobs += amount
        default:
            //Should not enter here
            totalJobs = -80000000
        }
    }
    
    func clicked(node: SKSpriteNode, label: SKLabelNode){
        label.run(.fadeAlpha(to: 0.0, duration: 1.0))
        let jobsLabel = childNode(withName: "jobsLabel") as? SKLabelNode
        node.run(.sequence([.move(to: CGPoint(x: (jobsLabel?.position.x)!, y: (jobsLabel?.position.y)!), duration: 1.0), .fadeAlpha(to: 0.0, duration: 1.0)]))
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
    
}
///Mark: - Touches methods extension
extension PeopleSupplyScene{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchNode = atPoint(location)
            if touchNode.name == "nextButton"{
                let scene = PeopleEducationScene(size: (view?.frame.size)!)
                scene.scaleMode = .aspectFill
                let transition = SKTransition.reveal(with: .left, duration: 1.0)
                view?.presentScene(scene, transition: transition)
            }else if touchNode.name == "employeesNode" || touchNode.name == "employeesLabel"{
                clicked(node: (childNode(withName: "employeesNode") as? SKSpriteNode)!, label: (childNode(withName: "employeesLabel") as? SKLabelNode)!)
                addTotalJobs(amount: 80000)
            }else if touchNode.name == "suppliersNode" ||  touchNode.name == "suppliersLabel"{
                addTotalJobs(amount: 450000)
                clicked(node: (childNode(withName: "suppliersNode") as? SKSpriteNode)!, label: (childNode(withName: "suppliersLabel") as? SKLabelNode)!)
            }else if touchNode.name == "appStoreNode" ||  touchNode.name == "appStoreLabel"{
                addTotalJobs(amount: 1530000)
                clicked(node: (childNode(withName: "appStoreNode") as? SKSpriteNode)!, label: (childNode(withName: "appStoreLabel") as? SKLabelNode)!)
            }else{
                //Do nothing
            }
        }
    }
}

///MARK: - Setup methods extension
extension PeopleSupplyScene{
    func setupScene(){
        let titleLabel = SKLabelNode(fontNamed: lightFontName)
        titleLabel.text = "Click on the images to see how many jobs apple create"
        titleLabel.name = "titleLabel"
        titleLabel.fontColor = .black
        titleLabel.fontSize = 22
        titleLabel.position = CGPoint(x: size.width/2, y: size.height - 30)
        addChild(titleLabel)
        
        let employeesLabel = SKLabelNode(fontNamed: lightFontName)
        employeesLabel.text = "Employees"
        employeesLabel.name = "employeesLabel"
        employeesLabel.fontColor = .black
        employeesLabel.fontSize = 12
        employeesLabel.position = CGPoint(x: size.width * 0.25, y: size.height - 70)
        addChild(employeesLabel)
        employeesLabel.run(scaleAction(1.2))
        
        let suppliersLabel = SKLabelNode(fontNamed: lightFontName)
        suppliersLabel.text = "Suppliers"
        suppliersLabel.name = "suppliersLabel"
        suppliersLabel.fontSize = 12
        suppliersLabel.fontColor = .black
        suppliersLabel.position = CGPoint(x: size.width * 0.5, y: employeesLabel.position.y)
        addChild(suppliersLabel)
        suppliersLabel.run(scaleAction(1.2))
        
        let appStoreLabel = SKLabelNode(fontNamed: lightFontName)
        appStoreLabel.text = "App Store"
        appStoreLabel.name = "appStoreLabel"
        appStoreLabel.fontSize = 12
        appStoreLabel.fontColor = .black
        appStoreLabel.position = CGPoint(x: size.width * 0.75, y: employeesLabel.position.y)
        addChild(appStoreLabel)
        appStoreLabel.run(scaleAction(1.2))
        
        let employeesNode = SKSpriteNode(imageNamed: "employee")
        employeesNode.name = "employeesNode"
        employeesNode.position = CGPoint(x: employeesLabel.position.x, y: employeesLabel.frame.minY - 50)
        addChild(employeesNode)
        employeesNode.run(scaleAction(1.7))
        
        let suppliersNode = SKSpriteNode(imageNamed: "supplier")
        suppliersNode.name = "suppliersNode"
        suppliersNode.position = CGPoint(x: suppliersLabel.position.x, y: suppliersLabel.frame.minY - 50)
        addChild(suppliersNode)
        suppliersNode.run(scaleAction(1.3))
        
        let appStoreNode = SKSpriteNode(imageNamed: "appstore")
        appStoreNode.name = "appStoreNode"
        appStoreNode.position = CGPoint(x: appStoreLabel.position.x, y: appStoreLabel.frame.minY - 50)
        addChild(appStoreNode)
        appStoreNode.run(scaleAction(1.4))
        
        let jobsLabel = SKLabelNode(fontNamed: lightFontName)
        jobsLabel.name = "jobsLabel"
        jobsLabel.text = "Over 2.000.000 jobs in US"
        jobsLabel.fontSize = 34
        jobsLabel.fontColor = .black
        jobsLabel.position = CGPoint(x: size.width/2, y: size.height * 0.3)
        addChild(jobsLabel)
        jobsLabel.alpha = 0
    }
}
