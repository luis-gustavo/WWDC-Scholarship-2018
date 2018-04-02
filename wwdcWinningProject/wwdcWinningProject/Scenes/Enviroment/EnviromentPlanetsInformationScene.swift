//
//  EnviromentPlanetsInformationScene.swift
//  wwdcWinningProject
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/03/18.
//  Copyright © 2018 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import SpriteKit
import UIKit

public class EnviromentPlanetsInformationScene: SKScene{
    
    ///MARK: - Inits
    override public init(size: CGSize) {
        recycleLabelPosition = CGPoint(x: size.width/2 + 75, y: size.height/2 - 80)
        arrowsPosition = CGPoint(x: size.width/2 - 150, y: size.height/2 - 15)
        iphonePosition = CGPoint(x: (arrowsPosition?.x)!, y: (arrowsPosition?.y)! - 20)
        super.init(size: size)
        backgroundColor = sceneBackgroundColor
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///MARK: - Propertys
    let sceneBackgroundColor = UIColor(red: 250/255, green: 255/255, blue: 184/255, alpha: 1.0)
    let grayColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.5)
    var selectedScene = 1
    var previousCarbonLabelPosition = CGPoint.zero
    let recycleLabelPosition: CGPoint?
    let arrowsPosition: CGPoint?
    let iphonePosition: CGPoint?
    var touchedIphone = false
    var thirdSceneFirstTime = false
    
    ///MARK: - didMove
    override public func didMove(to view: SKView) {
        super.didMove(to: view)
        
        setupAppleLogo()
        setupTitleLabel()
        setupEffectNode()
        setupPageController()
        setupGraphNode()
        setupSwipeRecognizers()
        createNextButton()
        setupSecondScene()
        setupThirdScene()
    }
    
    ///MARK: - Methods
    @objc func swipedRight(){
        if selectedScene == 2{
            bringGraphBack()
            selectedScene -= 1
            updatePageController(selectedScene: selectedScene)
            updateTitleLabel(selectedScene: selectedScene)
            removeSecondScene(left: false)
        }else if selectedScene == 3{
            
            selectedScene -= 1
            updatePageController(selectedScene: selectedScene)
            updateTitleLabel(selectedScene: selectedScene)
            let nextButton = childNode(withName: "nextButton")
            nextButton?.run(.fadeAlpha(to: 0.0, duration: 0.5), withKey: "nextButtonFadeAction")
            removeThirdScene()
            bringBackSecondScene()
        }else{
            //Do nothing
        }
    }
    
    @objc func swipeLeft(){
        if selectedScene == 1{
            removeGraph()
            selectedScene += 1
            updatePageController(selectedScene: selectedScene)
            updateTitleLabel(selectedScene: selectedScene)
            bringBackSecondScene()
        }else if selectedScene == 2{
            
            let nextButton = childNode(withName: "nextButton")
            nextButton?.run(fadeAction(), withKey: "nextButtonAction")
            selectedScene += 1
            updatePageController(selectedScene: selectedScene)
            updateTitleLabel(selectedScene: selectedScene)
            removeSecondScene(left: true)
            bringBackThirdScene()
        }else{
            //Do nothing
        }
    }
    
    func fadeAction(_ to: CGFloat = 1.0, _ duration: TimeInterval = 0.5) -> SKAction{
        let fadeAction = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
        return fadeAction
    }
    
    func createGraphAnimation() -> SKAction{
        let hydroTextures = [SKTexture(imageNamed: "graph2"), SKTexture(imageNamed: "graph3"), SKTexture(imageNamed: "graph4"), SKTexture(imageNamed: "graph5"), SKTexture(imageNamed: "graph6"), SKTexture(imageNamed: "graph7")]
        let animation = SKAction.animate(with: Array(hydroTextures[0...5]), timePerFrame: 1.0, resize: false, restore: false)
        let wait = SKAction.wait(forDuration: 0.25)
        let block = SKAction.run {
            let carbonEmissionLabel = self.childNode(withName: "carbonEmissionLabel")
            carbonEmissionLabel?.run(self.fadeAction(), withKey: "carbonEmissionLabelAction")
        }
        let sequence = SKAction.sequence([wait, animation, block])
        return sequence
    }
    
    func createNextButton(){
        let nextButton = SKSpriteNode(imageNamed: "nextButton")
        nextButton.name = "nextButton"
        nextButton.position = CGPoint(x: self.size.width - 100, y: 25)
        
        nextButton.alpha = 0
        self.addChild(nextButton)
    }
    
    func moveAction(_ x: CGFloat = -500, _ y: CGFloat = 10) -> SKAction{
        let moveLeft = SKAction.move(to: CGPoint(x: x, y: y), duration: 1.0)
        return moveLeft
    }
    
