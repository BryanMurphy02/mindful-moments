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
    "happy": [
            "joy", "happiness", "elation", "euphoria", "bliss", "ecstasy",
            "wonderful", "amazing", "fantastic", "exhilarating", "fulfilled", "content",
            "thankful", "grateful", "blessed", "fortunate",
            "accomplished", "proud", "successful", "victorious",
            "celebration", "party", "outing", "vacation", "adventure",
            "love", "affection", "friendship", "companionship", "caring",
            "hopeful", "optimistic", "excited", "looking forward to",
            "delight", "radiance", "jubilation", "thrill", "enthusiasm",
            "glee", "merriment", "pleasure", "exuberance", "cheer",
            "grin", "beam", "smile", "contentment", "triumph",
            "felicity", "rapture", "uplifted", "serenity", "satisfying",
            "gratifying", "rejoicing", "elated", "delightedness", "cheery",
            "sunny", "bright", "heartening", "gleaming", "joyfulness",
            "lightheartedness", "radiant", "jovial", "delightfulness",
            "thriving", "blissfulness", "enlivened", "gladdened", "jocular",
            "untroubled", "heartfelt", "beatific", "well-being", "giggly", "cheery", "elated", "radiant", "exultant", "euphoric", "sunny", "joyful",
            "blissful", "beaming", "ecstatic", "jovial", "overjoyed", "merry", "gleeful",
            "carefree", "upbeat", "buoyant", "lively", "vibrant", "festive", "exhilarated",
            "thrilled", "contented", "delighted", "grinning", "smiling", "laughing", "chirpy",
            "jaunty", "zestful", "dynamic", "sparkling", "exuberant", "effervescent", "bubbly",
            "spirited", "animated", "enthusiastic", "joyous", "elevated", "jubilant", "jolly",
            "festal", "elation", "cheerful", "happy-go-lucky", "gladsome", "radiating happiness",
            "elated", "on cloud nine", "jumping for joy", "chipper", "bouncy", "joy-filled",
            "jubilant", "blissed out", "full of beans", "as happy as Larry", "high on life",
            "in high spirits", "chuffed", "walking on air", "tickled pink", "giddy", "tickled",
            "cock-a-hoop", "rapturous", "glee", "exultation", "satisfaction", "joyfulness",
            "merriment", "beatitude", "blitheness", "hilarity", "buoyancy", "light-heartedness",
            "jollity", "radiance", "sunshine", "glow", "radiant", "shining", "uplifting",
            "heartwarming", "exhilaration", "uplift", "happily", "satisfying", "rejoicing",
            "satisfied", "chirpy", "lighthearted", "spirited", "sparkling", "effervescent",
            "zestful", "spirited", "animated", "enthusiastic", "joyous", "elevated", "jubilant",
            "jolly", "festal", "exhilarated", "thrilled", "contented", "delighted", "grinning",
            "smiling", "laughing", "chirpy", "jaunty", "zestful", "dynamic", "sparkling",
            "exuberant", "effervescent", "bubbly", "spirited", "animated", "enthusiastic",
            "joyous", "elevated", "jubilant", "jolly", "festal", "elation", "cheerful",
            "happy-go-lucky", "gladsome", "radiating happiness", "elated", "on cloud nine",
            "jumping for joy", "chipper", "bouncy", "joy-filled", "jubilant", "blissed out",
            "full of beans", "as happy as Larry", "high on life", "in high spirits", "chuffed",
            "walking on air", "tickled pink", "giddy", "tickled", "cock-a-hoop", "rapturous",
            "glee", "exultation", "satisfaction", "joyfulness", "merriment", "beatitude",
            "blitheness", "hilarity", "buoyancy", "light-heartedness", "jollity", "radiance",
            "sunshine", "glow", "radiant", "shining", "uplifting", "heartwarming", "exhilaration",
            "uplift", "happily", "satisfying", "rejoicing", "satisfied"],
    "sad": [
            "desolation", "woe", "misery", "despondency", "agony", "desolation",
            "wretchedness", "lamentation", "disconsolate", "forlorn", "dejection",
            "dismay", "bleakness", "desperation", "anguish", "regretful", "lament",
            "sombre", "pensive", "doleful", "melancholy", "grief", "sorrow",
            "despair", "heartache", "hopelessness", "tearful", "mournful",
            "depressed", "unhappy", "crestfallen", "disheartened", "blue",
            "glum", "dismal", "dreary", "downhearted", "heavy-hearted",
            "sullen", "morose", "dispirited", "desolate", "downcast",
            "weary", "tragic", "mourning", "anguished", "despondent", "sorrowful", "grieving", "brokenhearted",
            "tearful", "weepy", "melancholic", "dejected", "downcast", "disappointed",
            "disillusioned", "heartbroken", "bereaved", "bereft", "despairing", "crestfallen",
            "defeated", "deflated", "regretful", "remorseful", "weeping", "sobbing",
            "lamenting", "grieving", "gloomy", "somber", "sullen", "mournful",
            "funereal", "woeful", "pitiful", "troubled", "woebegone", "downtrodden",
            "defeated", "down", "cast down", "despondent", "disconsolate", "disheartened",
            "broken-hearted", "heavyhearted", "sighing", "crying", "weeping", "sad-hearted",
            "low-spirited", "down in the dumps", "in mourning", "in tears", "in sorrow",
            "distressed", "pained", "hurt", "broken", "dispirited", "unconsolable",
            "lachrymose", "blubbering", "dolorous", "blue", "down in the mouth",
            "morbid", "mournful", "plaintive", "wistful", "bitter", "disenchanted",
            "disheartened", "crestfallen", "downhearted", "despairing", "melancholic",
            "miserable", "down", "in the doldrums", "discontented", "displeased",
            "dejected", "discouraged", "forlorn", "gloomy", "glum", "sorrowful",
            "wretched", "downcast", "downhearted", "low", "disappointed", "unhappy",
            "heartbroken", "crestfallen", "disheartened", "miserable", "depressed",
            "despondent", "disconsolate", "grief-stricken", "distraught", "anguished",
            "pained", "suffering", "in despair", "in anguish", "in pain", "in torment",
            "in the depths of despair", "afflicted", "oppressed", "ravaged", "agonized",
            "distressed", "tortured", "wretched", "worrying", "suffering", "tormented",
            "anguishing", "dolorous", "painful", "heart-wrenching", "crushing", "racking",
            "harrowing", "anguished", "tear-stained", "disappointed", "mournful",
            "melancholy", "sorrowful", "wistful", "longing", "yearning", "nostalgic",
            "homesick", "bereft", "grieving", "despairing", "hopeless", "abandoned",
            "desolate", "lonesome", "isolated", "alienated", "forsaken", "alone",
            "rejected", "neglected", "unloved", "unwanted", "misunderstood", "empty",
            "drained", "numb", "broken", "shattered", "crushed", "devastated",
            "ruined", "destroyed", "bereaved", "bereft", "lonely", "solitary"],
    "anger": [
            "rage", "fury", "wrath", "outrage", "resentment", "irritation",
            "hostility", "bitterness", "hatred", "indignation", "frustration",
            "enraged", "mad", "incensed", "annoyed", "infuriated", "aggravated",
            "livid", "raging", "seething", "vexed", "cross", "wrathful", "outraged",
            "agitation", "outburst", "tantrum", "exasperation", "outcry",
            "temper", "angriness", "outrageousness", "ire", "vehemence",
            "storm", "outbreak", "fit", "blowup", "flare-up", "uproar",
            "ferocity", "hysteria", "tantrum", "tantrums", "offense",
            "violent", "outrageously", "incite", "insult", "aggression", "animosity", "antagonism", "belligerence", "choler", "displeasure",
            "enmity", "exasperation", "frenzy", "fume", "grudge", "hate", "hostility",
            "ill will", "impatience", "incitement", "inflammation", "irascibility",
            "malevolence", "mania", "miff", "outrage", "passion", "pique", "provocation",
            "rancor", "resentfulness", "tumult", "turmoil", "vendetta", "violence",
            "vitriol", "wrathfulness", "discontentment", "disgruntlement", "displeasure",
            "dissatisfaction", "irritability", "antipathy", "aversion", "disgust",
            "dislike", "hostility", "resentment", "disapproval", "disdain", "enmity",
            "loathing", "malevolence", "revulsion", "bitterness", "acrimony", "rancor",
            "animus", "hatred", "spite", "malice", "vindictiveness", "acridity",
            "acridness", "acerbity", "acrimony", "asperity", "bitterness", "causticity",
            "mordancy", "sharpness", "trenchancy", "wrath", "wrathfulness", "ire",
            "outrage", "outrageousness", "indignation", "irritation", "aggravation",
            "exasperation", "frustration", "vexation", "annoyance", "irritability",
            "pique", "resentment", "displeasure", "discontent", "dissatisfaction",
            "disgust", "disapprobation", "disapproval", "disinclination", "disliking",
            "antipathy", "aversion", "loathing", "odium", "hostility", "enmity",
            "animosity", "antagonism", "ill will", "bitterness", "rancor", "malevolence",
            "malice", "spite", "venom", "hate", "abhorrence", "abomination", "repugnance",
            "repulsion", "disgust", "hatred", "revulsion", "detestation", "odiousness",
            "execration", "objection", "exception", "disgustfulness", "repugnancy",
            "distaste", "nausea", "aversion", "abhorrence", "repulsion", "horror",
            "loathing", "detestation", "odiousness", "revulsion", "abomination",
            "aversion", "repugnance", "revulsion", "antipathy", "disrelish", "distaste",
            "detestation", "repugnance", "repulsion", "aversion", "loathing", "disfavor",
            "disinclination", "reluctance", "unwillingness", "disgust", "displeasure",
            "antipathy", "aversion", "abhorrence", "detestation", "animosity", "hostility",
            "resentment", "malice", "bitterness", "animus", "acrimony", "rancor",
            "hatred", "repugnance", "loathing", "abomination", "revulsion", "disgust",
            "nausea", "aversion", "horror", "detestation", "abhorrence", "repulsion",
            "loathing", "distaste", "abomination", "repugnance", "dislike", "hatred",
            "hostility", "animosity", "rancor", "bitterness", "resentment", "ill will",
            "antagonism", "animus", "spite", "malice", "venom", "vindictiveness",
            "hatred", "animosity", "rancor", "bitterness", "hostility", "resentment",
            "ill will", "antagonism", "animus", "spite", "malice", "venom",
            "vindictiveness", "hostility", "animosity", "rancor", "bitterness",
            "resentment", "ill will", "antagonism", "animus", "spite", "malice",
            "venom", "vindictiveness", "belligerence", "aggression", "hostility",
            "antagonism", "pugnacity", "combative", "warlike", "quarrelsomeness",
            "argumentativeness", "contentiousness", "bellicosity", "militancy",
            "aggressiveness", "militarism", "confrontational", "hostile", "belligerent",
            "bellicose", "combative", "martial", "quarrelsome", "aggressive",
            "contentious", "antagonistic", "pugnacious", "truculent", "feisty",
            "argumentative", "litigious", "factious", "controversial", "inflammatory",
            "provocative", "incendiary", "inflaming", "instigative", "instigating",
            "stirring", "agitating", "provoking", "inflamatory", "inflamatorily",
            "inflamed", "irritating", "exasperating", "vexing", "annoying", "irritant",
            "bother", "pest", "nuisance", "affront", "indignity", "slight", "insult",
            "offense", "outrage", "provocation", "provoking", "gall", "resentment",
            "bitterness", "annoyance", "exasperation", "irritation", "aggravation"],
    "fear": [
            "terror", "horror", "dread", "fright", "panic", "alarm",
            "anxiety", "apprehension", "unease", "nervousness", "trepidation",
            "phobia", "jitters", "shiver", "shudder", "tremor", "shaking",
            "quaking", "shiver", "shudder", "goosebumps", "petrified", "scared",
            "afraid", "terrified", "panicked", "startled", "spooked", "petrified",
            "hysteria", "paranoia", "claustrophobia", "claustrophobic", "agoraphobia",
            "agoraphobic", "scare", "alarm", "horrified", "apprehensive", "creepy",
            "spine-chilling", "shivery", "nightmarish", "dismay", "consternation", "trepidation", "foreboding", "anguish", "worry",
            "concern", "disquiet", "panic-stricken", "terror-stricken", "terrified",
            "horror-struck", "aghast", "aghast", "aghast", "shocked", "stupefied",
            "appalled", "astounded", "frozen", "paralyzed", "frozen with fear", "paralyzed with fear",
            "petrified", "hyperventilating", "hyperventilation", "sweating", "sweaty palms",
            "shaking", "trembling", "quaking", "quivering", "palpitating", "pounding heart",
            "heart racing", "heart pounding", "heart thumping", "breathless", "shortness of breath",
            "tight chest", "choking sensation", "feeling faint", "weak knees", "rubbery legs",
            "jelly legs", "sinking feeling", "pit in stomach", "butterflies in stomach",
            "knot in stomach", "dizzy", "light-headed", "faint", "woozy", "nauseous",
            "sick to the stomach", "sick", "queasy", "retching", "dry mouth", "cotton mouth",
            "throat tightening", "lump in throat", "mouth going dry", "voice trembling",
            "voice quavering", "voice shaking", "voice breaking", "eyes wide with fear",
            "eyes bulging with fear", "eyes staring in terror", "hair standing on end",
            "sweaty brow", "beads of sweat", "clammy skin", "pale", "pallid", "ashen",
            "sallow", "blood draining from face", "cold sweat", "shivers down spine",
            "hair-raising", "blood-curdling", "bone-chilling", "spine-tingling",
            "hair standing on end", "flesh crawling", "heart-stopping", "jaw-dropping",
            "gut-wrenching", "soul-crushing", "mind-numbing", "terrorizing", "terrifying",
            "horrifying", "panic-inducing", "sudden", "unexpected", "frightening",
            "intense", "overwhelming", "uncontrollable", "paralyzing", "crippling",
            "devastating", "debilitating", "gripping", "consuming", "dominating",
            "constricting", "restrictive", "overpowering", "irrational", "irrational fear",
            "irrational dread", "irrational terror", "unnatural", "supernatural",
            "paranormal", "unnerving", "unsettling", "disturbing", "menacing",
            "threatening", "dreadful", "awful", "dire", "ghastly", "grim",
            "hair-raising", "horrendous", "horrific", "nightmarish", "terrifying",
            "traumatizing", "petrifying", "fearful", "fear-filled", "frightened",
            "scared stiff", "frozen with fright", "paralyzed with fright", "nervous",
            "anxious", "jittery", "tense", "on edge", "panicky", "terrified",
            "horror-stricken", "aghast", "shocked", "stupefied", "appalled", "astonished",
            "frozen", "petrified", "hyperventilating", "sweating", "shaking", "trembling",
            "quaking", "quivering", "palpitating", "breathless", "short of breath",
            "tight-chested", "choking", "feeling faint", "weak-kneed", "rubbery-legged",
            "jelly-legged", "sinking", "pit-of-stomach", "butterflies", "knot", "dizzy",
            "light-headed", "faint", "woozy", "nauseated", "sick", "queasy", "retching",
            "dry-mouthed", "cotton-mouthed", "throat-tightening", "lump-in-throat",
            "voice-trembling", "eye-wide", "hair-raising", "blood-curdling",
            "bone-chilling", "spine-tingling", "hair-standing", "flesh-crawling",
            "jaw-dropping", "gut-wrenching", "soul-crushing", "mind-numbing",
            "terrorizing", "terrifying", "horrifying", "panic-inducing", "sudden",
            "unexpected", "frightening", "intense", "overwhelming", "uncontrollable",
            "paralyzing", "crippling", "devastating", "debilitating", "gripping",
            "consuming", "dominating", "constricting", "restrictive", "overpowering",
            "unnerving", "unsettling", "disturbing", "menacing", "threatening",
            "dreadful", "awful", "dire", "ghastly", "grim", "terrifying", "traumatizing",
            "petrifying", "fearful", "fear-filled", "frightened", "scared stiff",
            "frozen with fright", "paralyzed with fright", "nervous", "anxious"],
    "surprise": [
            "astonishment", "amazement", "shock", "startle", "stun", "dismay",
            "bewilderment", "disbelief", "stagger", "startlement", "awe", "wonder",
            "disconcert", "flabbergast", "confound", "nonplussed", "unsettled",
            "jolt", "jarring", "astound", "dumbfounded", "stupefy", "speechless",
            "thunderstruck", "overwhelmed", "taken aback", "caught off guard",
            "knocked for a loop", "open-mouthed", "wide-eyed", "jaw-dropping",
            "eye-popping", "mind-blowing", "mind-boggling", "flummox", "shocked",
            "surprised", "astonished", "amazed", "stunned", "confused", "baffled",
            "startled", "floored", "startling", "astonishing", "astounding", "mind-blowing", "mind-boggling",
            "jaw-dropping", "eye-opening", "eye-popping", "unexpected", "unanticipated",
            "sudden", "abrupt", "unexpectedly", "abruptly", "aback", "unexpectedly",
            "unexpected", "unforeseen", "unpredicted", "unlooked-for", "unpredicted",
            "unforeseeable", "unpredicted", "unforeseeable", "unanticipated", "unpredicted",
            "unannounced", "unheralded", "unplanned", "unsuspected", "out-of-the-blue",
            "out of nowhere", "without warning", "unannounced", "unbidden", "uninvited",
            "unwelcome", "unwanted", "unasked-for", "unlooked-for", "undreamed-of",
            "unpredicted", "unpredicted", "unanticipated", "unsurprising", "unsurprised",
            "predictable", "expected", "anticipated", "looked-for", "foreseen",
            "foretold", "expectedly", "anticipatedly", "expectantly", "predictably",
            "anticipatedly", "inevitable", "unavoidable", "inexorable", "ineluctable",
            "sure", "certain", "inevitably", "unavoidably", "inexorably", "ineluctably",
            "inevitably", "certainly", "surely", "definitely", "positively", "indubitably",
            "without doubt", "without question", "beyond doubt", "without fail",
            "beyond any doubt", "without a shadow of a doubt", "beyond the shadow of a doubt",
            "inconceivably", "inconceivable", "impossibly", "unthinkably", "incomprehensibly",
            "unbelievably", "improbably", "impossible", "unthinkable", "incomprehensible",
            "unbelievable", "far-fetched", "unimaginable", "improbable", "unlikely",
            "far-fetched", "doubtful", "hard to believe", "questionable", "implausible",
            "impossible", "unthinkable", "inconceivable", "unbelievable", "far-fetched",
            "unimaginable", "improbable", "unlikely", "far-fetched", "doubtful",
            "hard to believe", "questionable", "implausible", "inconceivable", "impossible",
            "unimaginable", "unbelievable", "far-fetched", "improbable", "unlikely",
            "far-fetched", "doubtful", "hard to believe", "questionable", "implausible"],
    "disgust": [
            "revulsion", "repulsion", "disdain", "abhorrence", "repugnance", "aversion",
            "loathing", "nausea", "odium", "contempt", "disgust", "abomination",
            "sickened", "repelled", "detest", "intolerance", "hatefulness", "displeasure",
            "dislike", "offended", "discomfort", "indignation", "irritation", "anger",
            "enmity", "hostility", "antipathy", "scorn", "irritate", "aggravation",
            "annoyance", "disapprove", "disparagement", "aberration", "disbelief",
            "disparaging", "disregard", "disrespect", "insult", "disinclined", "dismay",
            "hatred", "insulted", "irked", "mortified", "peeved", "pest", "rankled",
            "resentful", "sickened", "turn-off", "turned off", "turnoff", "disgusted", "disgusting", "disgustful", "disgustingly", "disgustedly",
            "disgustfully", "disgustingly", "disgustingness", "disgustfulness",
            "disgustingly", "disgustfulness", "disgustingly", "disgustfully",
            "disgustful", "abhorrent", "loathsome", "nauseating", "vile", "offensive",
            "off-putting", "repellent", "repulsive", "repugnant", "distasteful",
            "unpleasant", "horrible", "awful", "terrible", "abominable", "detestable",
            "unsavory", "gross", "yucky", "icky", "sickening", "nauseous", "nauseated",
            "odoriferous", "malodorous", "stenchful", "foul-smelling", "putrid",
            "vomit-inducing", "disgustful", "revolting", "horrifying", "appalling",
            "shocking", "frightening", "horrifyingly", "appallingly", "shockingly",
            "frighteningly", "horrifically", "appallingly", "shockingly", "frighteningly",
            "horrifically", "abhorrently", "loathsomely", "nauseatingly", "vilely",
            "offensively", "repellently", "repulsively", "repugnantly", "distastefully",
            "unpleasantly", "horribly", "awfully", "terribly", "abominably", "detestably",
            "unsavorily", "grossly", "yuckily", "ickily", "sickeningly", "nauseously",
            "nauseatedly", "odoriferously", "malodorously", "stenchfully", "foul-smellingly",
            "putridly", "vomit-inducingly", "disgustingly", "revoltingly", "horrifyingly",
            "appallingly", "shockingly", "frighteningly", "horrifically", "abhorrently",
            "loathsomely", "nauseatingly", "vilely", "offensively", "repellently",
            "repulsively", "repugnantly", "distastefully", "unpleasantly", "horribly",
            "awfully", "terribly", "abominably", "detestably", "unsavorily", "grossly",
            "yuckily", "ickily", "sickeningly", "nauseously", "nauseatedly", "odoriferously",
            "malodorously", "stenchfully", "foul-smellingly", "putridly", "vomit-inducingly",
            "dissatisfied", "unhappy", "unfulfilled", "frustrated", "displeased",
            "discontented", "unsatisfied", "displeasedly", "discontentedly", "unsatisfactorily",
            "dissatisfyingly", "displeasingly", "discontentedly", "unsatisfiedly",
            "displeasedness", "discontentedness", "unsatisfiedness", "displeasingness",
            "discontentedness", "unsatisfiedness", "displeasingness", "unsatisfiedness",
            "unsatisfiedness", "displeasingness", "unsatisfiedly", "unsatisfactorily",
            "unpleasedly", "unsatisfiedly", "unsatisfiedly", "displeasedness", "discontentedness",
            "unsatisfiedness", "displeasingness", "unsatisfiedness", "displeasingness",
            "unsatisfiedness", "displeasingness", "unpleasedness", "unpleasantness",
            "displeasingness", "unsatisfiedness", "displeasingness", "unpleasedness",
            "unpleasantness", "unsatisfiedness", "unpleasedness", "unpleasantness",
            "displeasedness", "discontentedness", "unsatisfiedness", "displeasingness",
            "unpleasedness", "unpleasantness", "unsatisfiedness", "unpleasedness",
            "unpleasantness", "unpleasedness", "unpleasantness", "displeasedness",
            "discontentedness", "unsatisfiedness", "displeasingness", "unpleasedness",
            "unpleasantness", "unsatisfiedness", "unpleasedness", "unpleasantness",
            "unpleasedness", "unpleasantness", "displeasedness", "discontentedness",
            "unsatisfiedness", "displeasingness", "unpleasedness", "unpleasantness",
            "unsatisfiedness", "unpleasedness", "unpleasantness", "unpleasedness",
            "unpleasantness", "unpleasedness", "unpleasantness", "displeasedness",
            "discontentedness", "unsatisfiedness", "displeasingness", "unpleasedness",
            "unpleasantness", "unsatisfiedness", "unpleasedness", "unpleasantness",
            "unpleasedness", "unpleasantness", "displeasedness", "discontentedness",
            "unsatisfiedness", "displeasingness", "unpleasedness", "unpleasantness",
            "unsatisfiedness", "unpleasedness", "unpleasantness", "unpleasedness",
            "unpleasantness", "unpleasedness", "unpleasantness", "displeasedness",
            "discontentedness", "unsatisfiedness", "displeasingness", "unpleasedness",
            "unpleasantness", "unsatisfiedness", "unpleasedness", "unpleasantness",
            "unpleasedness", "unpleasantness", "displeasedness", "discontentedness",
            "unsatisfiedness", "displeasingness", "unpleasedness", "unpleasantness",
            "unsatisfiedness", "unpleasedness", "unpleasantness", "unpleasedness",
            "unpleasantness", "unpleasedness", "unpleasantness", "displeasedness",
            "discontentedness", "unsatisfiedness", "displeasingness", "unpleasedness",
            "unpleasantness", "unsatisfiedness", "unpleasedness", "unpleasantness",
            "unpleasedness", "unpleasantness", "displeasedness", "discontentedness",
            "unsatisfiedness", "displeasingness", "unpleasedness", "unpleasantness",
            "unsatisfiedness", "unpleasedness"]
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



