//
//  QuestionsModel.swift
//  TrueFalseStarter
//
//  Created by Vernon G Martin on 6/14/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import GameKit

var usedQuestions: [Int] = []

struct QuestionsModel {
    let question: String
    let answer: String
    let choice2: String
    let choice3: String
    let choice4: String
    
    func getRandomQuestion(randomNumber: Int) -> String {
        let options = [self.answer,self.choice2,self.choice3,self.choice4]
        return (options[randomNumber])
    }
}

let question1 = QuestionsModel(question: "This was the only US President to serve more than two consecutive terms.", answer: "Franklin D. Roosevelt", choice2: "George Washington", choice3: "Woodrow Wilsdon", choice4: "Andrew Jack")
let question2 = QuestionsModel(question: "Which of the following countries has the most residents?", answer: "Nigeria", choice2: "Russia", choice3: "Iran", choice4: "Vietnam")
let question3 = QuestionsModel(question: "In what year was the United Nations founded?", answer: "1945", choice2: "1918", choice3: "1919", choice4: "1954")
let question4 = QuestionsModel(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", answer: "New York City", choice2: "Paris", choice3: "Washington D.C.", choice4: "Boston")
let question5 = QuestionsModel(question: "Which nation produces the most oil?", answer: "Canada", choice2: "Iran", choice3: "Iraq", choice4: "Brazil")
let question6 = QuestionsModel(question: "Which country has most recently won consecutive World Cups in Soccer?", answer: "Brazil", choice2: "Italy", choice3: "Argetina", choice4: "Spain")
let question7 = QuestionsModel(question: "Which of the following rivers is longest?", answer: "Mississippi", choice2: "Yangtze", choice3: "Congo", choice4: "Mekong")
let question8 = QuestionsModel(question: "Which city is the oldest?", answer: "Mexico City", choice2: "Cape Town", choice3: "San Juan", choice4: "Sydney")
let question9 = QuestionsModel(question: "Which country was the first to allow women to vote in national elections?", answer: "Poland", choice2: "United States", choice3: "Sweden", choice4: "Senegal")
let question10 = QuestionsModel(question: "Which of these countries won the most medals in the 2012 Summer Games?", answer: "Great Britian", choice2: "France", choice3: "Germany", choice4: "Japan")

let triviaQuestions: [QuestionsModel] = [question1,question2,question3,question4,question5,question6,question7,question8,question9,question10]