    func removeGraph(){
        let graphNode = childNode(withName: "graphNode")
        let graphBlock = SKAction.run {
            graphNode?.alpha = 0
        }
        graphNode?.run(.sequence([moveAction(-500, (graphNode?.position.y)!), graphBlock]), withKey: "graphNodeAction")
        
        let carbonEmissionLabel = childNode(withName: "carbonEmissionLabel")
        let labelBlock = SKAction.run {
            carbonEmissionLabel?.alpha = 0
        }
        carbonEmissionLabel?.run(.sequence([moveAction(-500, (carbonEmissionLabel?.position.y)!), labelBlock]), withKey: "carbonEmissionLabelAction")
    }
    
    func removeThirdScene(){
        let planetNode = childNode(withName: "planetNode")
        let planetNodeBlock = SKAction.run {
            planetNode?.alpha = 0
        }
        let finalLabel = childNode(withName: "finalLabel")
        let finalLabelBlock = SKAction.run {
            finalLabel?.alpha = 0
        }
        
        planetNode?.run(.sequence([moveAction(1500, (planetNode?.position.y)!), planetNodeBlock]), withKey: "planetNodeAction")
        finalLabel?.run(.sequence([moveAction(1500, (finalLabel?.position.y)!), finalLabelBlock]), withKey: "finalLabelAction")
    }
    
    func removeSecondScene(left: Bool){
        let recycleLabel = childNode(withName: "recycleLabel")
        let recycleLabelBlock = SKAction.run {
            recycleLabel?.alpha = 0
        }
        let recycleArrowsNode = childNode(withName: "recycleArrowsNode")
        let recycleArrowsNodeBlock = SKAction.run {
            recycleArrowsNode?.alpha = 0
        }
        let iphoneNode = childNode(withName: "iphoneNode")
        let iphoneNodeBlock = SKAction.run {
            iphoneNode?.alpha = 0
        }
        
        recycleLabel?.run(.sequence([moveAction(left == true ? -1500 : 1500, (recycleLabel?.position.y)!), recycleLabelBlock]), withKey: "recycleLabelAction")
        recycleArrowsNode?.run(.sequence([moveAction(left == true ? -1500 : 1500, (recycleArrowsNode?.position.y)!), recycleArrowsNodeBlock]), withKey: "recycleArrowsNodeAction")
        
        iphoneNode?.run(.sequence([moveAction(left == true ? -1500 : 1500, (iphoneNode?.position.y)!), iphoneNodeBlock]), withKey: "iphoneNodeAction")
    }
    
    func bringBackSecondScene(){
        let recycleLabel = childNode(withName: "recycleLabel")
        recycleLabel?.alpha = 1
        let recycleArrowsNode = childNode(withName: "recycleArrowsNode")
        recycleArrowsNode?.alpha = 1
        let iphoneNode = childNode(withName: "iphoneNode")
        iphoneNode?.alpha = 1
        
        recycleLabel?.run(moveAction((recycleLabelPosition?.x)!, (recycleLabelPosition?.y)!), withKey: "recycleLabelAction")
        
        !touchedIphone ?recycleArrowsNode?.run(.sequence([moveAction((arrowsPosition?.x)!, (arrowsPosition?.y)!), scaleAction()]), withKey: "recycleArrowsNodeAction") : recycleArrowsNode?.run(.sequence([moveAction((arrowsPosition?.x)!, (arrowsPosition?.y)!)]), withKey: "recycleArrowsNodeAction")
        
        !touchedIphone ? iphoneNode?.run(.sequence([moveAction((iphonePosition?.x)!, (iphonePosition?.y)!), scaleAction()]), withKey: "iphoneNodeAction") : iphoneNode?.run(.sequence([moveAction((iphonePosition?.x)!, (iphonePosition?.y)!)]), withKey: "iphoneNodeAction")
    }
    
    func bringBackThirdScene(){
        let planetNode = childNode(withName: "planetNode")
        let finalLabel = childNode(withName: "finalLabel")
        
        if !thirdSceneFirstTime {
            planetNode?.alpha = 1
            planetNode?.run(moveAction(size.width/2, size.height/2 + 25), withKey: "planetNodeAction")
            finalLabel?.run(.sequence([moveAction(size.width/2, size.height/2 - 100), .wait(forDuration: 1.0), fadeAction(1.0, 1.0)]), withKey: "finalLabelAction")
            thirdSceneFirstTime = !thirdSceneFirstTime
        }else{
            planetNode?.alpha = 1
            finalLabel?.alpha = 1
            planetNode?.run(moveAction(size.width/2, size.height/2 + 25), withKey: "planetNodeAction")
            finalLabel?.run(moveAction(size.width/2, size.height/2 - 120), withKey: "finalLabelAction")
        }
    }
    
