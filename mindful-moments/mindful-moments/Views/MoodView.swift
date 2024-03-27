//
//  MoodView.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 2/26/24.
//

import SwiftUI

struct MoodView: View {
    var body: some View {
        VStack{
            VStack {
                HStack{
                    Button(action: {
        //                    put action here
                    }) {
                        Image(systemName: "arrow.backward")
        //                        add customization here
                    }
                    Spacer()
                        .frame(width: 50.0)
                        
                    Text("Dates Shown")
                    Spacer()
                        .frame(width: 50.0)
                    Button(action: {
        //                    put action here
                    }) {
                        Image(systemName: "arrow.forward")
        //                        add customization here
                    }
                }
            }
            .padding(.top)
            Spacer()
        }
    }
}

#Preview {
    MoodView()
}
