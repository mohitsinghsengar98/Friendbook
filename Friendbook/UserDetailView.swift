//
//  FriendDetailView.swift
//  Friendbook
//
//  Created by Mohit Sengar on 15/02/26.
//

import SwiftUI

struct UserDetailView: View {
    let user: User

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                infoBlock(title: "Name", value: user.name)
                infoBlock(title: "Age", value: "\(user.age)")
                infoBlock(title: "Company", value: user.company)
                infoBlock(title: "Email", value: user.email)
                infoBlock(title: "Address", value: user.address)
                infoBlock(title: "About", value: user.about)
                infoBlock(title: "Registered", value: user.registered.formatted(date: .long, time: .shortened))
                
                tagSection(title: "Tags", items: user.tags)
                tagSection(title: "Friends", items: user.friends.map { $0.name })
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Reusable Views

    @ViewBuilder
    func infoBlock(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(title):")
                .font(.headline)
            Divider()
                .background(Color.gray.opacity(0.3))
            Text(value)
        }
    }

    @ViewBuilder
    func tagSection(title: String, items: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack{
                Text("\(title):")
                    .font(.headline)
                Spacer()
                Text("\(items.count)").font(.headline).padding(.vertical, 5).padding(.horizontal, 10).background(.gray).foregroundStyle(.white).clipShape(.capsule)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                            .font(.headline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                Color(red: 144/255, green: 213/255, blue: 255/255)
                            )
                            .clipShape(.capsule)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    let userConstant = User(id: "id001", isActive: true, name: "Saurav", age: 25, company: "Random Company . Inc", email: "randomEmail@gmail.com", address: "7668/25A, Random address, New York, USA", about: "Random About me text which is used to view the about section details in the demo prototype for the section. Random About me text which is used to view the about section details in the demo prototype for the section. Random About me text which is used to view the about section details in the demo prototype for the section.", registered: .now, tags: ["egduwh","ekuhdiuwen","lweh","eu","jekwhdi"], friends: [Friend(id: "id000001", name: "jhdchwec jehdd"),Friend(id: "id000002", name: "kmdlkwq jekxjnjkhdd"),Friend(id: "id000003", name: "wkjnkqw wlkjslkqw"),Friend(id: "id000004", name: "kwqjns wqkjns"),Friend(id: "id000005", name: "wlksjqwl wqksnqw")])
    UserDetailView(user: userConstant)
}
