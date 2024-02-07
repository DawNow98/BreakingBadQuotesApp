//
//  ContentView.swift
//  Quotes
//
//  Created by Dawid Nowacki on 04/02/2024.
//

import SwiftUI

struct Quote: Hashable, Codable {
    var quote: String
    var author: String
}

struct ContentView: View {
    
    @State private var quotes = [Quote]()
    
    var body: some View {
        NavigationView {
            List(quotes, id: \.self) { quote in
                VStack {
                    Text(quote.quote)
                        .font(.headline)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .lineLimit(5)
                        .fixedSize(horizontal: false, vertical: false)
                        //.frame(width: 200, height: 50)
                        .padding()
                    Text(quote.author)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Quotes")
            .onAppear {
                fetchData()
            }
        }
    }
    
    func fetchData() {
        guard let url = URL(string: "https://api.breakingbadquotes.xyz/v1/quotes/5") else {
            print("Invalid URL")
            return
        }
        
        Task.init {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                if let decodedResponse = try? JSONDecoder().decode([Quote].self, from: data) {
                    quotes = decodedResponse
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
