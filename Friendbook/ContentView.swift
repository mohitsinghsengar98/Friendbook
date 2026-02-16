//
//  ContentView.swift
//  Friendbook
//
//  Created by Mohit Sengar on 15/02/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var users : [User] = [User]()

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(users, id: \.id) { usersList in
                    NavigationLink(value: usersList){
                        HStack{
                            Text(usersList.name)
                            Spacer()
                            
                            Text(usersList.isActive ? "Active" : "Inactive")
                                    .font(.headline)
                                    .padding(.horizontal,10).padding(.vertical,5)
                                    .foregroundStyle(.white)
                                    .background(usersList.isActive ? Color.green : Color.gray).clipShape(.capsule)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }.navigationDestination(for: User.self) { userDetail in
                UserDetailView(user: userDetail)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .task {
                if users.isEmpty{
                    do {
                        let usersData = try await fetchJSON()
                        print(users)
                        users.append(contentsOf:usersData)
                    } catch {
                        print(error)
                    }
                }else{
                    print("Preloaded Data - \(users)")
                }
            }
            .navigationTitle("Users")
        } detail: {
            Text("Select an item")
        }
    }
    
    private func fetchJSON() async throws -> [User] {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([User].self, from: data)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
