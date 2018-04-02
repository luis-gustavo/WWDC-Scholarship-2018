//
//  PeopleDiversityScene.swift
//  wwdcWinningProject
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 26/03/18.
//  Copyright © 2018 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import SpriteKit
enum Balloon: String {
    case pink = "pinkballoon"
    case rainbow = "rainbowballoon"
    case brown = "brownballoon"
}

class PeopleDiversityScene: SKScene{
    
    var balloonsHit = [false, false, false]
    
    ///MARK: - Propertys
    let backgroundSceneColor = UIColor(red: 197/255, green: 240/255, blue: 164/255, alpha: 1.0)
    let lgbtqColor = UIColor(red: 169/255, green: 241/255, blue: 225/255, alpha: 1.0)
    
    ///MARK: - didMove
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = backgroundSceneColor
        setupScene()
        setupBalloon(getRandomBallon()!)
        setupGraph()
        setupCircle()
        setupFlag()
    }
    
    ///MARK: - Methods
    func moveUpAnimation(_ y: CGFloat, _ duration: TimeInterval) -> SKAction{
        let moveUp = SKAction.moveTo(y: y, duration: duration)
        return moveUp
    }
    
    func newBalloon(node: SKSpriteNode, balloon: Balloon) -> SKSpriteNode{
        let randomBallon = self.getRandomBallon()
        if randomBallon?.rawValue == "pinkballoon"{
            node.name = "pinkBalloon"
            node.texture = SKTexture(imageNamed: (randomBallon?.rawValue)!)
            node.position = self.randomXPosition(y: -500)
        }else if randomBallon?.rawValue == "rainbowballoon"{
            node.name = "rainbowBalloon"
            node.texture = SKTexture(imageNamed: (randomBallon?.rawValue)!)
            node.position = self.randomXPosition(y: -500)
        }else if randomBallon?.rawValue == "brownballoon"{
            node.name = "brownBalloon"
            node.texture = SKTexture(imageNamed: (randomBallon?.rawValue)!)
            node.position = self.randomXPosition(y: -500)
        }
        return node
    }
    
    func createNextButton(){
        let nextButton = SKSpriteNode(imageNamed: "nextButton")
        nextButton.name = "nextButton"
        nextButton.position = CGPoint(x: self.size.width - 100, y: 25)
        
        for subview in (view?.subviews)!{
            if subview.restorationIdentifier == "circleView" || subview.restorationIdentifier == "circleViewBrown"{
                subview.removeFromSuperview()
            }
        }
        self.addChild(nextButton)
    }
    
    func allTrue() -> Bool{
        for value in balloonsHit{
            if value == false{
                return false
            }
        }
        return true
    }
    
    func animateGraph(){
        let pinkGraph = childNode(withName: "pinkGraph") as? SKSpriteNode
        
        let graphTextures = [SKTexture(imageNamed: "pinkgraph2"), SKTexture(imageNamed: "pinkgraph3"), SKTexture(imageNamed: "pinkgraph4"), SKTexture(imageNamed: "pinkgraph5")]
        let customPink = UIColor(red: 241/255, green: 198/255, blue: 222/255, alpha: 1.0)
        run(.colorize(with: customPink, colorBlendFactor: 1.0, duration: 1.0))
        let appearGraphLabelBlock = SKAction.run {
            let graphLabel = self.childNode(withName: "graphLabel")
            graphLabel?.run(.fadeAlpha(to: 1.0, duration: 0.5), withKey: "graphLabelAction")
        }
        let appearFemaleLabelBlock = SKAction.run {
            let femaleLabel = self.childNode(withName: "femaleLabel")
            femaleLabel?.run(.fadeAlpha(to: 1.0, duration: 1.0), withKey: "femaleLabelAction")
        }
        let appearArrow = SKAction.run {
            let arrowNode = self.childNode(withName: "arrowNode")
            let femalePercentLabel = self.childNode(withName: "femalePercentLabel")
            arrowNode?.run(.fadeAlpha(to: 1.0, duration: 1.0), withKey: "arrowNodeAction")
            femalePercentLabel?.run(.fadeAlpha(to: 1.0, duration: 1.0), withKey: "femalePercentLabelAction")
        }
        let animateLabels = SKAction.run {
            let femaleLabel = self.childNode(withName: "femaleLabel")
            let arrowNode = self.childNode(withName: "arrowNode")
            let femalePercentLabel = self.childNode(withName: "femalePercentLabel")
            arrowNode?.run(.scale(to: 2.0, duration: 1.0), withKey: "arrowNodeAction")
            femaleLabel?.run(.moveTo(y: (femaleLabel?.position.y)! + 12, duration: 1.0), withKey: "femaleLabelAction")
            let block = SKAction.run {
                (femalePercentLabel as? SKLabelNode)?.text = "36%"
            }
            femalePercentLabel?.run(.sequence([.moveTo(y: (femalePercentLabel?.position.y)! - 5, duration: 1.0), block]), withKey: "femalePercentLabelAction")
        }
        let wait = SKAction.wait(forDuration: 1.0)
        let block = SKAction.run {
            self.checkHittedBalloons()
        }
        
        let fadeOutBlock = SKAction.run {
            
            let allTrue = self.allTrue()
            if allTrue == true{
                
            }else{
                pinkGraph?.run(.fadeAlpha(to: 0.0, duration: 1.0))
                let femaleLabel = self.childNode(withName: "femaleLabel")
                femaleLabel?.run(.fadeAlpha(to: 0.0, duration: 1.0))
                let arrowNode = self.childNode(withName: "arrowNode")
                arrowNode?.run(.fadeAlpha(to: 0.0, duration: 1.0))
                let femalePercentLabel = self.childNode(withName: "femalePercentLabel")
                femalePercentLabel?.run(.fadeAlpha(to: 0.0, duration: 1.0))
                let graphLabel = self.childNode(withName: "graphLabel")
                graphLabel?.run(.fadeAlpha(to: 0.0, duration: 1.0))
            }
        }
        
        let sequence = SKAction.sequence([.fadeAlpha(to: 1.0, duration: 0.5), .animate(with: graphTextures, timePerFrame: 0.5), appearGraphLabelBlock, wait, appearFemaleLabelBlock, appearArrow, wait, animateLabels, .wait(forDuration: 5.0), fadeOutBlock, block])
        
        pinkGraph?.run(sequence, withKey: "pinkGraphAction")
    }
    
    func removeBalloon(_ balloon: SKSpriteNode){
        balloon.removeAllActions()
        let alphaAction = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
        let block = SKAction.run {
            balloon.removeFromParent()
        }
        balloon.run(.sequence([alphaAction, block]), withKey: "\(balloon.name!)Action")
    }
    
    func addCircleView(x: CGFloat, y: CGFloat, color: UIColor, endAngle: CGFloat = CGFloat(.pi * 2.0), identifier: String = "circleView", alpha: CGFloat) {
        let circleWidth = CGFloat(110)
        let circleHeight = circleWidth
        let circleView = CircleView(frame: CGRect(x: x, y: y, width: circleWidth, height: circleHeight), color: color, endAngle: endAngle)
        circleView.restorationIdentifier = identifier
        
        view?.addSubview(circleView)
        
        circleView.animateCircle(duration: 1.0)
        
        circleView.alpha = alpha
    }
    
    func animateMinoriesCircle(){
        let purple = UIColor(red: 201/255, green: 169/255, blue: 241/255, alpha: 1.0)
        run(.colorize(with: purple, colorBlendFactor: 1.0, duration: 1.0))
        for subview in (view?.subviews)!{
            if subview.restorationIdentifier == "circleView"{
                subview.alpha = 1
            }
        }
        let customBrown = UIColor(red: 171/255, green: 113/255, blue: 83/255, alpha: 1.0)
        
        let circleViewBlock = SKAction.run {
            self.addCircleView(x: self.size.width * 0.5 - 57, y: self.size.height * 0.23, color: customBrown, endAngle: .pi/2, identifier: "circleViewBrown", alpha: 1)
        }
        let percentLabel = childNode(withName: "percentLabel") as? SKLabelNode
        let block = SKAction.run {
            percentLabel?.text = "50%"
        }
        let textBlock = SKAction.run {
            let minoriesLabel = self.childNode(withName: "minoriesLabel")
            minoriesLabel?.run(.fadeAlpha(to: 1.0, duration: 1.0), withKey: "minoriesLabelAction")
        }
        let rainbowBallonBlock = SKAction.run {
            self.checkHittedBalloons()
        }
        
        let fadeOutBlock = SKAction.run {
            
            let allTrue = self.allTrue()
            if allTrue{
                
            }else{
                for subview in (self.view?.subviews)!{
                    if subview.restorationIdentifier == "circleView" || subview.restorationIdentifier == "circleViewBrown"{
                        SKView.animate(withDuration: 1.0, animations: {
                            subview.alpha = 0
                        })
                    }
                }
                percentLabel?.run(.fadeAlpha(to: 0.0, duration: 1.0))
                let minoriesLabel = self.childNode(withName: "minoriesLabel")
                minoriesLabel?.run(.fadeAlpha(to: 0.0, duration: 1.0))
            }
        }
        percentLabel?.run(.sequence([.fadeAlpha(to: 1.0, duration: 0.5), circleViewBlock, .wait(forDuration: 1.0), block, textBlock, .wait(forDuration: 5.0), fadeOutBlock, rainbowBallonBlock]), withKey: "percentLabelAction")
    }
    
    func animateFlag(){
        let flagNode = childNode(withName: "flagNode")
        let flagText = childNode(withName: "flagText")
        let flagTitle = childNode(withName: "flagTitle")
        let flagNodeBlock = SKAction.run {
            flagNode?.run(.fadeAlpha(to: 1.0, duration: 1.0))
            self.run(.colorize(with: self.lgbtqColor, colorBlendFactor: 1.0, duration: 0.5))
        }
        let flagTitleBlock = SKAction.run {
            flagTitle?.run(.fadeAlpha(to: 1.0, duration: 1.0))
        }
        let flagTextBlock = SKAction.run {
            flagText?.run(.fadeAlpha(to: 1.0, duration: 1.0))
        }
        let nextButtonBlock = SKAction.run {
            self.checkHittedBalloons()
        }
        
        let fadeOutBlock = SKAction.run {
            let allTrue = self.allTrue()
            if allTrue{
                
            }else{
                flagNode?.run(.fadeAlpha(to: 0.0, duration: 1.0))
                flagText?.run(.fadeAlpha(to: 0.0, duration: 1.0))
                flagTitle?.run(.fadeAlpha(to: 0.0, duration: 1.0))
            }
        }
        
        run(.sequence([flagNodeBlock, .wait(forDuration: 1.5), flagTitleBlock, .wait(forDuration: 1.0), flagTextBlock, .wait(forDuration: 5.0), fadeOutBlock, nextButtonBlock]))
    }
    
    func getRandomBallon() -> Balloon?{
        if balloonsHit[0] == false && balloonsHit[1] == false && balloonsHit[2] == false{
            let randomNumber = arc4random_uniform(3)
            return randomNumber == 0 ? .pink : (randomNumber == 1 ? .rainbow : .brown)
        }else if balloonsHit[0] == false && balloonsHit[1] == false{
            let randomNumber = arc4random_uniform(2)
            return randomNumber == 0 ? .pink :  .rainbow
        }else if balloonsHit[0] == false && balloonsHit[2] == false{
            let randomNumber = arc4random_uniform(2)
            return randomNumber == 0 ? .pink : .brown
        }else if balloonsHit[1] == false && balloonsHit[2] == false{
            let randomNumber = arc4random_uniform(2)
            return randomNumber == 0 ? .rainbow : .brown
        }else if balloonsHit[0] == false{
            return .pink
        }else if balloonsHit[1] == false{
            return .rainbow
        }else if balloonsHit[2] == false{
            return .brown
        }else{
            return nil
        }
    }
    
    func randomXPosition(y: CGFloat) -> CGPoint{
        return CGPoint(x: CGFloat(arc4random_uniform(UInt32(size.width * 0.6) + UInt32(size.width * 0.2))), y: y)
    }
    
    func checkHittedBalloons(){
        let randomBalloon = getRandomBallon()
        if randomBalloon == nil{
            createNextButton()
        }else{
            setupBalloon(randomBalloon!)
        }
    }
}

