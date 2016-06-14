//
//  GameSettingsModel.swift
//  TrueFalseStarter
//
//  Created by Vernon G Martin on 6/14/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import AudioToolbox

struct GameSettingsModel {
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var gameSound: SystemSoundID = 0
}