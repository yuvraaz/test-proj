

import SwiftUI

var contacts = [
    Contact(name: "Aprilio", jobTitle: "", profileImage: "", isOnline: true),
    Contact(name: "Arezzo", jobTitle: "", profileImage: "", isOnline: false),
    Contact(name: "Cprilio", jobTitle: "", profileImage: "", isOnline: true),
    Contact(name: "Drezzo", jobTitle: "", profileImage: "", isOnline: false),
    // Add more contacts as needed
]

struct DeclarationView: View {
    @State private var pinnedContacts: [Contact] = []

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Pinned")) {
                    ForEach(pinnedContacts) { pinnedContact in
                        ContactCard(contact: pinnedContact)
                    }
                    .onDelete(perform: deletePinnedContact)
                    .onMove { from, to in
                        contacts.move(fromOffsets: from, toOffset: to)
                    }
                    .swipeActions(edge: .leading) {
                        Button(role: .destructive) {
//                            onSwipeToPin()
//                            pinnedContacts.remove(pinnedContact)
                        } label: {
                            Label("Pin", systemImage: "pin.slash.fill")
                                     .font(.title)
                                     .padding()
                                     .foregroundColor(.white)
                                     .background(Color.blue)
                                     .cornerRadius(10)
                        }

                                     }
//                    .onMove { from, to in
////                                        contacts.move(fromOffsets: from, toOffset: to)
//                                    }

//                    .onMove(perform: movePinnedContact)
                }
                
                Section(header: Text("All Varieties")) {
                    ForEach(contacts.filter { !pinnedContacts.contains($0) }) { contact in
                        SwipeToPinCell(content: {
//                            NavigationLink(destination: ContactDetail(contact: contact)) {
                                ContactCard(contact: contact)
//                            }
                        }, onSwipeToPin: {
                            pinnedContacts.append(contact)
                        })
                   
                    }
                   
                }
            }
            .navigationBarTitle("Select Expected Variety", displayMode: .inline)
            .toolbar {
                        // 1
                        EditButton()
                    }
//            .navigationBarItems(trailing: EditButton())
            .navigationTitle("")
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
    var contact: Contact

    var body: some View {
        HStack {
            Image(contact.profileImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(contact.name)
                    .font(.headline)
            }

            Spacer()
        }
        .padding(8)
        .frame(height: 30) // Adjust the height as needed
    }
}

struct ContactDetail: View {
    var contact: Contact

    var body: some View {
        VStack {
            Image(contact.profileImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 150, height: 150)

            Text(contact.name)
                .font(.title)

            Text(contact.jobTitle)
                .font(.headline)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .navigationTitle(contact.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DeclarationView()
    }
}

struct Contact: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var jobTitle: String
    var profileImage: String
    var isOnline: Bool
}

struct ContactCard: View {
    var contact: Contact

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(contact.name)
                        .font(.headline)

                }

                Spacer()
            }
            .padding(8)
            .frame(height: 20)
        }
    }
}

