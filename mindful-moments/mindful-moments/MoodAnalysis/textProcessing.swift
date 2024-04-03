//
//  textProcessing.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 3/28/24.
//
import Foundation

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

let emotionalDictionary: [String: Set<String>] = [
    "happy": ["joy", "happiness", "elation", "euphoria", "bliss", "ecstasy",
              "wonderful", "amazing", "fantastic", "exhilarating", "fulfilled", "content",
              "thankful", "grateful", "blessed", "fortunate",
              "accomplished", "proud", "successful", "victorious",
              "celebration", "party", "outing", "vacation", "adventure",
              "love", "affection", "friendship", "companionship", "caring",
              "hopeful", "optimistic", "excited", "looking forward to"],
    "sad": ["sadness", "unhappy", "grief", "depressed", "melancholy", "tears",
            "heartbroken", "mourning", "lonely", "sorrow", "despair",
            "pain", "hurt", "disappointment", "regret", "loss", "bereavement",
            "betrayal", "abandoned", "rejected", "desperate", "hopeless"],
    "angry": ["anger", "rage", "frustration", "irritation", "annoyance",
              "resentment", "fury", "outrage", "indignation", "hostility",
              "aggression", "disgust", "hatred", "wrath", "mad", "fuming",
              "enraged", "livid", "irritated", "furious", "infuriated",
              "incensed", "resentful", "agitated"],
    "surprised": ["surprise", "astonishment", "shock", "amazement", "bewilderment",
                  "startled", "stunned", "astonished", "flabbergasted", "dumbfounded",
                  "speechless", "unexpected", "unforeseen", "unanticipated"],
    "fearful": ["fear", "anxiety", "worry", "dread", "apprehension", "unease",
                "nervousness", "panic", "terror", "phobia", "horror", "fright",
                "scared", "afraid", "terrified", "petrified", "tense", "edgy",
                "jittery", "paranoid", "horrified"],
    "disgusted": ["disgust", "disdain", "revulsion", "repulsion", "aversion",
                  "abhorrence", "nausea", "sickening", "appalled", "repugnant",
                  "offensive", "vile", "obscene", "gross", "yucky", "distasteful"],
    "confident": ["confidence", "self-assured", "assurance", "certainty", "boldness",
                  "assertiveness", "poise", "self-reliance", "empowered", "secure",
                  "determined", "optimistic", "resolute", "fearless"],
    "relieved": ["relief", "comfort", "ease", "satisfaction", "reassurance",
                 "calm", "serenity", "peace", "tranquility", "contentment",
                 "grateful", "thankful", "exhale", "unburdened"],
    "hopeless": ["hopelessness", "despondency", "desperation", "defeated", "resigned",
                     "powerless", "futile", "gloom", "desolate", "dejected",
                     "forlorn", "pessimistic", "discouraged", "dismal", "melancholic"],
    "proud": ["pride", "satisfaction", "achievement", "accomplishment", "victory",
              "triumph", "self-esteem", "self-respect", "honored", "glory",
              "celebrated", "dignity", "valued", "confident", "respected"],
    "embarrassed": ["embarrassment", "shame", "humiliation", "awkwardness", "mortified",
                    "blushing", "self-conscious", "exposed", "guilt", "regretful",
                    "chagrined", "flustered", "discomfited", "disgraced", "uncomfortable"],
    "envious": ["envy", "jealousy", "covetous", "resentful", "green with envy",
                "grudging", "bitterness", "desire", "admiration", "yearning",
                "aspiring", "competitiveness", "coveting", "invidious", "longing"],
    "hopeful": ["hope", "expectation", "optimism", "anticipation", "aspiration",
                "desire", "wish", "dream", "faith", "encouraged", "inspired",
                "uplifted", "positive", "forward-looking"],
    "shocked": ["shock", "astonishment", "disbelief", "surprise", "stupefied",
                "dismay", "bewildered", "stunned", "taken aback", "appalled",
                "flabbergasted", "speechless", "aghast", "startled", "amazed"],
    "nostalgic": ["nostalgia", "sentimental", "remembrance", "longing", "yearning",
                  "reminiscence", "homesick", "wistful", "regretful", "melancholic",
                  "reflective", "bittersweet"],
    "ecstatic": ["ecstasy", "rapture", "overjoyed", "thrilled", "delighted",
                 "euphoric", "elated", "transported", "exultant", "radiant",
                 "blissful", "jubilant", "exhilarated", "giddy", "gleeful"],
    "lonely": ["loneliness", "isolated", "alone", "desolate", "solitude",
                "abandoned", "neglected", "forlorn", "deserted", "unaccompanied",
                "lost", "bereft", "alienated", "empty", "melancholy"],
    "confused": ["confusion", "puzzled", "bewildered", "baffled", "uncertain",
                  "mixed up", "perplexed", "muddled", "disoriented", "flummoxed",
                  "dazed", "discombobulated", "nonplussed", "befuddled", "at a loss"],
    "satisfied": ["satisfaction", "contentment", "fulfillment", "pleased", "gratified",
                    "contented", "happy", "fulfilled", "satiated", "accomplished",
                    "smug", "complacent", "gratification", "relieved", "serene"],
    "ashamed": ["shame", "guilt", "embarrassment", "remorse", "humiliation",
                  "contrition", "regret", "disgrace", "mortification", "self-conscious",
                  "chagrined", "mortified", "penitent", "apologetic", "blushing"],
    "anxious": ["anxiety", "worry", "nervousness", "apprehension", "unease",
                  "tension", "edginess", "jitters", "restless", "fretful",
                  "concerned", "agitated", "distressed", "tense", "panicky"],
    "amused": ["amusement", "entertained", "humorous", "funny", "laughing",
                   "playful", "jovial", "lighthearted", "tickled", "giggly",
                   "witty", "gleeful", "jocular", "comical", "merry",
                   "droll", "facetious", "cheerful", "joyful", "mirthful"],
    "calm": ["calmness", "serenity", "peacefulness", "tranquility", "composed",
             "relaxed", "quiet", "soothing", "untroubled", "placid",
             "still", "undisturbed", "peaceful", "at ease", "unperturbed",
             "cool", "collected", "quietude", "pacific", "harmony"],
    "admiration": ["admiration", "respect", "appreciation", "awe", "esteem",
                   "approval", "veneration", "regard", "applause", "honoring",
                   "reverence", "praise", "acclaim", "commendation", "compliment",
                   "flattery", "kudos", "acknowledgment", "recognition", "tribute"],
    "bored": ["boredom", "tedium", "ennui", "dullness", "monotony",
              "listlessness", "apathy", "indifference", "weariness", "languor",
              "blah", "uninterested", "disinterested", "uninspired", "lifeless",
              "drab", "mundane", "routine", "ho-hum", "tiresome"],
    "charmed": ["charm", "enchantment", "fascination", "captivation", "delight",
                "spellbound", "enthralled", "mesmerized", "enraptured", "entranced",
                "bewitched", "dazzled", "allured", "attracted", "entranced",
                "engrossed", "ravished", "transfixed", "infatuated", "enchanted"],
    "disappointed": ["disappointment", "letdown", "dissatisfied", "unfulfilled", "regret",
                     "deflated", "frustrated", "disillusioned", "disheartened", "crestfallen",
                     "saddened", "disgruntled", "underwhelmed", "upset", "chagrined",
                     "dashed hopes", "letdown", "downcast", "unhappy", "discontented"],
    "empowered": ["empowerment", "strength", "authority", "capability", "self-reliance",
                  "enablement", "confidence", "independence", "liberation", "freedom",
                  "empowered", "resilience", "self-assurance", "fortitude", "courage",
                  "self-sufficiency", "self-esteem", "autonomy", "assertiveness", "mastery"],
    "excited": ["excitement", "enthusiasm", "eager", "keen", "anticipating",
                "thrilled", "pumped", "amped", "energized", "passionate",
                "fired up", "ecstatic", "buzzing", "elated", "hyped",
                "charged", "animated", "thrilling", "roused", "excitable"],
    "grateful": ["gratitude", "thankfulness", "appreciation", "recognition", "acknowledgment",
                 "gratefulness", "thanksgiving", "blessing", "thanks", "thankful",
                 "gratification", "grace", "appreciative", "acknowledged", "indebted",
                 "thank you", "blessed", "appreciated", "obliged", "beholden"],
    "guilty": ["guilt", "remorse", "shame", "contrition", "regret",
               "culpability", "blame", "self-reproach", "repentance", "remorseful",
               "apologetic", "penitent", "sorrow", "conscience", "reparation",
               "guilty conscience", "atonement", "compunction", "remorsefulness", "self-condemnation"],
    "inspired": ["inspiration", "motivation", "creativity", "stimulation", "encouragement",
                 "influence", "vision", "aspire", "inspired", "aspiration",
                 "innovation", "drive", "passion", "inventiveness", "originality",
                 "ingenuity", "imagination", "stimulus", "inspirational", "imaginative"],
    "jealous": ["jealousy", "envy", "resentment", "covetousness", "insecurity",
                "possessiveness", "green-eyed", "envious", "grudging", "spiteful",
                "suspicious", "mistrustful", "begrudging", "malicious", "resentful",
                "jealousy", "envy", "invidious", "covetous", "grudge"],
    "motivated": ["motivation", "drive", "ambition", "determination", "enthusiasm",
                   "inspiration", "zeal", "purpose", "goal-oriented", "resolute",
                   "motivated", "driven", "aspiring", "dedicated", "energized",
                   "focused", "dynamic", "committed", "self-motivated", "go-getter"],
    "nervous": ["nervousness", "anxiety", "apprehension", "edginess", "tension",
                 "jitters", "fretfulness", "worry", "unease", "nervous",
                 "trepidation", "agitation", "restlessness", "jitters", "butterflies",
                 "nervy", "perturbed", "on edge", "uneasy", "timid"],
    "content": ["contentment", "satisfaction", "happiness", "peace", "fulfillment",
                    "serenity", "ease", "comfort", "pleasure", "gratitude",
                    "truce", "bliss", "calmness", "delight", "joy"],
    "exhilarated": ["exhilaration", "thrill", "excitement", "euphoria", "elation",
                     "high", "rush", "adrenaline", "invigorated", "animated",
                     "charged", "enthusiastic", "pumped", "fired up", "ecstatic"],
    "bewildered": ["bewilderment", "confusion", "puzzlement", "mystery", "perplexity",
                    "bafflement", "astonishment", "amazement", "astonished", "confounded",
                    "flummoxed", "dumbfounded", "stupefied", "confused", "disoriented"],
    "sympathetic": ["sympathy", "compassion", "empathy", "understanding", "care",
                     "support", "kindness", "concern", "commiseration", "caring",
                     "solicitude", "condolence", "considerate", "tender", "gentle"],
    "invigorated": ["invigoration", "renewed", "refreshed", "revitalized", "energized",
                     "recharged", "revived", "vitalized", "stimulated", "activated",
                     "animated", "inspired", "enlivened", "roused", "roused"],
    "awe": ["awe", "wonder", "astonishment", "amazement", "marvel", "wonderment",
             "admiration", "reverence", "dread", "fear", "respect", "veneration",
             "stupefaction", "astonished", "amazed"],
    "curious": ["curiosity", "inquisitive", "interested", "questioning", "inquiring",
                 "intrigued", "nosy", "inquisitiveness", "probing", "exploratory",
                 "curious", "investigative", "analytical", "inquiring", "speculative"],
    "comforted": ["comfort", "consolation", "solace", "soothe", "reassure",
                   "ease", "relief", "assurance", "support", "comforted",
                   "reassured", "solaced", "consoled", "pacified", "alleviated"],
    "discontent": ["discontent", "dissatisfaction", "displeasure", "unhappiness", "discontentment",
                     "malcontent", "disgruntled", "grumbling", "griping", "bitterness",
                     "resentment", "irritation", "discontented", "unhappy", "restless"],
    "suspicious": ["suspicion", "mistrust", "distrust", "doubt", "skepticism",
                     "paranoia", "wariness", "suspicious", "guarded", "doubtful",
                     "cynical", "skeptical", "distrustful", "apprehensive", "skeptical"],
    "nostalgia": ["nostalgia", "sentimentality", "longing", "yearning", "wistfulness",
                    "homesickness", "regret", "remembrance", "reminiscence", "nostalgic",
                    "sentimental", "yearning", "longing", "melancholy", "reflective"],
    "thrilled": ["thrill", "excitement", "excited", "elation", "enthusiasm",
                   "euphoria", "glee", "joy", "jubilation", "exhilaration",
                   "exultation", "ecstasy", "overjoyed", "thrilled", "enthralled"],
    "disheartened": ["disheartenment", "discouragement", "dismay", "despondency", "dejection",
                        "disillusionment", "defeatism", "downheartedness", "despair", "hopelessness",
                        "resignation", "disheartened", "disillusioned", "crestfallen", "gloomy"],
    "graceful": ["grace", "elegance", "poise", "dignity", "refinement",
                    "gracefulness", "charm", "beauty", "style", "class",
                    "graceful", "elegant", "refined", "polished", "sophisticated"],
    "amazed": ["amazement", "astonishment", "wonder", "awe", "surprise",
                   "shock", "stupefaction", "marvel", "astonished", "awestruck",
                   "dumbfounded", "flabbergasted", "startled", "stunned", "perplexed"],
    "vulnerable": ["vulnerability", "exposure", "fragility", "sensitivity", "openness",
                   "defenselessness", "helplessness", "insecurity", "fragile", "exposed",
                   "defenseless", "susceptible", "unprotected", "frail", "weak"],
    "fulfilled": ["fulfillment", "satisfaction", "contentment", "achievement", "gratification",
                  "realization", "completion", "contentedness", "accomplishment", "fulfilled",
                  "happy", "pleased", "satiated", "content", "fulfilling"],
    
    "hope": ["hope", "optimism", "expectation", "faith", "confidence",
             "trust", "aspiration", "ambition", "belief", "anticipation",
             "wish", "desire", "dream", "hopefulness", "hopeful"],
    "overwhelmed": ["overwhelm", "overload", "burden", "pressure", "stress",
                    "exhaustion", "fatigue", "strained", "frazzled", "swamped",
                    "bombarded", "overloaded", "overworked", "drained", "overwhelmed"],
    
    "apathetic": ["apathy", "indifference", "unconcern", "lethargy", "passivity",
                   "listlessness", "lackadaisical", "detached", "uninterested", "unresponsive",
                   "unenthusiastic", "unmotivated", "disinterested", "nonchalant", "aloof"],
    "determined": ["determination", "resolve", "perseverance", "tenacity", "willpower",
                     "dedication", "commitment", "strength", "courage", "persistence",
                     "steadfastness", "drive", "conviction", "resilience", "determined"],
    "guarded": ["guarded", "cautious", "wary", "circumspect", "watchful",
                 "vigilant", "careful", "alert", "attentive", "cagey",
                 "reserved", "restrained", "prudent", "suspicious", "on guard"],
    "insignificant": ["insignificance", "unimportance", "irrelevance", "triviality", "obscurity",
                       "meaninglessness", "pettiness", "trifling", "inconsequence", "insignificant",
                       "inconsequential", "minor", "paltry", "negligible", "small"],
    "rejuvenated": ["rejuvenation", "renewal", "revival", "refreshment", "regeneration",
                     "reinvigoration", "revitalization", "restoration", "recharge", "reinvigorated",
                     "refreshed", "renewed", "revived", "regenerated", "energized"],
    "enthusiastic": ["enthusiasm", "zeal", "passion", "excitement", "eagerness",
                      "ardor", "keenness", "zest", "avidity", "vivacity",
                      "fervor", "animation", "euphoria", "exuberance", "enthusiastic"],
    "melancholic": ["melancholy", "sadness", "gloom", "depression", "despondency",
                     "despair", "sorrow", "grief", "pessimism", "disconsolate",
                     "downhearted", "blue", "mournful", "woeful", "melancholic"],
    
    "serene": ["serenity", "calm", "peace", "tranquility", "quiet",
               "stillness", "placidity", "composure", "serene", "peaceful",
               "tranquil", "unruffled", "undisturbed", "composed", "serenity"],
    
    "enraged": ["anger", "rage", "fury", "outrage", "indignation",
                "enraged", "livid", "infuriated", "incensed", "incandescent",
                "angry", "wrath", "irate", "fuming", "outraged"],
    
    "defeated": ["defeat", "failure", "loss", "beaten", "conquered",
                 "vanquished", "trounced", "overwhelmed", "defeated", "crushed",
                 "demoralized", "subdued", "subjugated", "felled", "defeated"],
    
    "despondent": ["despondency", "despair", "dejection", "melancholy", "gloom",
                    "hopelessness", "discouragement", "despondent", "disheartened", "dispirited",
                    "crestfallen", "downcast", "sad", "unhappy", "miserable"],
    
    "anguished": ["anguish", "pain", "suffering", "distress", "torment",
                    "agony", "heartache", "anguished", "wretchedness", "misery",
                    "torture", "affliction", "woe", "desolation", "anguished"],
    "refreshed": ["refresh", "renew", "revive", "recharge", "invigorate",
                    "refreshed", "renewed", "revived", "revitalized", "energized",
                    "rejuvenated", "restored", "replenished", "regenerated", "refreshed"],
    "pensive": ["pensive", "thoughtful", "contemplative", "reflective", "meditative",
                  "musing", "introspective", "brooding", "wistful", "melancholy",
                  "pondering", "cogitative", "ruminative", "reflecting", "preoccupied"],
    
    "regretful": ["regret", "remorse", "contrition", "sorrow", "penitence",
                   "repentance", "guilt", "shame", "regretful", "sorry",
                   "apologetic", "rueful", "penitent", "sorrowful", "apologetic"],
    "doubtful": ["doubt", "skepticism", "uncertainty", "indecision", "dubiousness",
                  "suspicion", "skepticism", "distrust", "disbelief", "doubtful",
                  "questioning", "skeptical", "hesitant", "wavering", "uncertain"]
]