///Mark: - Touches methods extension
extension PeopleDiversityScene{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchNode = atPoint(location)
            
            if touchNode.name == "nextButton"{
                let scene = PeopleSupplyScene(size: size)
                scene.scaleMode = .aspectFill
                let transition = SKTransition.reveal(with: .left, duration: 1.0)
                view?.presentScene(scene, transition: transition)
            }else if touchNode.name == "pinkBalloon"{
                touchNode.removeAllActions()
                removeBalloon((childNode(withName: touchNode.name!) as? SKSpriteNode)!)
                balloonsHit[0] = true
                animateGraph()
            }else if touchNode.name == "rainbowBalloon"{
                touchNode.removeAllActions()
                removeBalloon((childNode(withName: touchNode.name!) as? SKSpriteNode)!)
                balloonsHit[1] = true
                animateFlag()
            }else if touchNode.name == "brownBalloon"{
                touchNode.removeAllActions()
                removeBalloon((childNode(withName: touchNode.name!) as? SKSpriteNode)!)
                balloonsHit[2] = true
                animateMinoriesCircle()
            }else{
                //Do nothing
            }
        }
    }
}

///MARK: - Setup methods extension
extension PeopleDiversityScene{
    
    func setupScene(){
        let titleLabel = SKSpriteNode(imageNamed: "hit")
        titleLabel.position = CGPoint(x: size.width/2, y: size.height - 25)
        
        addChild(titleLabel)
    }
    
