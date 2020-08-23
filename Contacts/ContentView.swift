//
//  ContentView.swift
//  MovieWatch
//
//  Created by Balaji Sundaram on 21/08/20.
//

import SwiftUI
import CoreData
import ExytePopupView

struct Person : Identifiable {
    var id = UUID()
    var fullName : String
    var roleTitle : String
    var mobileNumber : String
    var emailId : String
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    
//    @FetchRequest(entity: Item.entity(), sortDescriptors: []) var items: FetchedResults<Item>

    @State var persons : [Person] =
        [.init(fullName: "Jackson", roleTitle: "Trainee Engineer", mobileNumber: "9849443463", emailId: "jackson@gmail.com"),
         .init(fullName: "Farkhan",roleTitle: "Python Developer", mobileNumber: "9513264878", emailId: "farkhan@yahoo.com")]

    @State var isPresented : Bool = false
    
    
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
 //   private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(persons) { person in
                        HStack {
                            Image(systemName: "person.crop.circle")
                            VStack.init(alignment: .leading, spacing: nil){
                                    Text("\(person.fullName)")
                                    Text("\(person.roleTitle)")
                            }.padding(EdgeInsets.init(top: 5, leading: 5, bottom: 5, trailing: 0))
                            Spacer()
                            NavigationLink(destination: EditContactView(persons: self.$persons, person: person, didAddPerson: {
                                person in print("Contact Edited")
                            }), label: {
                              
                            })
                        }
                }
                .onDelete(perform: deleteItems)
            } .navigationBarTitle("Contact Details").foregroundColor(.blue).font(.title3)
            .navigationBarItems(
                trailing: Button(action: {
                    print("Add button was tapped")
                    self.isPresented.toggle()
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                }
            ).sheet(isPresented: $isPresented, content: {
                PresentedView(isPresentedModel: self.$isPresented, persons: $persons, didAddPerson: {
                    person in
                    self.persons.append(person)
                })
            })
        }
    }
    
    struct PresentedView : View {
        
        @Binding var isPresentedModel : Bool
        @Binding var persons: [Person]
        @State var fullName = ""
        @State var roleTitle = ""
        @State var mobileNumber = ""
        @State var emailId = ""
        
        var didAddPerson : (Person) -> ()
        
        var body: some View {
            VStack.init(alignment: .center, spacing: nil) {
                Text("Add Contact")
                    .font(.title)
                    .padding(EdgeInsets.init(top: 50, leading: 0, bottom: 30, trailing: 0))
                HStack (spacing: 16) {
                    Text("Full Name ")
                        .font(.title3)
                    TextField("Enter Full Name", text: $fullName)
                        .disableAutocorrection(true)
                }
                .padding(.all,25)
                HStack.init(alignment: .center, spacing: 30)  {
                    Text("Job Title ")
                        .font(.title3)
                    TextField("Enter Job Title", text: $roleTitle)
                        .disableAutocorrection(true)

                }
                .padding(.all,20)
                HStack.init(alignment: .center, spacing: 30)  {
                    Text("Ph. Num")
                        .font(.title3)
                    TextField("Enter Mobile Number", text: $mobileNumber)
                        .keyboardType(.numberPad)
                        .disableAutocorrection(true)

                }
                .padding(.all,25)
                HStack.init(alignment: .center, spacing: 30)  {
                    Text("Email Id ")
                        .font(.title3)
                    TextField("Enter EmailId", text: $emailId)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)

                }
                .padding(.all,25)
                Button(action: {
                    self.persons.append(Person(id: UUID(), fullName: self.fullName, roleTitle: self.roleTitle, mobileNumber: self.mobileNumber, emailId: self.emailId))
//                    self.didAddPerson(
//                        .init(fullName: self.fullName, roleTitle: self.roleTitle, mobileNumber: self.mobileNumber, emailId: self.emailId))
                    print(self.persons.count)
                    self.isPresentedModel.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                            .font(.title3)
                        Text("Add")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(40)
                }
                Button(action: {
                    self.isPresentedModel = false
                }) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left.circle")
                            .font(.title3)
                        Text("Cancel")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(40)
                }
                Spacer()
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding(.all, 16)
        }
        
    }
    
    struct EditContactView : View {
        
        @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

        
        @Binding var persons : [Person]
        var person : Person
        @State var fullName = ""
        @State var roleTitle = ""
        @State var mobileNumber = ""
        @State var emailId = ""
        
        var didAddPerson : (Person) -> ()
        
        
        var body: some View {
            VStack.init(alignment: .center, spacing: nil) {
                Text("Edit Contact")
                    .font(.title)
                    .padding(EdgeInsets.init(top: 50, leading: 0, bottom: 30, trailing: 0))
                HStack (spacing: 16) {
                    Text("Full Name ")
                        .font(.title3)
                    TextField("\(person.fullName)", text: $fullName)
                        .disableAutocorrection(true)

                }
                .padding(.all,25)
                HStack.init(alignment: .center, spacing: 30)  {
                    Text("Job Title ")
                        .font(.title3)
                    TextField("\(person.roleTitle)", text: $roleTitle)
                        .disableAutocorrection(true)

                }
                .padding(.all,20)
                HStack.init(alignment: .center, spacing: 30)  {
                    Text("Ph. Num")
                        .font(.title3)
                    TextField("\(person.mobileNumber)", text: $mobileNumber)
                        .keyboardType(.numberPad)
                        .disableAutocorrection(true)

                }
                .padding(.all,25)
                HStack.init(alignment: .center, spacing: 30)  {
                    Text("Email Id ")
                        .font(.title3)
                    TextField("\(person.emailId)", text: $emailId)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)

                }
                .padding(.all,25)
                Button(action: {
                    self.didAddPerson(
                        .init(fullName: self.fullName, roleTitle: self.roleTitle, mobileNumber: self.mobileNumber, emailId: self.emailId))
                    if let row = self.persons.firstIndex(where: {$0.id == person.id}) {
                        if self.fullName == "" {
                            persons[row].fullName = persons[row].fullName
                        } else {
                            persons[row].fullName = self.fullName
                        }
                        if self.roleTitle == "" {
                            persons[row].roleTitle = persons[row].roleTitle
                        } else {
                            persons[row].roleTitle = self.roleTitle
                        }
                        if self.mobileNumber == "" {
                            persons[row].mobileNumber = persons[row].mobileNumber
                        } else {
                            persons[row].mobileNumber = self.mobileNumber
                        }
                        if self.emailId == "" {
                            persons[row].emailId = persons[row].emailId
                        } else {
                            persons[row].emailId = self.emailId
                        }
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                            .font(.title3)
                        Text("Save")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(40)
                }
                Spacer()
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding(.all, 16)
        }
        
    }
    
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.movieName = String()
            newItem.movieLanguage = String()
            newItem.isWatched = Bool()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            self.persons.remove(atOffsets: offsets)
       //     offsets.map { items[$0] }.forEach($persons.delete)

//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
