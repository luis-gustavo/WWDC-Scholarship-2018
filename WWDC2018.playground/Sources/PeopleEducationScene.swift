//
//  PeopleEducationScene.swift
//  wwdcWinningProject
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 30/03/18.
//  Copyright © 2018 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import SpriteKit

enum Coordinate{
    case LeftUp
    case RightUp
    case RightDown
    case LeftDown
    case LeftUpOpposite
    case RightUpOpposite
    case RightDownOpposite
    case LeftDownOpposite
}

class PeopleEducationScene: SKScene{
    
    ///MARK: - Propertys
    let backgroundSceneColor = UIColor(red: 197/255, green: 240/255, blue: 164/255, alpha: 1.0)
    var numberOfClicks = 0
    
    ///MARK: - didMove
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = backgroundSceneColor
        setupScene()
    }
    
    ///MARK: - Methods
    func scaleAction() -> SKAction{
        let scaleUp = SKAction.scale(to: 1.5, duration: 1.0)
        let scaleDown = SKAction.scale(to: 1.0, duration: 1.0)
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        let repeatForever = SKAction.repeatForever(sequence)
        return repeatForever
    }
    
    func generatePathAction(coordinate: Coordinate) -> SKAction{
        switch coordinate {
        case .LeftUp:
            let bezierPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 120), radius: 120, startAngle: (3 * .pi)/2, endAngle: .pi, clockwise: false)
            return SKAction.follow(bezierPath.cgPath, asOffset: true, orientToPath: true, duration: 1.0)
        case .LeftDown:
            let bezierPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: -120), radius: 120, startAngle: .pi/2, endAngle: .pi, clockwise: true)
            return SKAction.follow(bezierPath.cgPath, asOffset: true, orientToPath: true, duration: 1.0)
        case .LeftUpOpposite:
            let bezierPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 120), radius: 120, startAngle: (3 * .pi)/2, endAngle: .pi, clockwise: false)
            return SKAction.follow(bezierPath.cgPath, asOffset: true, orientToPath: true, duration: 1.0).reversed()
        case .LeftDownOpposite:
            let ipadNode = childNode(withName: "ipadNode")
            let bezierPath = UIBezierPath(arcCenter: CGPoint(x: (ipadNode?.position.x)!, y: (ipadNode?.position.y)! - 120), radius: 120, startAngle: .pi, endAngle: .pi/2, clockwise: false)
            return SKAction.follow(bezierPath.cgPath, asOffset: false, orientToPath: true, duration: 1.0)
        case .RightUp:
            let bezierPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 120), radius: 120, startAngle: (3 * .pi)/2, endAngle: 2 * .pi, clockwise: true)
            return SKAction.follow(bezierPath.cgPath, asOffset: true, orientToPath: true, duration: 1.0)
        case .RightDown:
            let bezierPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: -120), radius: 120, startAngle: .pi/2, endAngle: 2 * .pi, clockwise: false)
            return SKAction.follow(bezierPath.cgPath, asOffset: true, orientToPath: true, duration: 1.0)
        case .RightUpOpposite:
            let ipadNode = childNode(withName: "ipadNode")
            let bezierPath = UIBezierPath(arcCenter: CGPoint(x: (ipadNode?.position.x)!, y: (ipadNode?.position.y)! + 120), radius: 120, startAngle: 0, endAngle: 3 * .pi/2, clockwise: false)
            return SKAction.follow(bezierPath.cgPath, asOffset: false, orientToPath: true, duration: 1.0)
        case .RightDownOpposite:
            let bezierPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: -120), radius: 120, startAngle: .pi/2, endAngle: 2 * .pi, clockwise: false)
            return SKAction.follow(bezierPath.cgPath, asOffset: true, orientToPath: true, duration: 1.0).reversed()
        }
    }
    
    func updateTitleLabel(){
        let titleLabel = childNode(withName: "titleLabel") as? SKLabelNode
        if numberOfClicks == 1{
            titleLabel?.text = "Nice, keep going!"
        }else if numberOfClicks == 2{
            titleLabel?.text = "Keep touching to discover more!"
        }else if numberOfClicks == 3{
            titleLabel?.text = "Just one more!"
        }else{
            titleLabel?.text = "Awesome!"
        }
    }
    
    func actionForClick(){
        if numberOfClicks == 1{
            setupPhotography()
        }else if numberOfClicks == 2{
            setupMusic()
        }else if numberOfClicks == 3{
            setupVideo()
        }else if numberOfClicks == 4{
            let ipadNode = childNode(withName: "ipadNode")
            ipadNode?.removeAllActions()
            setupDrawing()
            run(.wait(forDuration: 4.0), completion: {
                self.removeAllNodes()
            })
        }else{
            //Do nothing
        }
    }
    
    func animateIpad(){
        let ipadNode = childNode(withName: "ipadNode")
        let titleBlock = SKAction.run {
            let titleLabel = self.childNode(withName: "titleLabel") as? SKLabelNode
            titleLabel?.text = "Creativity Matters"
        }
        
        let block = SKAction.run {
            let creativityLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            creativityLabel.text = "Helping students to develop and communicate ideas\nthrough video, photography, music, and drawing"
            let attributedText = NSMutableAttributedString.init(string: "Helping students to develop and communicate ideas\nthrough video, photography, music, and drawing")
            attributedText.setAttributes([NSAttributedStringKey.paragraphStyle: paragraph, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .light)], range: NSMakeRange(0, (creativityLabel.text?.count)!))
            creativityLabel.attributedText = attributedText
            creativityLabel.numberOfLines = 2
            creativityLabel.fontColor = .black
            creativityLabel.fontSize =  18
            creativityLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.2)
            self.addChild(creativityLabel)
            creativityLabel.alpha = 0
            creativityLabel.zPosition = 1
            creativityLabel.xScale = 0.2
            creativityLabel.yScale = 0.2
            
            let block = SKAction.run {
                creativityLabel.run(.group([.moveTo(y: self.size.height * 0.67, duration: 1.0), .scale(to: 1.0, duration: 1.0), .fadeAlpha(to: 1.0, duration: 1.0)]))
            }
            creativityLabel.run(titleBlock)
            self.run(block)
        }
        
        let secondBlock = SKAction.run {
            let label = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
            label.text = "Designed with the help of educators and creative professionals"
            label.fontSize = 18
            label.fontColor = .black
            label.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.2)
            label.zPosition = 1
            label.xScale = 0.2
            label.yScale = 0.2
            self.addChild(label)
            label.alpha = 0
            label.run(.group([.moveTo(y: self.size.height * 0.5, duration: 1.0), .scale(to: 1.0, duration: 1.0), .fadeAlpha(to: 1.0, duration: 1.0)]))
        }
        let thirdBlock = SKAction.run {
            let label = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
            label.text = "#EveryoneCanCreate"
            let ipadNode = self.childNode(withName: "ipadNode")
            label.position = CGPoint(x: self.size.width/2 - 3, y: (ipadNode?.frame.maxY)! + 5)
            label.fontColor = .black
            label.fontSize = 14
            self.addChild(label)
            label.alpha = 0
            label.run(.sequence([.wait(forDuration: 4.0), .fadeAlpha(to: 1.0, duration: 1.0), .wait(forDuration: 1.0)]), completion: {
                self.createNextButton()
            })
        }
        ipadNode?.run(.sequence([.moveTo(y: size.height * 0.2, duration: 1.0), block, .wait(forDuration: 6.0), secondBlock, thirdBlock]))
        
    }
    
    func createNextButton(){
        let nextButton = SKSpriteNode(imageNamed: "nextButton")
        nextButton.name = "nextButton"
        nextButton.position = CGPoint(x: self.size.width - 100, y: 25)

        self.addChild(nextButton)
    }
}

