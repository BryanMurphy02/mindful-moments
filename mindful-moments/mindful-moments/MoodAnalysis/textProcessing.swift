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
    let journalEntry = "Today dawned with a crisp chill in the air, signaling the slow transition from winter's icy grip to the gentle embrace of spring. As I sipped my morning coffee, tendrils of steam curling upwards, I contemplated the promise of a new day. The streets outside echoed with the hurried footsteps of commuters, each lost in their own world of thoughts and ambitions. Yet, amidst the cacophony of city life, there exists a quiet sanctuary within the pages of my journal, where the clamor of the outside world fades into insignificance. In the solitude of my thoughts, I found refuge, pen in hand, poised to capture the fleeting moments that make life so precious. With each stroke of ink upon the blank canvas of my journal, I immortalize fragments of my existence, weaving them into a tapestry of memories that will endure the passage of time. Today, I reflected on the beauty of impermanence, recognizing that every sunrise brings with it the promise of new beginnings, and every sunset heralds the close of another chapter. In embracing the transience of life, I find liberation, for it is in letting go that we truly learn to live. As the day draws to a close and the sky is painted in hues of crimson and gold, I am reminded of the fleeting nature of time. And so, with gratitude in my heart and pen in hand, I bid adieu to today, knowing that tomorrow holds the promise of new adventures and untold wonders."
    let stopwords: Set<String> = [
        "a", "was", "of", "and", "the", "in", "to", "is",
            "I", "you", "he", "she", "it", "we", "they", "me", "him", "her", "them",
            "this", "that", "there", "here", "with", "for", "on", "at", "by", "from",
            "as", "or", "but", "not", "if", "when", "where", "how", "why", "which",
            "who", "whom", "whose",
            "have", "has", "had", "do", "does", "did", "will", "would", "can", "could",
            "should", "ought", "must", "might", "may", "into", "out", "up", "down",
            "over", "under", "between", "among", "through", "above", "below", "around",
            "before", "after", "underneath", "beside", "along", "while", "during",
            "against", "within", "without", "across", "beneath", "throughout", "towards",
            "upon", "unto", "am", "are", "being", "been", "being",
            "each", "every", "few", "more", "most", "other", "some", "such", "many",
            "own", "same", "so", "than", "too", "very", "only", "much", "less", "least",
            "just", "ever", "never", "always", "actually", "even", "already", "still",
            "almost", "about", "around", "above", "below", "behind", "besides", "between",
            "beyond", "except", "inside", "outside", "upon", "without", "against", "among",
            "along", "during", "through", "towards", "before", "after", "under", "over",
            "thing", "stuff", "fact", "information", "idea", "thought", "event", "problem",
            "issue", "situation", "case", "point", "aspect", "part", "aspect", "part",
            "element", "factor", "detail", "feature", "example", "instance", "item",
            "matter", "subject", "subject", "subject", "object", "concept", "notion",
            "belief", "opinion", "theory", "hypothesis", "practice", "method", "procedure",
            "process", "system", "strategy", "approach", "technique", "practice", "action",
            "activity", "work", "effort", "attempt", "exercise", "experience", "experiment",
            "trial", "test", "study", "research", "investigation", "analysis", "evaluation",
            "assessment", "review", "examination", "observation", "observation", "observation",
            "observation", "comparison", "contrast", "difference", "similarity", "relation",
            "relationship", "connection", "association", "link", "linkage", "bond", "bridge",
            "transition", "shift", "change", "variation", "difference", "divergence", "variety",
            "range", "scope", "extent", "magnitude", "size", "scale", "dimension", "level",
            "degree", "amount", "quantity", "number", "figure", "total", "whole", "all",
            "every", "any", "none", "nothing", "something", "anything", "everything",
            "everyone", "anyone", "no one", "somebody", "nobody", "something", "nothing",
            "somewhere", "nowhere", "everywhere", "anywhere", "everybody", "anybody", "nobody",
            "someone", "everyone", "anyone", "no one", "thing", "something", "nothing", "anything",
            "everything", "object", "entity", "creature", "being", "item", "article", "commodity",
            "product", "resource", "material", "substance", "matter", "stuff", "thing", "element",
            "component", "part", "piece", "fraction", "bit", "portion", "segment", "section",
            "unit", "module", "ingredient", "aspect", "attribute", "quality", "property", "characteristic",
            "feature", "trait", "mark", "note", "point", "factor", "cause", "reason", "motive",
            "purpose", "intention", "aim", "goal", "objective", "target", "end", "destination",
            "result", "outcome", "consequence", "effect", "impact", "influence", "significance",
            "importance", "relevance", "pertinence", "applicability", "validity", "accuracy",
            "correctness", "truth", "falsity", "error", "mistake", "fallacy", "illusion",
            "misconception", "misinterpretation", "misunderstanding", "confusion", "ambiguity",
            "uncertainty", "doubt", "question", "query", "issue", "problem", "difficulty",
            "challenge", "obstacle", "barrier", "hindrance", "constraint", "limitation",
            "restriction", "boundary", "constraint", "limitation", "restriction", "boundary",
            "condition", "situation", "circumstance", "context", "environment", "setting",
            "surroundings", "surroundings", "surroundings", "surroundings", "surroundings",
            "context", "framework", "perspective", "viewpoint", "standpoint", "angle",
            "position", "stance", "attitude", "approach", "outlook", "belief", "opinion",
            "persuasion", "conviction", "ideology", "philosophy", "doctrine", "principle",
            "value", "standard", "norm", "criteria", "requirement", "expectation", "demand",
            "need", "necessity", "essential", "essential", "essential", "requirement",
            "expectation", "demand", "need", "necessity", "essential", "essential", "essential",
            "priority", "preference", "choice", "decision", "selection", "option", "alternative",
            "possibility", "opportunity", "chance", "prospect", "potential", "potential",
            "capacity", "capability", "ability", "skill", "talent", "aptitude", "gift",
            "endowment", "strength", "advantage", "benefit", "gain", "profit", "reward",
            "advantage"
    ]


    let preprocessedEntry = preprocessText(journalEntry, stopwords: stopwords)
    print(preprocessedEntry)
}

runExample()