    func bringGraphBack(){
        let graphNode = childNode(withName: "graphNode")
        graphNode?.alpha = 1
        let carbonEmissionLabel = childNode(withName: "carbonEmissionLabel")
        carbonEmissionLabel?.alpha = 1
        
        let graphBlock = SKAction.run {
            graphNode?.run(self.moveAction(self.size.width/2, self.size.height/2 - 30), withKey: "graphNodeAction")
        }
        let labelBlock = SKAction.run {
            
            carbonEmissionLabel?.run(self.moveAction(self.previousCarbonLabelPosition.x, self.previousCarbonLabelPosition.y), withKey: "carbonEmissionLabelAction")
        }
        run(.sequence([graphBlock, labelBlock]), withKey: "sceneAction")
        
    }
    
    func updatePageController(selectedScene: Int){
        let pageController = childNode(withName:"pageController") as? SKSpriteNode
        if selectedScene == 1{
            pageController?.texture = SKTexture(imageNamed: "pagecontroller1")
        }else if selectedScene == 2{
            pageController?.texture = SKTexture(imageNamed: "pagecontroller2")
        }else if selectedScene == 3{
            pageController?.texture = SKTexture(imageNamed: "pagecontroller3")
        }else{
            //Do nothing
        }
    }
    
    func updateTitleLabel(selectedScene: Int){
        let titleLabel = childNode(withName: "titleLabel") as? SKLabelNode
        if selectedScene == 1{
            titleLabel?.text = "Greater products and less enviroment impact"
        }else if selectedScene == 2{
            titleLabel?.text = "Innovation in every stage of it’s lyfecycle"
        }else if selectedScene == 3{
            titleLabel?.text = "Less of the planet and more of ourselves"
        }else{
            //Do nothing
        }
    }
    
    func scaleAction() -> SKAction{
        let scaleUp = SKAction.scale(to: 1.2, duration: 1.0)
        let scaleDown = SKAction.scale(to: 1.0, duration: 1.0)
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        let repeatForever = SKAction.repeatForever(sequence)
        return repeatForever
    }
    
    func rotateAction() -> SKAction{
        let rotationAction = SKAction.rotate(byAngle: -6.27, duration: 1.0)
        return rotationAction
    }
    
    func changeIphoneAction(){
        let iphoneNode = childNode(withName: "iphoneNode") as? SKSpriteNode
        let arrowsNode = childNode(withName: "recycleArrowsNode") as? SKSpriteNode
        arrowsNode?.run(rotateAction(), withKey: "recycleArrowsNodeAction")
        
        let block = SKAction.run {
            iphoneNode?.texture = SKTexture(imageNamed: "iphoneX")
        }
        
        iphoneNode?.run(.sequence([.fadeAlpha(to: 0.0, duration: 0.7), block, .fadeAlpha(to: 1.0, duration: 0.7)]), withKey: "iphoneNodeAction")
        
    }
    
    func haveTouchedIphone(){
        if !touchedIphone{
            changeIphoneAction()
            touchedIphone = !touchedIphone
        }else{
            //Do nothing
        }
    }
    
}

///Mark: - Touches methods extension
extension EnviromentPlanetsInformationScene{
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchNode = atPoint(location)
            
            if touchNode.name == "nextButton"{
                let scene = PeopleDiversityScene(size: size)
                scene.scaleMode = .aspectFill
                let transition = SKTransition.reveal(with: .left, duration: 1.0)
                view?.presentScene(scene, transition: transition)
            }else if touchNode.name == "iphoneNode" || touchNode.name == "recycleArrowsNode"{
                haveTouchedIphone()
            }else{
                //Do nothing
            }
        }
    }
    
}


///MARK: - Setup methods extension
extension EnviromentPlanetsInformationScene{
    func setupAppleLogo(){
        let appleLogoNode = SKSpriteNode(imageNamed: "applegreen")
        appleLogoNode.name = "appleLogoNode"
        appleLogoNode.position = CGPoint(x: size.width/2, y: size.height - 30)
        
        addChild(appleLogoNode)
    }
    
    func setupTitleLabel(){
        let titleLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        titleLabel.text = "Greater products and less enviroment impact"
        titleLabel.name = "titleLabel"
        titleLabel.fontColor = .black
        let appleLogoNodePosition = childNode(withName: "appleLogoNode")?.position
        titleLabel.position = CGPoint(x: (appleLogoNodePosition?.x)!, y: (appleLogoNodePosition?.y)! - 50)
        
        addChild(titleLabel)
    }
    
