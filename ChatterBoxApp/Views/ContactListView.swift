// Javier Guevara

import SwiftUI

// Model for a Contact
struct Contact: Identifiable {
    let id = UUID()
    var name: String
    var phone: String
    var email: String
}

// ViewModel to manage contacts
class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    
    func updateContact(contact: Contact, newName: String, newPhone: String, newEmail: String) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts[index].name = newName
            contacts[index].phone = newPhone
            contacts[index].email = newEmail
        }
    }
    
    func deleteContact(contact: Contact) {
        contacts.removeAll { $0.id == contact.id }
    }
}

// Main View with a list of contacts and option to create a new contact
struct ContactsListView: View {
    @ObservedObject var viewModel = ContactsViewModel()
    @State private var showingAddContactView = false
    
    var body: some View {
        NavigationStack {
            

            List(viewModel.contacts) { contact in
                NavigationLink(destination: ContactDetailView(contact: contact, viewModel: viewModel)) {
                    Text(contact.name)
                }
            }
            .navigationTitle("Contacts")
            .navigationBarItems(trailing: Button(action: {
                showingAddContactView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddContactView) {
                AddContactView(viewModel: viewModel)
            }
        }
    }
}

// View to create a new contact
struct AddContactView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ContactsViewModel
    
    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter name", text: $name)
                }
                Section(header: Text("Phone")) {
                    TextField("Enter phone", text: $phone)
                }
                Section(header: Text("Email")) {
                    TextField("Enter email", text: $email)
                }
            }
            .navigationTitle("New Contact")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                let newContact = Contact(name: name, phone: phone, email: email)
                viewModel.contacts.append(newContact)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

// View to show contact details and provide options to edit or delete the contact
struct ContactDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var contact: Contact
    @ObservedObject var viewModel: ContactsViewModel
    @State private var showingEditContactView = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(contact.name)
                    .font(.largeTitle)
                .padding()
                Spacer()
            }
            HStack {
                Spacer()
                Image(systemName: "\(contact.name[contact.name.startIndex].lowercased()).circle.fill")
                    .resizable()
                    .padding()
                    .frame(width: /*@START_MENU_TOKEN@*/150.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/150.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(.lightBlue)
                Spacer()
            }
            
            
            HStack {
                Image(systemName: "phone.circle.fill")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 40.0, height: /*@START_MENU_TOKEN@*/40.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.lightBlue)
                Text(contact.phone)
                    .font(.subheadline)
                .padding()
                
            }
            .padding(.leading)
            HStack {
                Image(systemName: "envelope.circle.fill")
                    .resizable()
                    .frame(width: /*@START_MENU_TOKEN@*/40.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/40.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.lightBlue)
                Text(contact.email)
                    .font(.subheadline)
                .padding()
                
                
            }
            .padding([.top, .leading])
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    showingEditContactView = true
                }) {
                    Text("Edit")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showingEditContactView) {
                    EditContactView(viewModel: viewModel, contact: contact)
                }
                Button(action: {
                    viewModel.deleteContact(contact: contact)
                    // Dismiss the detail view after deleting
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Delete")
                        .font(.title2)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .padding()
        }
        //.navigationTitle("Contact Details")
    }
}

// View to edit an existing contact
struct EditContactView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ContactsViewModel
    
    var contact: Contact
    @State private var name: String
    @State private var phone: String
    @State private var email: String
    
    init(viewModel: ContactsViewModel, contact: Contact) {
        self.viewModel = viewModel
        self.contact = contact
        _name = State(initialValue: contact.name)
        _phone = State(initialValue: contact.phone)
        _email = State(initialValue: contact.email)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter name", text: $name)
                }
                Section(header: Text("Phone")) {
                    TextField("Enter phone", text: $phone)
                }.keyboardType(.numberPad)
                Section(header: Text("Email")) {
                    TextField("Enter email", text: $email)
                }
            }
            .navigationTitle("Edit Contact")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                viewModel.updateContact(contact: contact, newName: name, newPhone: phone, newEmail: email)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}


// Preview for SwiftUI Canvas
struct ContacstListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView()
    }
}