//let journalEntry = "Today dawned with a crisp chill in the air, signaling the slow transition from winter's icy grip to the gentle embrace of spring. As I sipped my morning coffee, tendrils of steam curling upwards, I contemplated the promise of a new day. The streets outside echoed with the hurried footsteps of commuters, each lost in their own world of thoughts and ambitions. Yet, amidst the cacophony of city life, there exists a quiet sanctuary within the pages of my journal, where the clamor of the outside world fades into insignificance. In the solitude of my thoughts, I found refuge, pen in hand, poised to capture the fleeting moments that make life so precious. With each stroke of ink upon the blank canvas of my journal, I immortalize fragments of my existence, weaving them into a tapestry of memories that will endure the passage of time. Today, I reflected on the beauty of impermanence, recognizing that every sunrise brings with it the promise of new beginnings, and every sunset heralds the close of another chapter. In embracing the transience of life, I find liberation, for it is in letting go that we truly learn to live. As the day draws to a close and the sky is painted in hues of crimson and gold, I am reminded of the fleeting nature of time. And so, with gratitude in my heart and pen in hand, I bid adieu to today, knowing that tomorrow holds the promise of new adventures and untold wonders."

//let journalEntry = """
//Today marked the beginning of a new chapter in my life. As the sun rose, I felt a surge of excitement coursing through my veins. The possibilities seemed endless, like the vast expanse of the sky stretching out before me. With each step I took, I embraced the sense of adventure that lay ahead.
//
//I decided to explore the quaint streets of the old town, each cobblestone pathway whispering tales of bygone eras. The charming architecture seemed to beckon me closer, inviting me to unravel its mysteries. I found myself lost in the maze of narrow alleys, discovering hidden gems around every corner.
//
//The aroma of freshly brewed coffee led me to a cozy café tucked away from the hustle and bustle of the city. As I sipped my steaming cup, I immersed myself in the pages of a captivating novel, transported to distant lands and faraway adventures. Time seemed to stand still as I savored each moment of solitude.
//
//In the afternoon, I ventured into nature's embrace, wandering through verdant meadows and ancient woodlands. The gentle breeze whispered secrets of the forest, while the songs of birds filled the air with melodies of joy. With every breath, I felt a deep connection to the earth beneath my feet, grateful for the beauty that surrounded me.
//
//As the day drew to a close, I reflected on the experiences that had filled my heart with warmth and wonder. Though the journey ahead may be uncertain, I embrace it with open arms, knowing that each step brings me closer to the person I am meant to be.
//"""
//