///Mark: - Touches methods extension
extension PeopleEducationScene{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchNode = atPoint(location)
            if touchNode.name == "nextButton"{
                let scene = PeopleEndingScene(size: size)
                scene.scaleMode = .aspectFill
                let transition = SKTransition.reveal(with: .left, duration: 1.0)
                view?.presentScene(scene, transition: transition)
            }else if touchNode.name == "ipadNode"{
                numberOfClicks += 1
                actionForClick()
            }else{
                //Do nothing
            }
        }
    }
}

///MARK: - Setup methods extension
extension PeopleEducationScene{
    func setupScene(){
        let titleLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        titleLabel.text = "Touch the ipad"
        titleLabel.name = "titleLabel"
        titleLabel.position = CGPoint(x: size.width/2, y: size.height - 30)
        titleLabel.fontColor = .black
        titleLabel.fontSize = 26
        addChild(titleLabel)
        
        let ipadNode = SKSpriteNode(imageNamed: "ipad")
        ipadNode.name = "ipadNode"
        ipadNode.position = CGPoint(x: size.width/2, y: size.height/2 - 30)
        addChild(ipadNode)
        ipadNode.run(scaleAction())
    }
    
    func setupPhotography(){
        let photographyNode = SKSpriteNode(imageNamed: "photography")
        photographyNode.name = "photographyNode"
        let ipadNode = childNode(withName: "ipadNode")
        photographyNode.position = (ipadNode?.position)!
        photographyNode.zPosition = 1
        addChild(photographyNode)
        
        let photographyLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        photographyLabel.text = "Photography"
        photographyLabel.name = "photographyLabel"
        photographyLabel.fontColor = .black
        photographyLabel.fontSize = 18
        photographyLabel.position = CGPoint(x: photographyNode.position.x + 195, y: photographyNode.position.y + 110)
        addChild(photographyLabel)
        photographyLabel.alpha = 0
        photographyLabel.run(.sequence([.wait(forDuration: 1.0), .fadeAlpha(to: 1.0, duration: 1.0)]) )
        
        let block = SKAction.run {
            self.updateTitleLabel()
        }
        photographyNode.run(.sequence([generatePathAction(coordinate: .RightUp), block]) )
    }
    