    func setupEffectNode(){
        let effectNode = SKEffectNode()
        effectNode.name = "effectNode"
        let  blur = CIFilter(name:"CIGaussianBlur",withInputParameters: ["inputRadius": 10.0]);
        effectNode.filter = blur;
        effectNode.shouldRasterize = true;
        effectNode.shouldEnableEffects = true;
        effectNode.position = CGPoint(x: size.width/2, y: size.height/2 - 20)
        addChild(effectNode)
        
        let grayRect = SKShapeNode(rectOf: CGSize(width: size.width, height: 200))
        grayRect.name = "grayRect"
        grayRect.fillColor = grayColor
        
        effectNode.addChild(grayRect)
    }
    
    func setupPageController(){
        let pageController = SKSpriteNode(imageNamed: "pagecontroller1")
        pageController.name = "pageController"
        pageController.position = CGPoint(x: size.width/2, y: 40)
        
        addChild(pageController)
    }
    
    func setupSwipeRecognizers(){
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(EnviromentPlanetsInformationScene.swipedRight))
        swipeRight.direction = .right
        view?.addGestureRecognizer(swipeRight)
        
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(EnviromentPlanetsInformationScene.swipeLeft))
        swipeLeft.direction = .left
        view?.addGestureRecognizer(swipeLeft)
    }
    
    func setupGraphNode(){
        let graphNode = SKSpriteNode(imageNamed: "graph1")
        graphNode.name = "graphNode"
        graphNode.position = CGPoint(x: size.width/2, y: size.height/2 - 30)
        
        let carbonEmissionLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        carbonEmissionLabel.text = "Apple's carbon emission/product(kg)"
        carbonEmissionLabel.name = "carbonEmissionLabel"
        carbonEmissionLabel.fontColor = .black
        carbonEmissionLabel.fontSize = 10
        carbonEmissionLabel.zPosition = 1
        
        addChild(graphNode)
        carbonEmissionLabel.position = CGPoint(x: graphNode.frame.maxX + 5, y: graphNode.frame.minY - 10)
        previousCarbonLabelPosition = carbonEmissionLabel.position
        carbonEmissionLabel.alpha = 0
        addChild(carbonEmissionLabel)
        
        graphNode.run(createGraphAnimation(), withKey: "graphNodeAction")
    }
    
    func setupSecondScene(){
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let recycleLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        recycleLabel.text = "With projects like Liam,\napple’s R&D project,\napple is working in\ncreating new products\nusing only recycled\nmaterials"
        let attributedText = NSMutableAttributedString.init(string: recycleLabel.text!)
        attributedText.setAttributes([NSAttributedStringKey.paragraphStyle: paragraph, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: .light)], range: NSMakeRange(0, (recycleLabel.text?.count)!))
        recycleLabel.attributedText = attributedText
        recycleLabel.position = CGPoint(x: 1500, y: size.height/2 - 78)
        recycleLabel.fontColor = .black
        recycleLabel.numberOfLines = 6
        recycleLabel.fontSize = 18
        recycleLabel.name = "recycleLabel"
        
        let recycleArrowsNode = SKSpriteNode(imageNamed: "recyclearrows")
        recycleArrowsNode.name = "recycleArrowsNode"
        recycleArrowsNode.position = CGPoint(x: 1500, y: size.height/2 - 15)
        
        let iphoneNode = SKSpriteNode(imageNamed: "iphone")
        iphoneNode.name = "iphoneNode"
        iphoneNode.position = CGPoint(x: 1500, y: recycleArrowsNode.position.y - 20)
        
        addChild(recycleLabel)
        addChild(recycleArrowsNode)
        addChild(iphoneNode)
    }
    
    func setupThirdScene(){
        let planetNode = SKSpriteNode(imageNamed: "planet")
        planetNode.name = "planetNode"
        planetNode.position = CGPoint(x: 1500, y: size.height/2 + 25)
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let finalLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        finalLabel.text = "Awesome! now you know some of apple's enviromental\npolicies!"
        let attributedText = NSMutableAttributedString.init(string: finalLabel.text!)
        attributedText.setAttributes([NSAttributedStringKey.paragraphStyle: paragraph, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: .light)], range: NSMakeRange(0, (finalLabel.text?.count)!))
        finalLabel.attributedText = attributedText
        finalLabel.name = "finalLabel"
        finalLabel.numberOfLines = 2
        finalLabel.fontColor = .black
        finalLabel.fontSize = 18
        finalLabel.position = CGPoint(x: 1500, y: size.height/2 - 100)
        
        addChild(planetNode)
        addChild(finalLabel)
        finalLabel.alpha = 0
    }
}
