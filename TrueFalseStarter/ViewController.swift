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
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var currentQuestion: Question = trivia[0]
    var answerSelections: [String] = []
    var currentAnswer = 0
    var usedQuestions: [Int] = []
    
    var gameSound: SystemSoundID = 0
    
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // loadGameStartSound()
        // Start game
        // playGameStartSound()
        displayQuestion()
        print(correctQuestions)
    }

        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func randomQuestionPicker() -> Int {
        let randomQuestionPick = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
        
        return randomQuestionPick
    }
    
    func displayQuestion() {
        
        indexOfSelectedQuestion = randomQuestionPicker()
        currentQuestion = trivia[indexOfSelectedQuestion]
        questionField.text = currentQuestion.question
        currentAnswer = currentQuestion.rightAnswer
        
        answerSelections = currentQuestion.answers
        
        for i in 0..<answerSelections.count {
            answerButtons[i].setTitle(answerSelections[i], for: UIControlState.normal)
        }
    }
    
    func displayScore() {
        // Hide the answer buttons
        
        // Display play again button
        playAgainButton.isHidden = false
        
    }
    
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        let tag = sender.tag
    
            if tag == currentAnswer {
            correctQuestions += 1
                
            } else {
                print("That is not correct")
            }
        }
    }
    
/*
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestionDict = trivia[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.rightAnswer
        
        if (sender === trueButton &&  correctAnswer == "True") || (sender === falseButton && correctAnswer == "False") {
            correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }

    func nextRound() {

    }
    
    @IBAction func playAgain() {

    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}
*/
