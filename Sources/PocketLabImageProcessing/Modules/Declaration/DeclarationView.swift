

import SwiftUI

struct DeclarationView: View {
    @State private var pinnedContacts: [OptionalArray] = []
    @StateObject private var viewModel = DeclarationViewModel()
    @State private var refreshToggle = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isPopoverPresented: Bool
    var dismissAction: ((OptionalArray) -> Void)
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
                        !pinnedContacts.contains { pinnedVariety in
//                            pinnedContact.id == contact.id
                            return pinnedVariety.id == contact.id && pinnedVariety.id != nil && contact.id != nil

                        }
                    }) { variety in
                        SwipeToPinCell(content: {
                            varietyCard(optionalArray: variety)
                                .onTapGesture {
                                    print("viewModel.selectedOptionalValue")
                                    viewModel.selectedOptionalValue = variety
                                    refreshToggle.toggle()
                                }
                        }, onSwipeToPin: {
                            pinnedContacts.append(variety)
                        }, isSelectedElement: isThisSelectedVariety(variety: variety))
                       
                    }
                }
            }
            .navigationBarTitle("Select Expected Variety", displayMode: .inline)
            .toolbar {
//                EditButton()
                ToolbarItem(placement: .navigationBarTrailing) {
                              Button("Done") {
                                  if viewModel.selectedOptionalValue == nil {
                                      return
                                  } else {
                                      dismissAction(viewModel.selectedOptionalValue!)
                                      isPopoverPresented = false
                                  }
                                  
                              }
                          }
            }
            .navigationTitle("")
        }
        .onAppear() {
            viewModel.getData()
        }
        
        
        func isThisSelectedVariety(variety: OptionalArray?) -> Bool {
            let selectedDataValue = viewModel.selectedOptionalValue?.dataValue ?? ""
            if (selectedDataValue == variety?.dataValue) {
                return true
            } else {
                return false
            }
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
     var isSelectedElement: Bool
    
    init(@ViewBuilder content: @escaping () -> Content, onSwipeToPin: @escaping () -> Void, isSelectedElement: Bool ) {
        self.content = content()
        self.onSwipeToPin = onSwipeToPin
        self.isSelectedElement = isSelectedElement
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
                if isSelectedElement {
                    Spacer()
                    Image(systemName: "checkmark")
                        .resizable()
                        .foregroundColor(.blue)
                        .font(.title)
                        .frame(width: 20, height: 20)
                        .padding(.horizontal, 0)
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeclarationView()
//    }
//}

struct ContentView: View {
    @State private var isSheetPresented = true

    var body: some View {
        Button("Show Declaration View") {
            isSheetPresented.toggle()
        }
        .sheet(isPresented: $isSheetPresented, content: {
            DeclarationView(isPopoverPresented: .constant(false), dismissAction: {_ in })
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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