//supposed to be more happy leaning
let journalEntry = """
Oh, what a glorious day it has been! From the moment I opened my eyes this morning, I could feel the sunshine streaming through my window, filling my room with warmth and joy. It was as if the universe itself was smiling down upon me, eager to share in the boundless happiness that awaited.

As I stepped outside, the air was crisp and invigorating, tinged with the promise of endless possibilities. I danced down the street, my heart brimming with excitement and anticipation for the day ahead. Every flower seemed to bloom brighter, every bird sang sweeter, as if nature itself was celebrating my presence.

I spent the morning surrounded by my loved ones, laughter filling the air like music. We shared stories and jokes, basking in the glow of each other's company. Every hug, every smile, filled me with an overwhelming sense of gratitude for the wonderful people in my life.

In the afternoon, I embarked on a grand adventure, exploring new sights and sounds that filled my soul with wonder. I chased butterflies through fields of wildflowers, my spirit soaring with each step. Every moment was a treasure, a precious gift to be cherished forever.

As the sun began to set, painting the sky with hues of pink and gold, I found myself overcome with a sense of profound contentment. I watched in awe as the world around me transformed into a canvas of beauty and magic, a reminder of the infinite wonders that await us each day.

And now, as I write these words by the soft glow of candlelight, I am filled with a deep sense of peace and happiness. For today has been nothing short of perfect, a day filled with love, laughter, and endless joy. And for that, I am eternally grateful.
"""

//supposed to be more sad
//let journalEntry = """
//Today felt like a heavy weight pressing down on my chest, suffocating me with its unbearable sorrow. From the moment I woke up, I could sense the darkness looming over me, casting a shadow on everything I held dear.
//
//As I went about my day, each task felt like a Herculean effort, draining me of whatever little energy I had left. The world around me seemed to have lost its color, replaced by shades of gray and despair. Every sound was muted, every smile felt forced, as if I was merely going through the motions of life.
//
//I found myself lost in a sea of memories, each one a painful reminder of what once was and what could have been. The tears flowed freely, cascading down my cheeks like silent rivers of grief. It felt as though my heart had been shattered into a million pieces, scattered to the winds with no hope of ever being whole again.
//
//I sought solace in the embrace of solitude, seeking refuge from the cacophony of the outside world. But even in the silence, the echoes of my pain reverberated through the emptiness, a constant reminder of the loneliness that consumed me from within.
//
//As the day drew to a close, I retreated into myself, seeking refuge beneath the covers of my bed. The darkness enveloped me like a shroud, offering no respite from the relentless ache in my soul. And as I drifted off to sleep, I prayed for a glimmer of hope to pierce through the darkness and guide me back to the light.
//"""



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
