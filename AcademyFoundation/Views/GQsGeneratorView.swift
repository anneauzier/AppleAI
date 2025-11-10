//
//  GQsGeneratorView.swift
//  AcademyFoundation
//
//  Created by Anne Auzier on 07/11/25.
//

import SwiftUI

struct GQsGeneratorView: View {
    
    @State var viewModel: GQsViewModel = GQsViewModel()
    @State var isGenerating: Bool = false
    
    @State var investigate: InvestigatePhase?
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center, spacing: 20) {
                Text("GQ's Generator")
                    .font(.title).bold()
                    TextField("Type your challenge here",
                              text: $viewModel.learningTopic)
                    .textFieldStyle(.roundedBorder)
                    Spacer()
                    Button("Generate") {
                        Task {
                            do {
                                isGenerating.toggle()
                                investigate = try await self.viewModel.generateGQs()
                                isGenerating.toggle()
                            } catch {
                                print("Error in generating guiding questions")
                            }
                        }
                    }.padding()
                    .foregroundStyle(.white)
                    .background(Color.purple).clipShape(Capsule())
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("GQ's Generated")
                            .font(.title2).bold()
                        Spacer()
                        Text("\(investigate?.guidingQuestions.count ?? 0)")
                    }
                    
                    List {
                        ForEach(investigate?.guidingQuestions ?? [], id:\.id) { question in
                            Text(question.questions)
                        }
                    }
                    .listStyle(.plain)
                    .overlay {
                        if isGenerating {
                            VStack {
                                Spacer()
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                Text("Generating GQ's...")
                                    .font(.headline)
                                Spacer()
                            }
                        }
                    }
                }.padding(.top)
            }.padding()
        }
    }
}

#Preview {
    let viewModel = GQsViewModel()

    GQsGeneratorView(viewModel: viewModel, isGenerating: false, investigate: nil)
}
