//
//  ContentView.swift
//  Beanz
//
//  Created by Yasin on 13.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var menu = Menu()
    @StateObject var history = History()
    @State private var showingAddScreen = false
    @State private var showingAboutScreen = false
    
    var totalCaffeine: Int {
        history.servings.map(\.caffeine).reduce(0,+)
    }
    
    var totalCalories: Int {
        history.servings.map(\.calories).reduce(0,+)
    }
    
    var body: some View {
        NavigationView {
            List {
                if history.servings.isEmpty {
                    Button("Add your first drink") {
                        showingAddScreen = true
                    }
                } else {
                    Section("Summary") {
                        Text("Caffeine: \(totalCaffeine) mg")
//                        Text("Calories: \(totalCalories) mg")
                    }
                    
                    ForEach(history.servings) { serving in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(serving.name)
                                    .font(.headline)
                                Text(serving.description)
                                    .font(.caption)
                            }
                            Spacer()
                            Text("\(serving.caffeine) mg")
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    history.delete(serving)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }

                            Button {
                                withAnimation {
                                    history.reorder(serving)
                                }
                            } label: {
                                Label("Repeat", systemImage: "repeat")
                            }
                            .tint(.blue)
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen, content: MenuView.init)
            .navigationTitle("Beans Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen = true
                    } label: {
                        Label("Add New Drink", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingAboutScreen.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    .fullScreenCover(isPresented: $showingAboutScreen) {
                        AboutView()
                    }
                }
            }
        }
        .environmentObject(menu)
        .environmentObject(history)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
