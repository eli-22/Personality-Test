//
//  ResultVC.swift
//  PersonalityTest
//
//  Created by Elise on 9/25/22.
//

import UIKit

class ResultVC: UIViewController {

    var responses: [Answer]!
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tallyResults()
    }
    
    func tallyResults() {
        var answerFrequency: [CountryType:Int] = [:]
    
        let responseTypes = responses.map { $0.type }
        print("responseTypes: \n\(responseTypes)")
        
        for response in responseTypes {
            answerFrequency[response] = (answerFrequency[response] ?? 0) + 1
            // CountryType is key               // sets value
            // If the type doesn't exist in the dictionary, set its value to 0 and then increment it by 1
            // If it already exists, just increment it by 1.
            
            print("answerFrequency[\(response)]: \(answerFrequency[response] ?? -1)")
        }
        
        // $0.1 current element value, $1.1 next element value
        // Sort dictionary based on values in descending order.
        // Then get the key of first element (.first!.key) which is an enum type.
        
        let mostCommonAnswer = answerFrequency.sorted { $0.1 > $1.1 }.first!.key
        print("mostCommonAnswer: \(mostCommonAnswer)")
        
    
    // Force unwrap the first element key which is an enum case: .argentina, .thailand, .japan or .spain.
    // Get the rawValue assigned to that case (which is an emoji).
        
        resultAnswerLabel.text = "You should visit \(mostCommonAnswer.rawValue)!"
        print("You should visit \(mostCommonAnswer.rawValue)!")
    
    // Set label by most common element in array
        resultDescription.text = mostCommonAnswer.description
        }
    }
