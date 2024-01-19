//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ehnamuram Enoch on 18/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var selectedNumber = 0
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var currentQuestionCount = 1
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Button(action: {
                    restartQuiz()
                }, label: {
                    Label("Restart", systemImage: "arrow.uturn.forward")
                })
                    .buttonStyle(.bordered)
                    .foregroundStyle(.white)
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button(action: {
                            flagTapped(number)
                        }, label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Text("\(currentQuestionCount)/8")
                    .foregroundStyle(.white)
                    .font(.subheadline.weight(.semibold))
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore, actions: {
            if currentQuestionCount == 8 {
                Button(action: {
                    restartQuiz()
                }, label: {
                    Text("Restart")
                })
            }
            
            Button(action: {
                if currentQuestionCount != 8 {
                    askQuestion()
                } else {
                    discardDialog()
                }
            }, label: {
                Text("Continue")
            })
            
            
        }, message: {
            if (currentQuestionCount != 8) {
                Text("That's the flag of \(countries[selectedNumber])")
            } else {
                Text("You have successfully completed the quiz with a score of \(score), would you like to continue")
            }
        })
    }
    
    func flagTapped(_ number: Int) {
        selectedNumber = number
        if selectedNumber == correctAnswer && currentQuestionCount != 8 {
            scoreTitle = "Correct"
            score += 1
        } else if selectedNumber != correctAnswer && currentQuestionCount != 8 {
            scoreTitle = "Wrong"
        } else {
            scoreTitle = "Congratulations"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        currentQuestionCount += 1
    }
    
    func discardDialog() {
        showingScore = false
    }
    
    func restartQuiz() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
        currentQuestionCount = 1
    }
}

#Preview {
    ContentView()
}
