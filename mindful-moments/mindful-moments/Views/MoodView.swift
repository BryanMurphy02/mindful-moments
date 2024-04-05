//
//  MoodView.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 2/26/24.
//

import SwiftUI
//import textProcessing

//struct MoodView: View {
//    var body: some View {
//        VStack{
//            VStack {
//                HStack{
//                    Button(action: {
//        //                    put action here
//                    }) {
//                        Image(systemName: "arrow.backward")
//        //                        add customization here
//                    }
//                    Spacer()
//                        .frame(width: 50.0)
//                        
//                    Text("Dates Shown")
//                    Spacer()
//                        .frame(width: 50.0)
//                    Button(action: {
//        //                    put action here
//                    }) {
//                        Image(systemName: "arrow.forward")
//        //                        add customization here
//                    }
//                }
//            }
//            .padding(.top)
//            Spacer()
//        }
//    }
//}
//
//#Preview {
//    MoodView()
//}


let textProcessor = textProcessing()

struct EmotionData {
    let emotions: [String: Int]
}

struct PieChartView: View {
    let data: EmotionData
    
    var body: some View {
        VStack {
            PieChart(data: data.emotions.map { $0.value }, labels: data.emotions.map { $0.key })
                .frame(width: 300, height: 300)
        }
    }
}

//struct PieChart: View {
//    let data: [Int]
//    let labels: [String]
//    let colors: [Color] = [.red, .green, .blue, .orange, .yellow, .purple, .pink, .cyan, .gray, .brown]
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                ForEach(0..<data.count, id: \.self) { index in
//                    PieChartSlice(
//                        startAngle: angle(for: index),
//                        endAngle: angle(for: index + 1),
//                        color: colors[index % colors.count]
//                    )
//                }
//            }
//        }
//    }
//    
//    func angle(for index: Int) -> Angle {
//        guard !data.isEmpty else { return .zero }
//        
//        let total = data.reduce(0, +)
//        let percentage = Double(data[index]) / Double(total)
//        return .degrees(percentage * 360)
//    }
//}

struct PieChart: View {
    let data: [String: Int]
    let colors: [Color] = [.red, .green, .blue, .orange, .yellow, .purple, .pink, .cyan, .gray, .brown]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(data.sorted(by: { $0.value > $1.value }), id: \.key) { emotion, count in
                    PieChartSlice(
                        startAngle: angle(for: emotion),
                        endAngle: angle(for: emotion, count: count),
                        color: colors[self.colorIndex(for: emotion)]
                    )
                }
            }
        }
    }
    
    private func angle(for emotion: String) -> Angle {
        let total = data.values.reduce(0, +)
        let count = data[emotion] ?? 0 // Use default value if emotion is not found
        let percentage = Double(count) / Double(total)
        return .degrees(percentage * 360)
    }
    
    private func angle(for emotion: String, count: Int) -> Angle {
        let total = data.values.reduce(0, +)
        let percentage = Double(count) / Double(total)
        return .degrees(percentage * 360)
    }
    
    private func colorIndex(for emotion: String) -> Int {
        if let index = data.keys.firstIndex(of: emotion) {
            return data.keys.distance(from: data.keys.startIndex, to: index)
        } else {
            // If emotion is not found, return a default index
            return 0
        }
    }
}


struct PieChartSlice: View {
    let startAngle: Angle
    let endAngle: Angle
    let color: Color
    
    var body: some View {
        Path { path in
            let center = CGPoint(x: 150, y: 150)
            path.move(to: center)
            path.addArc(center: center, radius: 150, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
        .fill(color)
    }
}

struct MoodView: View {
//    let emotionData = textProcessor.runProcessExample()

    var body: some View {
        VStack {
            Text("Emotion Distribution")
                .font(.title)
                .padding()
            
            PieChartView(data: textProcessor.runProcessExample())
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView()
    }
}
