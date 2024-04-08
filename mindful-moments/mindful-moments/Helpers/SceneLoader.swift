//
//  SceneLoader.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 4/7/24.
//

import SwiftUI

func loadMindfulMomentsScene() -> some View {
    return AnyView(MindfulMomentsContainer())
}

struct MindfulMomentsContainer: View {
    var body: some View {
        mindful_momentsApp().edgesIgnoringSafeArea(.all)
    }
}