    func setupBalloon(_ type: Balloon){
        switch type {
        case .pink:
            var pinkBalloon = SKSpriteNode(imageNamed: type.rawValue)
            pinkBalloon.name = "pinkBalloon"
            pinkBalloon.position = randomXPosition(y: -500)
            pinkBalloon.zPosition = 1
            addChild(pinkBalloon)
            
            let moveAction = moveUpAnimation(size.height + 500, 4.0)
            let block = SKAction.run{
                pinkBalloon = self.newBalloon(node: pinkBalloon, balloon: .pink)
            }
            let sequence = SKAction.sequence([moveAction, block])
            let repeatForever = SKAction.repeatForever(sequence)
            pinkBalloon.run(repeatForever)
            
        case .rainbow:
            var rainbowBalloon = SKSpriteNode(imageNamed: type.rawValue)
            rainbowBalloon.name = "rainbowBalloon"
            rainbowBalloon.position = randomXPosition(y: -500)
            rainbowBalloon.zPosition = 1
            addChild(rainbowBalloon)
            let moveAction = moveUpAnimation(size.height + 500, 4.0)
            let block = SKAction.run{
                rainbowBalloon = self.newBalloon(node: rainbowBalloon, balloon: .rainbow)
            }
            let sequence = SKAction.sequence([moveAction, block])
            let repeatForever = SKAction.repeatForever(sequence)
            rainbowBalloon.run(repeatForever)
        case .brown:
            var brownBalloon = SKSpriteNode(imageNamed: type.rawValue)
            brownBalloon.name = "brownBalloon"
            brownBalloon.position = randomXPosition(y: -500)
            brownBalloon.zPosition = 1
            addChild(brownBalloon)
            let moveAction = moveUpAnimation(size.height + 500, 4.0)
            let block = SKAction.run{
                brownBalloon = self.newBalloon(node: brownBalloon, balloon: .brown)
            }
            let sequence = SKAction.sequence([moveAction, block])
            let repeatForever = SKAction.repeatForever(sequence)
            brownBalloon.run(repeatForever)
        }
    }
    
