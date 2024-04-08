//
//  EditFoodView.swift
//  SampleCoreData
//
//  Created by Federico on 18/02/2022.
// EditEntryView

import SwiftUI
import AVKit

struct EntryView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var entry: FetchedResults<Entry>.Element
    
    @State private var data: EntryData
    
    init(entry: FetchedResults<Entry>.Element) {
        // TODO: Convert NSSet to [Tag]
        //var tagsArray = []
        
        // Convert NSSet to [MediaFile]
        //let mediaFilesArray = []
        
        self.entry = entry
        self._data = State(initialValue: EntryData(name: entry.name ?? "", content: entry.content ?? "", tags: [], mediaFiles: []))
        
    }
        
    var body: some View {
        VStack {
            // Tags
            TagListView(tags: [])
            
            // Media
            if !data.mediaFiles.isEmpty {
                MediaView(mediaPaths: [])
            }
            
            // Text entry
            TextField("Enter your text here", text: $data.content, axis: .vertical).padding()
                .onAppear{
                    data.name = entry.name!
                    data.content = entry.content!
                }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .navigationTitle($data.name)
        .navigationBarItems(trailing:
                                Button(action: {
            DataController().editEntry(entry: entry,
                                       data: EntryData(name: data.name,
                                                       content: data.content,
                                                       tags: [],
                                                       mediaFiles: []),
                                       context: managedObjContext)
            dismiss()
        }) {
            Text("Done")
        })
        
        //.background(Color.primary)
        .padding()
//        .toolbar {
//            ToolbarItem(placement: .keyboard) {
//                HStack {
//                    Button(action: {
//                        //TODO: Add action for adding photo
//                    }) {
//                        Image(systemName: "photo")
//                    }
//                    .padding()
//                    
//                    Button(action: {
//                        //TODO: Add action for adding video
//                    }) {
//                        Image(systemName: "video")
//                    }
//                    .padding()
//                    
//                    Button(action: {
//                        //TODO: Add action for adding audio
//                    }) {
//                        Image(systemName: "mic")
//                    }
//                    .padding()
//                }
//                .foregroundColor(.secondary)
//            }
//        }
    }
}

struct TagListView: View {
    var tags: [Tag]

    var body: some View {
        HStack(spacing: 5) {
            if tags.isEmpty {
                PlaceholderTagView()
            } else {
                ForEach(tags, id: \.self) { tag in
                    TagView(tag: tag)
                }
            }
            
            //add tag button
            Button(action: {
                //TODO: add tag action
            }) {
                Image(systemName: "plus.circle").foregroundColor(.blue).font(.system(size: 14))
            }
            Spacer()
        }
    }
}

struct TagView: View {
    var tag: Tag

    var body: some View {
        Text(tag.name ?? "")
            .font(.system(size: 14))
            .foregroundColor(.white)
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .background(Color.blue)
            .cornerRadius(20)
    }
}

struct PlaceholderTagView: View {
    var body: some View {
        Text("Add Tag")
            .font(.system(size: 14))
            .foregroundColor(.blue)
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundColor(.blue)
            )
    }
}

struct MediaView: View {
    var mediaPaths: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(mediaPaths, id: \.self) { mediaPath in
                    MediaItemView(mediaPath: mediaPath)
                }
            }
            .padding()
        }
    }
}

struct MediaItemView: View {
    var mediaPath: String

    var body: some View {
        if mediaPath.lowercased().hasSuffix("mp4") {
            VideoPlayer(player: AVPlayer(url: URL(fileURLWithPath: mediaPath))).frame(width: 200, height: 150).cornerRadius(8)
        } else if mediaPath.lowercased().hasSuffix("mp3") {
            Text("Audio Player Placeholder").frame(width: 200, height: 150).background(Color.gray).cornerRadius(8)
        } else {
            Image(uiImage: UIImage(contentsOfFile: mediaPath) ?? UIImage()).resizable().aspectRatio(contentMode: .fill).frame(width: 200, height: 150).cornerRadius(8)
        }
    }
}
