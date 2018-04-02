//
//  AudioManager.swift
//  wwdcWinningProject
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 31/03/18.
//  Copyright © 2018 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import AVFoundation
import AudioToolbox
import SpriteKit

enum SFXType: Int {
    case ballo = 0, pickingGold, reward, pickingRock, gameOver, win, gainStar, clawMovingUp, pauseGame, unPauseGame, explosion, boom, tap
    
    var SFXNames: String {
        let SFXNames = ["BalloonPop.mp3"]
        return SFXNames[rawValue]
    }
}

func playSound2DAction(_ sfx: SFXType) -> SKAction{
    return SKAction.playSoundFileNamed(sfx.SFXNames, waitForCompletion: true)
}
