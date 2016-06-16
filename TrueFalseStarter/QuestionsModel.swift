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
        ["Question": "This was the only US President to serve more than two consecutive terms.", "Answer": "Franklin D. Roosevelt", "Option2":"George Washington","Option3":"Woodrow Wilsdon","Option4":"Andrew Jack"],
        ["Question": "Which of the following countries has the most residents?", "Answer": "Nigeria", "Option2":"Russia","Option3":"Iran","Option4":"Vietnam"],
        ["Question": "In what year was the United Nations founded?", "Answer": "1945","Option2":"1918","Option3":"1919","Option4":"1954"],
        ["Question": "The Titanic departed from the United Kingdom, where was it supposed to arrive?", "Answer": "New York City","Option2":"Paris","Option3":"Washington D.C.","Option4":"Boston"],
        ["Question": "Which nation produces the most oil?", "Answer": "Canada","Option2":"Iran","Option3":"Iraq","Option4":"Brazil"],
        ["Question": "Which country has most recently won consecutive World Cups in Soccer?", "Answer": "Brazil","Option2":"Italy","Option3":"Argetina","Option4":"Spain"],
        ["Question": "Which of the following rivers is longest?", "Answer": "Mississippi","Option2":"Yangtze","Option3":"Congo","Option4":"Mekong"],
        ["Question": "Which city is the oldest?", "Answer": "Mexico City","Option2":"Cape Town","Option3":"San Juan","Option4":"Sydney"],
        ["Question": "Which country was the first to allow women to vote in national elections?", "Answer": "Poland","Option2":"United States","Option3":"Sweden","Option4":"Senegal"],
        ["Question": "Which of these countries won the most medals in the 2012 Summer Games?", "Answer": "Great Britian","Option2":"France","Option3":"Germany","Option4":"Japan"]
    ]
    
    func getRandomQuestion() -> Dictionary<String,String>{
        let randomNumber = GKRandomSource.sharedRandom().nextIntWithUpperBound(triviaQuestions.count)
        return triviaQuestions[randomNumber]
    }


}

