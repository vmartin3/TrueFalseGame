//
//  QuestionsModel.swift
//  TrueFalseStarter
//
//  Created by Vernon G Martin on 6/14/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import GameKit

struct QuestionsModel {
    let triviaQuestions: [[String : String]] = [
        ["Question": "This was the only US President to serve more than two consecutive terms.", "Answer": "Franklin D. Roosevelt"],
        ["Question": "Which of the following countries has the most residents?", "Answer": "Nigeria"],
        ["Question": "In what year was the United Nations founded?", "Answer": "1945"],
        ["Question": "The Titanic departed from the United Kingdom, where was it supposed to arrive?", "Answer": "New York City"],
        ["Question": "Which nation produces the most oil?", "Answer": "Canada"],
        ["Question": "Which country has most recently won consecutive World Cups in Soccer?", "Answer": "Brazil"],
        ["Question": "Which of the following rivers is longest?", "Answer": "Mississippi"],
        ["Question": "Which city is the oldest?", "Answer": "Mexico City"],
        ["Question": "Which country was the first to allow women to vote in national elections?", "Answer": "Poland"],
        ["Question": "Which city is the oldest?", "Answer": "Mexico City"],
        ["Question": "Which of these countries won the most medals in the 2012 Summer Games?", "Answer": "Great Britian"]
    ]
    
    func getRandomQuestion() -> Dictionary<String,String>{
        let randomNumber = GKRandomSource.sharedRandom().nextIntWithUpperBound(triviaQuestions.count)
        return triviaQuestions[randomNumber]
    }


}