    func setupMusic(){
        let musicNode = SKSpriteNode(imageNamed: "music")
        musicNode.name = "musicNode"
        let ipadNode = childNode(withName: "ipadNode")
        musicNode.position = (ipadNode?.position)!
        musicNode.zPosition = 1
        addChild(musicNode)
        
        let musicLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        musicLabel.text = "Music"
        musicLabel.name = "musicLabel"
        musicLabel.fontColor = .black
        musicLabel.fontSize = 18
        musicLabel.position = CGPoint(x: musicNode.position.x - 165, y: musicNode.position.y + 110)
        addChild(musicLabel)
        musicLabel.alpha = 0
        musicLabel.run(.sequence([.wait(forDuration: 1.0), .fadeAlpha(to: 1.0, duration: 1.0)]) )
        
        let block = SKAction.run {
            self.updateTitleLabel()
        }
        musicNode.run(.sequence([generatePathAction(coordinate: .LeftUp), block]))
    }
    
    func setupVideo(){
        let videoNode = SKSpriteNode(imageNamed: "video")
        videoNode.name = "videoNode"
        let ipadNode = childNode(withName: "ipadNode")
        videoNode.position = (ipadNode?.position)!
        videoNode.zPosition = 1
        addChild(videoNode)
        
        let videoLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        videoLabel.text = "Video"
        videoLabel.name = "videoLabel"
        videoLabel.fontColor = .black
        videoLabel.fontSize = 18
        videoLabel.position = CGPoint(x: videoNode.position.x - 165, y: videoNode.position.y - 125)
        addChild(videoLabel)
        videoLabel.alpha = 0
        videoLabel.run(.sequence([.wait(forDuration: 1.0), .fadeAlpha(to: 1.0, duration: 1.0)]) )
        
        let block = SKAction.run {
            self.updateTitleLabel()
        }
        videoNode.run(.sequence([generatePathAction(coordinate: .LeftDown), block]))
    }
    
    func setupDrawing(){
        let drawingNode = SKSpriteNode(imageNamed: "drawing")
        drawingNode.name = "drawingNode"
        let ipadNode = childNode(withName: "ipadNode")
        drawingNode.position = (ipadNode?.position)!
        drawingNode.zPosition = 1
        addChild(drawingNode)
        
        let drawingLabel = SKLabelNode(fontNamed: UIFont.systemFont(ofSize: 20, weight: .light).fontName)
        drawingLabel.text = "Drawing"
        drawingLabel.name = "drawingLabel"
        drawingLabel.fontColor = .black
        drawingLabel.fontSize = 18
        drawingLabel.position = CGPoint(x: drawingNode.position.x + 180, y: drawingNode.position.y - 125)
        addChild(drawingLabel)
        drawingLabel.alpha = 0
        drawingLabel.run(.sequence([.wait(forDuration: 1.0), .fadeAlpha(to: 1.0, duration: 1.0)]))
        let block = SKAction.run {
            self.updateTitleLabel()
        }
        drawingNode.run(.sequence([generatePathAction(coordinate: .RightDown), block]) )
    }
    
    func removeAllNodes(){
        let drawingNode = childNode(withName: "drawingNode")
        let photographyNode = childNode(withName: "photographyNode")
        let videoNode = childNode(withName: "videoNode")
        let musicNode = childNode(withName: "musicNode")
        drawingNode?.run(.group([generatePathAction(coordinate: .RightDownOpposite), .fadeAlpha(to: 0.0, duration: 1.0)]) , completion:{
            drawingNode?.removeFromParent()
        })
        videoNode?.run(.group([generatePathAction(coordinate: .LeftDownOpposite), .fadeAlpha(to: 0.0, duration: 1.0)]) , completion:{
            videoNode?.removeFromParent()
        })
        photographyNode?.run(.group([generatePathAction(coordinate: .RightUpOpposite), .fadeAlpha(to: 0.0, duration: 1.0)]) , completion:{
            photographyNode?.removeFromParent()
        })
        musicNode?.run(.group([generatePathAction(coordinate: .LeftUpOpposite), .fadeAlpha(to: 0.0, duration: 1.0)]), completion:{
            musicNode?.removeFromParent()
        })
        
        let drawingLabel = childNode(withName: "drawingLabel")
        drawingLabel?.run(.fadeAlpha(to: 0.0, duration: 0.5), completion: {
            drawingLabel?.removeFromParent()
        })
        let videoLabel = childNode(withName: "videoLabel")
        videoLabel?.run(.fadeAlpha(to: 0.0, duration: 0.5), completion: {
            videoLabel?.removeFromParent()
        })
        let photographyLabel = childNode(withName: "photographyLabel")
        photographyLabel?.run(.fadeAlpha(to: 0.0, duration: 0.5), completion: {
            photographyLabel?.removeFromParent()
        })
        let musicLabel = childNode(withName: "musicLabel")
        musicLabel?.run(.fadeAlpha(to: 0.0, duration: 0.5), completion: {
            musicLabel?.removeFromParent()
        })
        
        run(.wait(forDuration: 1.5)) {
            self.animateIpad()
        }
    }
}
