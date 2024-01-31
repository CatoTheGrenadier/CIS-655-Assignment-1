//
//  ContentView.swift
//  Assignment_1
//
//  Created by Yi Ling on 1/31/24.
//

import SwiftUI

struct numberGame: View {
    @StateObject private var quizViewModel = QuizViewModel()
    
    var body: some View {
        VStack {
            Text("")
                .padding(10)
            if let firstNumber = quizViewModel.firstNumber, let secondNumber = quizViewModel.secondNumber,
                quizViewModel.totalCounts > 0
            {
                Text("\(firstNumber) + \(secondNumber)")
                    .font(.title)
                    .padding(20)
            } else {
                Text("Expression")
                    .font(.title)
                    .padding(20)
            }
            
            Text("=")
                .padding(40)
            
            
            if let solution = quizViewModel.solution,
               quizViewModel.totalCounts > 0
                {
                if quizViewModel.showOrNot == 1{
                    Text("\(solution)")
                        .font(.title)
                }else{
                    Text("?")
                        .font(.title)
                }
            } else {
                Text("Solution")
                    .font(.title)
            }
            
            Button(action: {
                quizViewModel
                    .unfoldSum()
            }){
                Text("Solve")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
            
            Spacer()
            
            HStack {
                Spacer()
                let totalCounts = quizViewModel.totalCounts
                Text("\(totalCounts) Round\(totalCounts < 2 ? "" : "s")") .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Button(action: {
                    quizViewModel.generateNumbers()
                }) {
                    Text("Play \(quizViewModel.totalCounts <= 0 ? "" : "Again")")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding()
                
                Spacer()
            }
        }
        .padding()
        .background(Color.brown)
    }
}

class QuizViewModel: ObservableObject {
    @Published var firstNumber: Int?
    @Published var secondNumber: Int?
    @Published var solution: Int?{
        didSet{
            totalCounts += 1
        }
    }
    @Published var totalCounts: Int = -1
    @Published var showOrNot: Int = 0
    
    init() {
        generateNumbers()
    }
    
    func generateNumbers() {
        firstNumber = Int.random(in: 0...100)
        secondNumber = Int.random(in: 0...100)
        solution = firstNumber.map { $0 + (secondNumber ?? 0) }
        showOrNot = 0
    }
    
    func unfoldSum(){
        showOrNot = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        numberGame()
    }
}

