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
    var pickedQuestion: Question = trivia[0]
    var randomQuestionPick = 0
    var timer = Timer()
    var seconds = 30
    var shuffledQuestions = [Question]()
    var questionIndex = 0
    
    var rightSound: SystemSoundID = 0
    var wrongSound: SystemSoundID = 0
    var jeopardySound: SystemSoundID = 0

    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var exitGameButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRightAnswerSound()
        loadWrongAnswerSound()
        randomQuestionArray()
        displayQuestion()
        playAgainButton.isHidden = true
        timerLabel.isHidden = true
        correctLabel.isHidden = true
        exitGameButton.isHidden = true
        startGame()
    }

        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // This function shuffles the array each time the game is played to ensure randomness
    func randomQuestionArray() {
        shuffledQuestions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: trivia) as! [Question]
    }
    // This function takes the question and extracts the info and displays it for the user
    func displayQuestion() {
        
        pickedQuestion = shuffledQuestions[questionIndex]
        questionField.text = pickedQuestion.question
        currentAnswer = pickedQuestion.rightAnswer
        
        answerSelections = pickedQuestion.answers
        
        // this loop assigns the title for each button based on the answer choices
        for i in 0..<answerSelections.count {
            answerButtons[i].setTitle(answerSelections[i], for: UIControlState.normal)
        }
    }

    // This function checks to see if the button pressed is the correct answer
    @IBAction func checkAnswer(_ sender: UIButton) {
        let tag = sender.tag
    // If the answer is correct, the index is changed and the next question is displayed.  The correct answer count is updated
            if tag == currentAnswer {
                questionIndex += 1
                correctQuestions += 1
                playRightAnswerSound()
                displayQuestion()
    // if the answer is incorrect, the correct answer is highlighted during a brief delay
            } else {
                questionIndex += 1
                playWrongAnswerSound()
                answerButtons[currentAnswer].backgroundColor = UIColor.red
                loadNextQuestionWithDelay(seconds: 1)
            }
        }
    // This is the timer function used to keep track of the game
    func startGame() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
    }

    func updateTimer() {
        
        seconds -= 1
        timerLabel.text = String(seconds)
        // This is the logic for the "lightning round"
        if (seconds <= 15) {
            timerLabel.isHidden = false
            
            changeButtonTint(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
        
        if seconds == 0 {
            correctLabel.text = "Correct: \(correctQuestions)"
            correctLabel.isHidden = false
            timerLabel.isHidden = true
            exitGameButton.isHidden = false
            playAgainButton.isHidden = false
            timer.invalidate()
        }
    }
    // This function resets the game if the user presses the "Play Again" button
    @IBAction func playAgain() {
        randomQuestionArray()
        questionIndex = 0
        correctQuestions = 0
        seconds = 30
        displayQuestion()
        playAgainButton.isHidden = true
        correctLabel.isHidden = true
        exitGameButton.isHidden = true
        changeButtonTint(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        startGame()
    }
    // This function dismisses the view controller and takes the user back to the opening view
    @IBAction func exitGame() {
        self.dismiss(animated: true, completion: nil)
    }
    // This function is used to change the background color of the correct answer if an incorrect answer is chosen
    func resetButtons() {
        for i in 0..<answerSelections.count {
            answerButtons[i].backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
        }
    }

    
    // MARK: Helper Methods
    
    func loadNextQuestionWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.resetButtons()
            self.displayQuestion()
        }
    }
    
    
    // This method allows me to change the tint color of the buttons in "lightning mode" and then back to white again
    func changeButtonTint(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        for i in 0..<answerSelections.count {
            answerButtons[i].tintColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
    
    // These functions are used to load the sounds
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
    
    // These functions are used to play the sounds
    func playRightAnswerSound() {
        AudioServicesPlaySystemSound(rightSound)
    }
    
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongSound)
    }
}