    func setupGraph(){
        let pinkGraph = SKSpriteNode(imageNamed: "pinkgraph1")
        pinkGraph.name = "pinkGraph"
        pinkGraph.position = CGPoint(x: size.width/2 - 50, y: size.height/2)
        addChild(pinkGraph)
        pinkGraph.alpha = 0
        pinkGraph.xScale = 1.5
        pinkGraph.yScale = 1.5
        
        let graphLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 10, weight: .light).fontName)
        graphLabel.text = "   Woman in\napple(under 30)"
        graphLabel.fontSize = 8
        graphLabel.fontColor = .black
        graphLabel.name = "graphLabel"
        graphLabel.numberOfLines = 2
        graphLabel.position = CGPoint(x: pinkGraph.frame.maxX - 10, y: pinkGraph.frame.minY - 30)
        addChild(graphLabel)
        graphLabel.alpha = 0
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let femaleLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 10, weight: .light).fontName)
        femaleLabel.text = "Female\nrepresentation\nis steadily\nincreasing"
        let attributedText = NSMutableAttributedString.init(string: femaleLabel.text!)
        attributedText.setAttributes([NSAttributedStringKey.paragraphStyle: paragraph, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .light)], range: NSMakeRange(0, (femaleLabel.text?.count)!))
        femaleLabel.attributedText = attributedText
        femaleLabel.name = "femaleLabel"
        femaleLabel.fontColor = .black
        femaleLabel.fontSize = 20
        femaleLabel.position = CGPoint(x: pinkGraph.frame.maxX + 70, y: graphLabel.position.y + 60)
        femaleLabel.numberOfLines = 4
        addChild(femaleLabel)
        femaleLabel.alpha = 0
        
        let arrowNode = SKSpriteNode(imageNamed: "pinkarrow")
        arrowNode.name = "arrowNode"
        arrowNode.position = CGPoint(x: femaleLabel.position.x, y: femaleLabel.frame.minY - 15)
        addChild(arrowNode)
        arrowNode.alpha = 0
        
        let femalePercentLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        femalePercentLabel.text = "31%"
        femalePercentLabel.name = "femalePercentLabel"
        femalePercentLabel.fontColor = .black
        femalePercentLabel.fontSize = 16
        femalePercentLabel.position = CGPoint(x: arrowNode.position.x + 30, y: arrowNode.position.y - 10)
        addChild(femalePercentLabel)
        femalePercentLabel.alpha = 0
    }
    
    func setupCircle(){
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let minoriesLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        minoriesLabel.text = "From July 2016 to July 2017\n50% of apple's new\nhires were from historically\nunderrepresented groups\nin tech"
        let attributedText = NSMutableAttributedString.init(string: minoriesLabel.text!)
        attributedText.setAttributes([NSAttributedStringKey.paragraphStyle: paragraph, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: .light)], range: NSMakeRange(0, (minoriesLabel.text?.count)!))
        minoriesLabel.attributedText = attributedText
        minoriesLabel.name = "minoriesLabel"
        minoriesLabel.fontColor = .black
        minoriesLabel.fontSize = 18
        minoriesLabel.numberOfLines = 5
        minoriesLabel.position = CGPoint(x: size.width/2, y: size.height * 0.15)
        
        let percentLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .bold).fontName)
        percentLabel.text = "0%"
        percentLabel.name = "percentLabel"
        percentLabel.position = CGPoint(x: size.width/2, y: size.height * 0.6)
        percentLabel.fontColor = .black
        percentLabel.fontSize = 28
        
        let customBlue = UIColor(red: 114/255, green: 131/255, blue: 191/255, alpha: 1.0)
        addCircleView(x: size.width * 0.5 - 57, y: size.height * 0.23, color: customBlue, alpha: 0)
        
        addChild(minoriesLabel)
        addChild(percentLabel)
        minoriesLabel.alpha = 0
        percentLabel.alpha = 0
    }
    
    func setupFlag(){
        let flagNode = SKSpriteNode(imageNamed: "flag")
        flagNode.name = "flagNode"
        flagNode.position = CGPoint(x: size.width/2, y: size.height * 0.6)
        addChild(flagNode)
        flagNode.alpha = 0
        
        let flagTitle = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 8, weight: .bold).fontName)
        flagTitle.text = "LGBTQ rights are human rights"
        flagTitle.fontColor = .black
        flagTitle.fontSize = 18
        flagTitle.name = "flagTitle"
        flagTitle.position = CGPoint(x: flagNode.position.x, y: flagNode.frame.minY - 30)
        addChild(flagTitle)
        flagTitle.alpha = 0
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let flagText = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 4, weight: .light).fontName)
        flagText.text = "For 15 consecutive years apple had a\nperfect score on Human Rights\nCampaign Corporate Equality Index"
        let attributedText = NSMutableAttributedString.init(string: flagText.text!)
        attributedText.setAttributes([NSAttributedStringKey.paragraphStyle: paragraph, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: .light)], range: NSMakeRange(0, (flagText.text?.count)!))
        flagText.attributedText = attributedText
        flagText.name = "flagText"
        flagText.position = CGPoint(x: flagNode.position.x, y: flagTitle.frame.minY - 60)
        flagText.fontSize = 14
        flagText.numberOfLines = 3
        flagText.fontColor = .black
        addChild(flagText)
        flagText.alpha = 0
    }
}
