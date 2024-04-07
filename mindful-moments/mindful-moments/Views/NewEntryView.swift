import SwiftUI
import AVKit

struct NewEntryView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var data: EntryData
    
    init() {
        self._data = State(initialValue: EntryData(name: "", content: "", tags: [], mediaFiles: []))
        
    }
        
    var body: some View {
        VStack {
            // Tags
            TextField("New Entry", text: $data.name).padding()
                .font(.largeTitle.bold())
            HStack {
                TagListView(tags: [])
                Button(action: {
                    DataController().addEntry(data: EntryData(name: data.name,
                                                               content: data.content,
                                                              tags: [],
                                                              mediaFiles: []),
                                              context: managedObjContext)
                    dismiss()
                }) {
                    Text("Done")
                }
                
            }

            // Media
            if !data.mediaFiles.isEmpty {
                MediaView(mediaPaths: [])
            }

            // Text entry
            ScrollView {
                TextField("Enter your text here", text: $data.content, axis: .vertical).padding()
                    
            }

            Spacer()
        }
        .onAppear{
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            self.data.name = formatter.string(from: Date())
        }
        .frame(maxWidth: .infinity)
        .navigationBarItems(trailing:
                                Button(action: {
                                    DataController().addEntry(data: EntryData(name: data.name,
                                                                               content: data.content,
                                                                              tags: [],
                                                                              mediaFiles: []),
                                                              context: managedObjContext)
                                    dismiss()
                                }) {
                                    Text("Done")
                                })
        .navigationTitle(data.name)
        //.background(Color.primary)
        .padding()
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Button(action: {
                        //TODO: Add action for adding photo
                    }) {
                        Image(systemName: "photo")
                    }
                    .padding()
                    
                    Button(action: {
                        //TODO: Add action for adding video
                    }) {
                        Image(systemName: "video")
                    }
                    .padding()
                    
                    Button(action: {
                        //TODO: Add action for adding audio
                    }) {
                        Image(systemName: "mic")
                    }
                    .padding()
                }
                .foregroundColor(.secondary)
            }
        }
    }
}