//supposed to be more happy leaning
//let journalEntry = """
//Oh, what a glorious day it has been! From the moment I opened my eyes this morning, I could feel the sunshine streaming through my window, filling my room with warmth and joy. It was as if the universe itself was smiling down upon me, eager to share in the boundless happiness that awaited.
//
//As I stepped outside, the air was crisp and invigorating, tinged with the promise of endless possibilities. I danced down the street, my heart brimming with excitement and anticipation for the day ahead. Every flower seemed to bloom brighter, every bird sang sweeter, as if nature itself was celebrating my presence.
//
//I spent the morning surrounded by my loved ones, laughter filling the air like music. We shared stories and jokes, basking in the glow of each other's company. Every hug, every smile, filled me with an overwhelming sense of gratitude for the wonderful people in my life.
//
//In the afternoon, I embarked on a grand adventure, exploring new sights and sounds that filled my soul with wonder. I chased butterflies through fields of wildflowers, my spirit soaring with each step. Every moment was a treasure, a precious gift to be cherished forever.
//
//As the sun began to set, painting the sky with hues of pink and gold, I found myself overcome with a sense of profound contentment. I watched in awe as the world around me transformed into a canvas of beauty and magic, a reminder of the infinite wonders that await us each day.
//
//And now, as I write these words by the soft glow of candlelight, I am filled with a deep sense of peace and happiness. For today has been nothing short of perfect, a day filled with love, laughter, and endless joy. And for that, I am eternally grateful.
//"""

