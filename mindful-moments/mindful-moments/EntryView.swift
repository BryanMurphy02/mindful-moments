///**
// View for existing entries
// 
// - Authors:
//    Nicholas LoPilato, Bryan Murphy
// 
// - Version: 0.5
// */
//
//
//import SwiftUI
//import AVKit
//
//struct EntryView: View {
//    // Managed Object Context for CoreData
//    @Environment(\.managedObjectContext) private var viewContext
//    @Environment(\.dismiss) var dismiss
//    
//    // State variables
//    @State var name: String
//    @State var entryContent: String
//    @State var tags: [String]
//    @State var mediaPaths: [String]
//    
//    var body: some View {
//        VStack {
//            // Top bar
//            EntryTopBarView(name: name, saveAction: {
//                //TODO: save action
//                DataController().addEntry(name: name, context: viewContext)
//                dismiss()
//            }, backAction: {})
//
//            // Divider line
//            Divider().background(Color.gray).padding(.bottom)
//
//            // Tags
//            TagListView(tags: tags)
//
//            // Media
//            if !mediaPaths.isEmpty {
//                MediaView(mediaPaths: mediaPaths)
//            }
//
//            // Text entry
//            ScrollView {
//                TextField("Enter your text here", text: $entryContent).padding()
//            }
//
//            Spacer()
//        }
//        .frame(maxWidth: .infinity)
//        .background(Color.white)
//        .cornerRadius(20)
//        .padding()
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
//                .foregroundColor(.primary)
//            }
//        }
//    }
//}
//
//struct EntryTopBarView: View {
//    var name: String
//    var saveAction: () -> Void
//    var backAction: () -> Void
//
//    var body: some View {
//        HStack {
//            // Back button
//            Button(action: backAction) {
//                Image(systemName: "chevron.left").padding(5)
//            }
//
//            // Date title
//            Text(name)
//
//            Spacer()
//
//            // Done button
//            Button(action: saveAction) {
//                Text("Done").padding(5)
//            }
//        }
//    }
//}
//
//struct TagListView: View {
//    var tags: [String]
//
//    var body: some View {
//        HStack(spacing: 5) {
//            if tags.isEmpty {
//                PlaceholderTagView()
//            } else {
//                ForEach(tags, id: \.self) { tag in
//                    TagView(tagName: tag)
//                }
//            }
//            
//            //add tag button
//            Button(action: {
//                //TODO: add tag action
//            }) {
//                Image(systemName: "plus.circle").foregroundColor(.blue).font(.system(size: 14))
//            }
//            Spacer()
//        }
//    }
//}
//
//struct TagView: View {
//    var tagName: String
//
//    var body: some View {
//        Text(tagName)
//            .font(.system(size: 14))
//            .foregroundColor(.white)
//            .padding(.horizontal, 4)
//            .padding(.vertical, 2)
//            .background(Color.blue)
//            .cornerRadius(20)
//    }
//}
//
//struct PlaceholderTagView: View {
//    var body: some View {
//        Text("Add Tag")
//            .font(.system(size: 14))
//            .foregroundColor(.blue)
//            .padding(.horizontal, 4)
//            .padding(.vertical, 2)
//            .overlay(
//                RoundedRectangle(cornerRadius: 20)
//                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
//                    .foregroundColor(.blue)
//            )
//    }
//}
//
//struct MediaView: View {
//    var mediaPaths: [String]
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 10) {
//                ForEach(mediaPaths, id: \.self) { mediaPath in
//                    MediaItemView(mediaPath: mediaPath)
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//struct MediaItemView: View {
//    var mediaPath: String
//
//    var body: some View {
//        if mediaPath.lowercased().hasSuffix("mp4") {
//            VideoPlayer(player: AVPlayer(url: URL(fileURLWithPath: mediaPath))).frame(width: 200, height: 150).cornerRadius(8)
//        } else if mediaPath.lowercased().hasSuffix("mp3") {
//            Text("Audio Player Placeholder").frame(width: 200, height: 150).background(Color.gray).cornerRadius(8)
//        } else {
//            Image(uiImage: UIImage(contentsOfFile: mediaPath) ?? UIImage()).resizable().aspectRatio(contentMode: .fill).frame(width: 200, height: 150).cornerRadius(8)
//        }
//    }
//}
//
//// Preview
//struct EntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryView(name: "New Entry", entryContent: "asdfasdf", tags: ["Tag 1", "Tag 2", "Tag 3"], mediaPaths: [])
//    }
//}
