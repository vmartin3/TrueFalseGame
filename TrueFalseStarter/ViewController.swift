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
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    @IBOutlet weak var choice3: UIButton!
    @IBOutlet weak var choice4: UIButton!
    
    @IBOutlet weak var timer: UILabel!
    let correctSoundURL =  NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("correct", ofType: "wav")!)
    let wrongSoundURL =  NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("wrong", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    var indexOfSelectedQuestion: Int = 0
    var choices: [UIButton] = []
    var usedQuestions: [Int] = []
    var usedOptions: [Int] = []
    var settings = GameSettingsModel()
    let questionSet = triviaQuestions
    var gameTimer = NSTimer()
    var timerCounter = 15
    

    override func viewDidLoad() {
        super.viewDidLoad()
        choices = [choice1,choice2, choice3, choice4]
        loadGameStartSound()
        
        // Start game
        playGameStartSound()
        displayQuestion()
        displayAnswerOptions()
        startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer(){
        //Starts the timer sets the decrement count to 1 and sets the text of the timer label
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timer.text = String ("Timer: \(timerCounter)")
    }
    
    func updateTimer(){
        //Decrements timer by count by 1
        timerCounter = timerCounter - 1
        timer.text = String("Timer: \(timerCounter)")
        
        //If timer runs out stop the timer and display the right answer
        if timerCounter == 0{
            stopTimer()
            setGameScreen(sound: audioPlayer2, setQuetionFieldText: "Sorry! You ran out of time the correct answer was ", setDelayTime: 3, isWrongAnswer: true)
            settings.questionsAsked += 1
        }
    }
    
    func stopTimer(){
        //Stops and resets timer ot 15 seconds
        gameTimer.invalidate()
        timerCounter = 15
        timer.text = String("Timer: \(timerCounter)")
    }
    
    func generateRandomNumber(upperBound upperBound:Int)->Int{
        //Creates and returns a random number
        let randomNumber = GKRandomSource.sharedRandom().nextIntWithUpperBound(upperBound)
        return randomNumber
    }
    
    func displayQuestion() {
        //Generates a random number to select a question that has not been used yet. If a question that has been
        //used is selected it will generate a new one until that is not the case
        indexOfSelectedQuestion = generateRandomNumber(upperBound: questionSet.count)
        while usedQuestions.contains(indexOfSelectedQuestion){
           indexOfSelectedQuestion = generateRandomNumber(upperBound: questionSet.count)
        }
        
        usedQuestions.append(indexOfSelectedQuestion)
        let questionDictionary = questionSet[indexOfSelectedQuestion]
        questionField.text = questionDictionary.question
        playAgainButton.hidden = true
    }
    
    func displayAnswerOptions(){
        let selectedQuestionDict = questionSet[indexOfSelectedQuestion]
        let options: [String] = ["answer","choice2","choice3","choice4"]
        var randomNumber = generateRandomNumber(upperBound: options.count)
        usedOptions.append(randomNumber)
        
        //Cycles through the number of choices in the choices array and randomly orders the choice options
        //on the choice buttons so that they are dynamically placed and not in the same spot every time
        for i in 0..<choices.count{
            choices[i].setTitle(selectedQuestionDict.getRandomQuestion(randomNumber), forState: UIControlState.Normal)
            randomNumber = generateRandomNumber(upperBound: options.count)
            
            //If an randomly selected option is already displayed on a choice button select a different one until
            //that is not the case or until all the choices have been used
            while usedOptions.contains(randomNumber)&&usedOptions.count != choices.count{
                randomNumber = generateRandomNumber(upperBound: options.count)
            }
            //Add used choices to the array
            usedOptions.append(randomNumber)
        }
        //Clear the used choices array for the next question
        usedOptions = []
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
        
        //If selected choice button text matches the correct answer text then display correct game screen if not display
        //the incorrect selection game screen
        if (sender.titleLabel!.text == getCorrectAnswer()) {
            stopTimer()
            setGameScreen(sound: audioPlayer, setQuetionFieldText: "Correct!", setDelayTime: 2, isWrongAnswer: false)
            settings.correctQuestions += 1
        } else {
            stopTimer()
            setGameScreen(sound: audioPlayer2, setQuetionFieldText: "Sorry! The correct answer was actually: ", setDelayTime: 3, isWrongAnswer: true)
        }
    }
    
    func nextRound() {
        if settings.questionsAsked == settings.questionsPerRound {
            // Game is over
            displayScore()
            timer.hidden = false
            timer.text = " "
        } else {
            // Continue game
            startTimer()
            displayQuestion()
            displayAnswerOptions()
        }
    }
    
    func setGameScreen(sound sound:AVAudioPlayer, setQuetionFieldText:String, setDelayTime:Int, isWrongAnswer: Bool){
        //Sets the game sound and text labels based on whether or not the correct or wrong answer was selected
        sound.play()
        if(isWrongAnswer == false){
        questionField.text = "\(setQuetionFieldText)"
        }else
        {
        questionField.text = "\(setQuetionFieldText) \(getCorrectAnswer())"
        }
        loadNextRoundWithDelay(seconds: setDelayTime)
    }
    
    func getCorrectAnswer()->String{
        //Gets the correct answer for selected question and returns it
        let selectedQuestionDict = questionSet[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.answer
        return correctAnswer
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        for choice in choices{
          choice.hidden = false
        }
        //Resets these fields
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
        
        do{
        try audioPlayer = AVAudioPlayer(contentsOfURL: correctSoundURL, fileTypeHint: nil)
        try audioPlayer2 = AVAudioPlayer(contentsOfURL: wrongSoundURL, fileTypeHint: nil)
        }catch{
            print("SOUND ERROR")
        }
        audioPlayer.prepareToPlay()
        audioPlayer2.prepareToPlay()
    }
    
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(settings.gameSound)
    }
}

