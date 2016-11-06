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
    var answerSelections: [String] = []
    var currentAnswer = 0
    var usedQuestions = Set<Int>()
    var pickedQuestion: Question = trivia[0]
    var randomQuestionPick = 0
    var timer = Timer()
    var seconds = 20
    
    var gameSound: SystemSoundID = 0
    var rightSound: SystemSoundID = 0
    var wrongSound: SystemSoundID = 0
    
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        loadRightAnswerSound()
        loadWrongAnswerSound()
        // Start game
        // playGameStartSound()
        randomQuestion()
        displayQuestion()
        print(correctQuestions)
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func randomQuestion() {
        
        for i in 0..<usedQuestions.count {
            repeat {
                randomQuestionPick = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
            } while i == randomQuestionPick
            pickedQuestion = trivia[randomQuestionPick]
        }
    }

    func displayQuestion() {

        questionField.text = pickedQuestion.question
        currentAnswer = pickedQuestion.rightAnswer
        
        answerSelections = pickedQuestion.answers
        
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
                
                usedQuestions.insert(randomQuestionPick)
                playRightAnswerSound()
                randomQuestion()
                displayQuestion()
                print(usedQuestions)
                
            } else {
                playWrongAnswerSound()
                print("Wrong")
            }
        }
    
    func startGame() {
        timer = Timer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }

    func updateTimer() {
        seconds -= 1
    }
    


    @IBAction func playAgain() {

    }
    
    @IBAction func exitGame() {
        self.dismiss(animated: true, completion: nil)
    }


    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
           // self.nextRound()
        }
    }

    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func loadRightAnswerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "Right", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &rightSound)
    }
    
    func loadWrongAnswerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "Wrong", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &wrongSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func playRightAnswerSound() {
        AudioServicesPlaySystemSound(rightSound)
    }
    
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongSound)
    }
}