//supposed to be more sad
let journalEntry = """
Today felt like a heavy weight pressing down on my chest, suffocating me with its unbearable sorrow. From the moment I woke up, I could sense the darkness looming over me, casting a shadow on everything I held dear.

As I went about my day, each task felt like a Herculean effort, draining me of whatever little energy I had left. The world around me seemed to have lost its color, replaced by shades of gray and despair. Every sound was muted, every smile felt forced, as if I was merely going through the motions of life.

I found myself lost in a sea of memories, each one a painful reminder of what once was and what could have been. The tears flowed freely, cascading down my cheeks like silent rivers of grief. It felt as though my heart had been shattered into a million pieces, scattered to the winds with no hope of ever being whole again.

I sought solace in the embrace of solitude, seeking refuge from the cacophony of the outside world. But even in the silence, the echoes of my pain reverberated through the emptiness, a constant reminder of the loneliness that consumed me from within.

As the day drew to a close, I retreated into myself, seeking refuge beneath the covers of my bed. The darkness enveloped me like a shroud, offering no respite from the relentless ache in my soul. And as I drifted off to sleep, I prayed for a glimmer of hope to pierce through the darkness and guide me back to the light.
"""



func preprocessText(_ text: String, stopwords: Set<String>) -> String {
    //splits the text into an array of substrings using whitespace
    //Stored in the token array
    var tokens = text.components(separatedBy: .whitespacesAndNewlines)
    
    //Remove o=punctuation and set to all lower case
    let punctuation = CharacterSet.punctuationCharacters
    tokens = tokens.map { token in
        //processedToken contains words that passed filtration
        let processedToken = token.trimmingCharacters(in: punctuation)
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

func processText(text: String, emotionDictionary: [String: Set<String>]) -> [String:Int]{
    var emotionCount = [String: Int]()
    
    // Split the text into words
    let words = text.components(separatedBy: .whitespacesAndNewlines)
    
    // Loop through each word
    for word in words {
        // Loop through each emotion set in the emotional dictionary
        for (emotion, wordSet) in emotionDictionary {
            // Check if the word is in the current emotion set
            if wordSet.contains(word) {
                // Increment the count for the emotion
                emotionCount[emotion, default: 0] += 1
            }
        }
    }
    return emotionCount
}


func runExample() {
    let preprocessedEntry = preprocessText(journalEntry, stopwords: stopwords)
    print(preprocessedEntry)
}

func runProcessExample(){
    let preprocessedEntry = preprocessText(journalEntry, stopwords: stopwords)
//    print(preprocessedEntry)
    // Count emotions in the text
    let emotionCount = processText(text: preprocessedEntry, emotionDictionary: emotionalDictionary)

    // Print the emotion counts
    for (emotion, count) in emotionCount {
        print("\(emotion): \(count)")
    }
}

runProcessExample()
//runExample()
