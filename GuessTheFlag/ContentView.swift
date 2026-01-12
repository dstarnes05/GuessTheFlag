//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daniel Starnes on 1/7/26.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var gameComplete = false
    
    @State private var scoreTitle = ""
    @State private var playerScore = 0
    @State private var questionsAsked = 0
    
    
    struct FlagImage: View {
        var content: String
        
        var body: some View{
            Image(content)
                .clipShape(.capsule)
                .shadow(radius: 5)
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                        
                        
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(content: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(playerScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(playerScore)")
        }
        .alert("Game is complete. Your total score was \(playerScore)!", isPresented: $gameComplete) {
            Button("Start Over", action: resetGame)
        }
    }
    
    func flagTapped(_ number: Int) {
        questionsAsked += 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            playerScore += 1
        }
            else {
                scoreTitle = "Incorrect. That is the flag of \(countries[correctAnswer])"
            }
            if questionsAsked ==  8{
                gameComplete = true
            }
            
            showingScore = true
        }


    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        gameComplete = false
        playerScore = 0
        questionsAsked = 0
    }
}

#Preview {
    ContentView()
}
