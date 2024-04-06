//
//  MoodView.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 2/26/24.
//

import SwiftUI
import Charts

class moodClass{
    
    let textProcessor = textProcessing()
    
    struct emotionData{
        let name: String
        let count: Int
    }
    
    func convertToEmotionData(dictionary: [String: Int]) -> [emotionData] {
        var result: [emotionData] = []
        for (name, count) in dictionary {
            let emotion = emotionData(name: name, count: count)
            result.append(emotion)
        }
        return result
    }
    
    func getMoodData() -> [emotionData] {
        let processedData = textProcessor.runProcess()
        return convertToEmotionData(dictionary: processedData)
    }
    
    struct MoodView: View{
        let moodManager = moodClass()
        
        var body: some View {
            let data = moodManager.getMoodData()
            // Use Chart view from Charts framework
            Chart(data, id: \.name) { element in
                SectorMark(
                    angle: .value("Sales", element.count),
                    innerRadius: .ratio(0.618),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Name", element.name))
            }
        }
    }

    struct MoodViewsPreviews: PreviewProvider {
        static var previews: some View {
            MoodView()
        }
    }
}

