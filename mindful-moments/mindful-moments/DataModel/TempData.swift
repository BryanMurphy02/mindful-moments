import Foundation

struct JournalEntry: Identifiable {
    let id: UUID // Unique identifier for each entry
    let date: Date
    let name: String
    let content: String
}

let today = Date()

struct JournalEntries {
    static let entries: [JournalEntry] = [
        JournalEntry(id: UUID(), date: today.addingTimeInterval(-86400 * 1), name: "Morning Reflection", content: "Today has been a rollercoaster of emotions, a wild ride through the peaks and valleys of human experience.Woke up to the warmth of the sun streaming through the window, casting a golden glow across the room. The day held promise, a fresh start filled with endless possibilities. Shared breakfast with family, laughter echoing off the walls like music to my ears. In those moments, happiness felt tangible, a warm blanket wrapping around me, shielding me from the cold world outside.But beneath the surface, a shadow lingered. Today marked the anniversary of losing someone dear, a wound still raw with grief. Memories flooded back, bittersweet and poignant, reminding me of what once was and will never be again. The weight of sadness settled over me like a heavy fog, enveloping me in its embrace.Work was a struggle, frustration bubbling just beneath the surface as I faced one obstacle after another. It felt like swimming against the current, each stroke taking me further from where I wanted to be. Anger simmered in my chest, a fiery inferno threatening to consume me if left unchecked.And then there was the looming uncertainty, a dark cloud hanging over my thoughts like a specter. Fear gnawed at the edges of my consciousness, whispering doubts and what-ifs into the silence of the night. The unknown felt suffocating, like being trapped in a room with no windows or doors.But amidst the chaos, a moment of unexpected joy broke through like a ray of sunshine piercing the storm clouds. A friend surprised me with a thoughtful gesture, a small act of kindness that brought tears to my eyes. It was a reminder that even in the darkest of times, there is light to be found if only we have the courage to look for it.Yet, not everything was sunshine and rainbows. Disgust curled my lip as I scrolled through the news, bombarded by images of injustice and cruelty. It sickened me to see the world in such a state, to know that such ugliness exists alongside the beauty and wonder.As the day draws to a close and I reflect on the tumult of emotions that have washed over me, I am reminded of the complexity of being human. Life is messy and unpredictable, a kaleidoscope of joy and sorrow, anger and fear, surprise and disgust. And though it may be difficult at times, it is this very messiness that makes life worth living."),
        JournalEntry(id: UUID(), date: today, name: "Morning Reflection", content: "Today has been a rollercoaster of emotions, a wild ride through the peaks and valleys of human experience. Woke up to the warmth of the sun streaming through the window, casting a golden glow across the room. The day held promise, a fresh start filled with endless possibilities. Shared breakfast with family, laughter echoing off the walls like music to my ears. In those moments, happiness felt tangible, a warm blanket wrapping around me, shielding me from the cold world outside. But beneath the surface, a shadow lingered. Today marked the anniversary of losing someone dear, a wound still raw with grief. Memories flooded back, bittersweet and poignant, reminding me of what once was and will never be again. The weight of sadness settled over me like a heavy fog, enveloping me in its embrace. Work was a struggle, frustration bubbling just beneath the surface as I faced one obstacle after another. It felt like swimming against the current, each stroke taking me further from where I wanted to be. Anger simmered in my chest, a fiery inferno threatening to consume me if left unchecked. And then there was the looming uncertainty, a dark cloud hanging over my thoughts like a specter. Fear gnawed at the edges of my consciousness, whispering doubts and what-ifs into the silence of the night. The unknown felt suffocating, like being trapped in a room with no windows or doors. But amidst the chaos, a moment of unexpected joy broke through like a ray of sunshine piercing the storm clouds. A friend surprised me with a thoughtful gesture, a small act of kindness that brought tears to my eyes. It was a reminder that even in the darkest of times, there is light to be found if only we have the courage to look for it. Yet, not everything was sunshine and rainbows. Disgust curled my lip as I scrolled through the news, bombarded by images of injustice and cruelty. It sickened me to see the world in such a state, to know that such ugliness exists alongside the beauty and wonder. As the day draws to a close and I reflect on the tumult of emotions that have washed over me, I am reminded of the complexity of being human. Life is messy and unpredictable, a kaleidoscope of joy and sorrow, anger and fear, surprise and disgust. And though it may be difficult at times, it is this very messiness that makes life worth living."),
        JournalEntry(id: UUID(), date: today.addingTimeInterval(-86400 * 2), name: "Productive Workday", content: "Today felt like a whirlwind, a flurry of emotions swirling around me, leaving me both exhilarated and exhausted by the end of it.Started the day with a smile as I basked in the warmth of the morning sun filtering through the curtains. The simple pleasures of a quiet breakfast and a good book filled me with contentment, grounding me in the present moment. It was one of those rare mornings where everything just seemed to fall into place, and for that, I felt grateful.But as the day progressed, so did the weight of sorrow that seemed to hang over me like a dark cloud. Memories of lost loved ones crept into my thoughts, tugging at my heartstrings with a melancholic melody. It's funny how grief can sneak up on you when you least expect it, like a wave crashing against the shore, washing away the façade of strength I had carefully constructed.Work was a mixed bag of emotions, a rollercoaster ride through peaks of triumph and valleys of frustration. There were moments of pride as I tackled challenges head-on, my determination unwavering in the face of adversity. But there were also moments of anger, the simmering frustration boiling over into heated exchanges that left me feeling drained and defeated.And then there was the ever-present undercurrent of fear, a constant companion whispering doubts and insecurities into the recesses of my mind. The uncertainty of the future loomed large, casting a shadow over even the brightest moments of the day. It's hard to shake the feeling of being adrift in a sea of unknowns, the fear of what lies ahead lurking just beneath the surface.But amidst the chaos, there were moments of unexpected joy that took me by surprise, like a beacon of light cutting through the darkness. A spontaneous adventure with friends, a heartfelt conversation with a loved one – these were the moments that reminded me of the beauty and wonder that still exists in the world.Yet, even in the midst of joy, there was a nagging sense of disgust that lingered in the back of my mind. The injustices and inequalities that plague our society weighed heavily on my conscience, leaving a bitter taste in my mouth. It's hard to reconcile the ugliness of the world with the moments of beauty and goodness that I am fortunate enough to experience.As I sit here, pen in hand, reflecting on the tumultuous whirlwind of emotions that have swept through me today, I am struck by the sheer complexity of being human. Life is messy and unpredictable, a delicate balance of highs and lows, joys and sorrows, love and loss. And though it may be tempting to seek solace in the comfort of certainty, it is in embracing the uncertainty of the unknown that we truly discover the depth of our humanity."),
        JournalEntry(id: UUID(), date: today.addingTimeInterval(-86400 * 3), name: "Gratitude Journal", content: "Today was a rollercoaster of emotions, a turbulent journey through the highs and lows of life.The morning started with a burst of happiness, the warmth of the sun and the laughter of loved ones filling my heart with joy. But as the day wore on, sadness crept in like a shadow, reminding me of losses still keenly felt.Work brought its own challenges, frustrations bubbling to the surface as I navigated obstacles with grit and determination. Fear lingered in the background, whispering doubts and insecurities into the corners of my mind.Yet, amidst the chaos, there were moments of surprise and delight, unexpected rays of sunshine breaking through the clouds. And yet, even in the midst of joy, there was a hint of disgust at the injustices of the world. As I reflect on the day, I am reminded of the complexity of human experience, the intricate tapestry of emotions that weave through our lives, shaping who we are and who we will become."),
        JournalEntry(id: UUID(), date: today.addingTimeInterval(-86400 * 4), name: "Creative Inspiration", content: "Today unfolded like a mosaic of emotions, each piece distinct yet interwoven, creating a portrait of the human experience.The morning greeted me with a sense of happiness, the soft light of dawn casting a warm glow over the world. But beneath the surface, a current of sadness lingered, a reminder of past hurts and losses.Work brought its own challenges, frustrations bubbling to the surface as I navigated setbacks and obstacles. Fear whispered in the back of my mind, casting doubt on my abilities and the path ahead.Yet, amidst the struggles, there were moments of surprise and joy, unexpected glimpses of beauty and connection that lifted my spirits. And yet, even in the moments of happiness, there was a twinge of disgust at the injustices and inequalities that persist in the world.As the day draws to a close, I am left with a sense of awe at the complexity of human emotions, the delicate dance of light and shadow that defines our existence."),
        JournalEntry(id: UUID(), date: today.addingTimeInterval(-86400 * 5), name: "Personal Growth", content: "Today felt like a whirlwind of emotions, each one crashing into me with the force of a tidal wave.The morning started off on a high note, with laughter and warmth filling the air as I shared breakfast with loved ones. But as the day wore on, a cloud of sadness descended, casting a somber shadow over my heart.Work brought its own challenges, frustrations bubbling to the surface as I grappled with setbacks and obstacles. Fear whispered in the back of my mind, a constant reminder of the uncertainties that lay ahead.Yet, amidst the chaos, there were moments of surprise and delight that caught me off guard, like unexpected gifts from the universe. And yet, even in the moments of happiness, there was a hint of disgust at the injustices and inequalities that persist in the world.As I reflect on the tumultuous journey of the day, I am reminded of the complexity of human emotions, the delicate balance of light and dark that colors our lives."),
        JournalEntry(id: UUID(), date: today.addingTimeInterval(-86400 * 6), name: "Wellness Check-In", content: "Today has been a whirlwind, a symphony of emotions playing out in the theater of my mind.The morning greeted me with the warmth of the sun, a gentle reminder of the beauty and promise of a new day. But as the hours passed, a cloud of sadness settled over me, casting a shadow on even the brightest moments.Work brought its own challenges, frustrations bubbling up as I wrestled with deadlines and demands. Fear lurked in the corners of my thoughts, whispering doubts and insecurities into the silence of the day.Yet, amidst the chaos, there were moments of unexpected joy that took me by surprise, like tiny sparks of light in the darkness. And yet, even in those moments of happiness, there was a twinge of disgust at the injustices and cruelties of the world.As I sit here, pen in hand, I am reminded of the intricate tapestry of human emotions, the delicate dance of light and shadow that shapes our experiences."),
        JournalEntry(id: UUID(), date: today.addingTimeInterval(-86400 * 7), name: "Reflecting on Achievements", content: "Today felt like a whirlwind of emotions, each one pulling me in a different direction.The morning started with a sense of happiness, the sun casting its golden rays through the window, filling the room with warmth. But as the day unfolded, a wave of sadness washed over me, reminding me of losses I still carry in my heart.Work brought its own challenges, frustrations bubbling to the surface as I navigated through tasks that seemed insurmountable. Fear crept in, whispering doubts about my abilities and the future.Yet, amidst the chaos, there were moments of surprise and joy that lifted my spirits, like unexpected bursts of color in a gray sky. And yet, even in those moments of happiness, there was a hint of disgust at the injustices and inequalities that persist in the world.As I reflect on the day, I am struck by the complexity of human emotions, the way they ebb and flow like the tide. And though the day may have been filled with ups and downs, I am grateful for the richness and depth they bring to life's journey."),
        JournalEntry(id: UUID(), date: today.addingTimeInterval(-86400 * 8), name: "Peaceful Evening", content: "Today unfolded like a mosaic of emotions, each piece adding depth to the canvas of my experience.The morning greeted me with a sense of happiness, the simple pleasure of a cup of coffee warming my soul. But as the day progressed, a cloud of sadness descended, casting a shadow over my thoughts and weighing heavily on my heart.Work brought its own challenges, frustrations bubbling to the surface as I struggled to meet deadlines and expectations. Fear lurked in the corners of my mind, whispering doubts and insecurities that threatened to derail my confidence.Yet, amidst the chaos, there were moments of unexpected joy that brightened even the darkest corners of my day. And yet, even in those moments of happiness, there was a tinge of disgust at the injustices and inequalities that pervade our world.As the day draws to a close, I am reminded of the complexity of human emotions and the delicate balance we must strike between light and dark. And though today may have been a rollercoaster ride of highs and lows, I am grateful for the richness and depth that each emotion brings to my life."),
        JournalEntry(id: UUID(), date: Date().addingTimeInterval(-86400 * 9), name: "No emotion sample", content: "Engaging in mindfulness meditation.")
    ]
}