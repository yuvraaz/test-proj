

import SwiftUI

struct DeclarationView: View {
    @State private var pinnedContacts: [OptionalArray] = []
    @StateObject private var viewModel = DeclarationViewModel()
    
    var body: some View {
        Self._printChanges()
        return NavigationView {
            List {
                Section(header: Text("Pinned")) {
                    ForEach(pinnedContacts) { pinnedContact in
                        varietyCard(optionalArray: pinnedContact)
                    }
                    .onDelete(perform: deletePinnedContact)
                    .onMove { from, to in
                        viewModel.optionalArray.move(fromOffsets: from, toOffset: to)
                    }
                    .swipeActions(edge: .leading) {
                        Button(role: .destructive) {
                        } label: {
                            Label("Pin", systemImage: "pin.slash.fill")
                                .font(.title)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                }
                Section(header: Text("All Varieties")) {
                    ForEach(viewModel.optionalArray.filter { contact in
                        !pinnedContacts.contains { pinnedContact in
//                            pinnedContact.id == contact.id
                            return pinnedContact.id == contact.id && pinnedContact.id != nil && contact.id != nil

                        }
                    }) { contact in
                        SwipeToPinCell(content: {
                            varietyCard(optionalArray: contact)
                        }, onSwipeToPin: {
                            pinnedContacts.append(contact)
                        })
                    }
                }
                

                
            }
            .navigationBarTitle("Select Expected Variety", displayMode: .inline)
            .toolbar {
                EditButton()
            }
            .navigationTitle("")
        }
        .onAppear() {
            viewModel.getData()
        }
    }
    
    func deletePinnedContact(at offsets: IndexSet) {
        pinnedContacts.remove(atOffsets: offsets)
    }
    
    func movePinnedContact(from source: IndexSet, to destination: Int) {
        pinnedContacts.move(fromOffsets: source, toOffset: destination)
    }
}

struct SwipeToPinCell<Content: View>: View {
    let content: Content
    let onSwipeToPin: () -> Void
    @State private var isPinning = false
    @State private var leadingOffset: CGFloat = 0
    
    init(@ViewBuilder content: @escaping () -> Content, onSwipeToPin: @escaping () -> Void) {
        self.content = content()
        self.onSwipeToPin = onSwipeToPin
    }
    
    var body: some View {
        ZStack {
            content
            
                .swipeActions(edge: .leading) {
                    Button {
                        onSwipeToPin()
                    } label: {
                        Label("Pin", systemImage: "pin.fill")
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .font(.title)
                            .padding()
                            .cornerRadius(10)
                    }
                    .tint(.blue)
                }
            HStack {
                Spacer()
                Image(systemName: "checkmark")
                    .resizable()
                    .foregroundColor(.blue)
                    .font(.title)
                    .frame(width: 20, height: 20)
                    .padding(.horizontal, 0)
                    .onTapGesture {
                        withAnimation {
                            onSwipeToPin()
                        }
                    }
            }
            .frame(height: 30)
            //            .offset(x: -20)
            .opacity(0.8)
        }
    }
}

struct PinnedContactCard: View {
    var optionalArray: OptionalArray
    
    var body: some View {
        HStack {
            Image("")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(optionalArray.userValue ?? "")
                    .font(.headline)
            }
            
            Spacer()
        }
        .padding(8)
        .frame(height: 30) // Adjust the height as needed
    }
}

struct ContactDetail: View {
    var optionalArray: OptionalArray
    
    var body: some View {
        VStack {
            //            Image(contact.profileImage)
            Image("")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 150, height: 150)
            
            Text(optionalArray.userValue ?? "")
                .font(.title)
            
            Text(optionalArray.userValue ?? "")
                .font(.headline)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
        .navigationTitle(optionalArray.userValue ?? "")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DeclarationView()
    }
}


struct varietyCard: View {
    var optionalArray: OptionalArray
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(optionalArray.userValue ?? "")
                        .font(.headline)
                    
                }
                Spacer()
            }
            .padding(8)
            .frame(height: 20)
        }
    }
}

