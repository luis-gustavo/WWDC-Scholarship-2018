//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

import AVFoundation
import AudioToolbox
import SpriteKit


let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 667, height: 375))
let scene = EnviromentMenuScene(size: CGSize(width: 667, height: 375))
scene.scaleMode = .aspectFill

// Present the scene
sceneView.presentScene(scene)

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
