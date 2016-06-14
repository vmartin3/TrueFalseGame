//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    @IBOutlet weak var choice3: UIButton!
    @IBOutlet weak var choice4: UIButton!
    
    @IBAction func choiceOneSelected(sender: AnyObject) {
    }
    @IBAction func choiceTwoSelected(sender: AnyObject) {
    }
    @IBAction func choiceThreeSelected(sender: AnyObject) {
    }
    @IBAction func choiceFourSelected(sender: AnyObject) {
    }
    

    @IBOutlet weak var playAgainButton: UIButton!
    var indexOfSelectedQuestion: Int = 0
    var choices: [UIButton] = []
    var usedQuestions: [Int] = []
    var totalNumOfQuestionsUsed = 0
    var settings = GameSettingsModel()
    let questionSet = QuestionsModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        choices = [choice1,choice2, choice3, choice4]
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(questionSet.triviaQuestions.count)
        var questionDictionary = [String:String]()
        
        totalNumOfQuestionsUsed += 1
        print(usedQuestions)
        print("QUESTION SELECTED: \(indexOfSelectedQuestion)")
        
        while usedQuestions.contains(indexOfSelectedQuestion){
            print("THIS QUESTION WAS USED ALREADY GETTING A NEW ONE")
           indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(questionSet.triviaQuestions.count)
            print("NEW QUESTION IS NOW \(indexOfSelectedQuestion)")
            if (totalNumOfQuestionsUsed == 1 || totalNumOfQuestionsUsed == questionSet.triviaQuestions.count)
            {
                print("THIS IS THE FIRST QUESTION")
                questionDictionary = questionSet.triviaQuestions[indexOfSelectedQuestion]
                break
            }
        }
        usedQuestions.append(indexOfSelectedQuestion)
        questionDictionary = questionSet.triviaQuestions[indexOfSelectedQuestion]
        questionField.text = questionDictionary["Question"]
        playAgainButton.hidden = true
    }


    
    func displayScore() {
        // Hide the answer buttons
        for choice in choices{
            choice.hidden = true
        }
        
        // Display play again button
        playAgainButton.hidden = false
        
        questionField.text = "Way to go!\nYou got \(settings.correctQuestions) out of \(settings.questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        settings.questionsAsked += 1
        
        let selectedQuestionDict = questionSet.triviaQuestions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict["Answer"]
        
        if (sender === choice1 &&  correctAnswer == "True") || (sender === choice2 && correctAnswer == "False") {
            settings.correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if settings.questionsAsked == settings.questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        for choice in choices{
          choice.hidden = false
        }
        
        settings.questionsAsked = 0
        settings.correctQuestions = 0
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &settings.gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(settings.gameSound)
    }
}

