//
//  prompts.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 4/7/24.
//

import Foundation

class prompts{
    
    let prompts: [String] = [
        "What do you know to be true that you didn’t know a year ago?",
        "When do you feel most in tune with yourself?", "What three things can you change to live up to your values?",
        "What do you like about your personality? What don’t you like?",
        "Explore an opinion you had in the past that has since changed. What led you to that change in opinion?", "What emotions are you holding onto?",
        "Is there an emotion that you constantly feel and cannot escape? What makes it inescapable?",
        "Pick an emotion. Why are you feeling this way?",
        "How can you detach your own feelings from the actions of others?",
        "What emotions are you currently feeling in this moment? Explore each one and why you’re feeling it",
        "Identify situations or circumstances that follow with an intense negative emotion. What makes this situation trigger this emotion? Do the same for a positive emotion", "What are your strengths in a relationship?",
        "What do you value most out of a relationship?",
        "How would you rate your communication skills in your relationships? What are some ways they can be improved?",
        "How do you typically handle disagreements or confrontations? Are these strategies successful? If not what can be changed and improved upon?",
        "What are some boundaries that have been established in a relationship? How did you communicate your need for a boundary? Was it taken well? If not, what could you have done better if possible?",
        "What does trusting someone mean to you? How can you further build or maintain it?",
        "Describe someone you find yourself thinking of very often. Why do you often think of this person?", "What new skill or knowledge have you acquired recently that you find valuable?",
        "Reflect on a moment when you felt completely at peace with yourself. What were you doing?",
        "In what ways do your actions align with your core beliefs? How can you strengthen this alignment?",
        "What aspects of your personality do you admire? What aspects would you like to work on?",
        "Recall a belief you held strongly in the past but now question. What sparked this shift in perspective?",
        "Think about a recent situation that stirred up strong emotions in you. What were these emotions, and what triggered them?",
        "Do you find yourself constantly grappling with a specific emotion? What patterns or triggers contribute to its persistence?",
        "Choose an emotion you've been experiencing lately. What events or thoughts have contributed to this emotional state?",
        "Reflect on a time when you successfully maintained emotional detachment from a challenging situation. What strategies did you use?",
        "List the emotions you're currently experiencing. Reflect on the underlying reasons for each emotion and how they're influencing your thoughts and actions.",
        "Identify situations that consistently evoke feelings of joy or satisfaction in you. What aspects of these situations contribute to your positive emotions?",
        "What qualities do you bring to your relationships that enhance them?",
        "What fundamental qualities do you seek in your relationships and why?",
        "Consider how effectively you express yourself in your relationships. What communication habits could you refine or improve upon?",
        "Reflect on your typical approach to resolving conflicts in relationships. Are there alternative strategies you could explore?",
        "Describe a boundary you've set in a relationship and how it has positively impacted your well-being. How did you communicate this boundary?",
        "Define what trust means to you in the context of relationships. How do you nurture and maintain trust in your connections?",
        "Think about a person you admire deeply. What traits or actions of theirs make them worthy of your admiration?",
        "Describe a recurring thought or memory that frequently occupies your mind. What significance does it hold for you?"
    ]
    
    func getRandomPrompt(from strings: [String]) -> String? {
        guard !strings.isEmpty else { return nil }
        let randomIndex = Int.random(in: 0..<strings.count)
        return strings[randomIndex]
    }

    
}
