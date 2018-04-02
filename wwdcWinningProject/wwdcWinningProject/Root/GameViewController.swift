//
//  GameViewController.swift
//  wwdcWinningProject
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/03/18.
//  Copyright © 2018 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as! SKView? {
            let scene = EnviromentMenuScene(size: view.frame.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
