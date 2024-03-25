//
//  textProcessing.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 3/25/24.
//

import Foundation

func preprocessText(_ text: String, stopwords: Set<String>) -> String {
    //splits the text into an array of substrings using whitespace
    //Stored in the token array
    var tokens = text.components(separatedBy: .whitespacesAndNewlines)
    
    //Remove o=punctuation and set to all lower case
    let punctuation = CharacterSet.punctuationCharacters
    tokens = tokens.map { token in
        //processedToken contains words that passed filtration
        var processedToken = token.trimmingCharacters(in: punctuation)
        //Checking to see if the lowercase version of the token is within the stop words
        if !stopwords.contains(processedToken.lowercased()) {
            return processedToken.lowercased()
        } else {
            return ""
        }
    }
    
    //joins all the tokens into a single string with a space seperation
    let processedText = tokens.joined(separator: " ")
    
    return processedText
}

func runExample() {
    let journalEntry = "Today was a beautiful day, full of sunshine and happiness!"
    let stopwords: Set<String> = ["a", "was", "of", "and", "the", "in", "to", "is"]

    let preprocessedEntry = preprocessText(journalEntry, stopwords: stopwords)
    print(preprocessedEntry)
}

//runExample()
