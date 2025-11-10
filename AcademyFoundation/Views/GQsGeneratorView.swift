//
//  GQsGeneratorView.swift
//  AcademyFoundation
//
//  Created by Anne Auzier on 07/11/25.
//

import SwiftUI

struct GQsGeneratorView: View {
    
    @State var viewModel: GQsViewModel = GQsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                TextField("Type your challenge here",
                          text: $viewModel.learningTopic)
                .textFieldStyle(.roundedBorder)
                Spacer()
                Button {
                    Task { await viewModel.generate() }
                } label: {
                    HStack {
                        if viewModel.isGenerating { ProgressView() }
                        Text("Generate")
                    }
                }.buttonStyle(.borderedProminent).tint(.purple)
                
                GeneratedSection(
                    investigate: viewModel.investigate,
                    isLoading: viewModel.isGenerating
                )
            }
            .padding()
            .navigationTitle("GQ's Generator")
        }
    }
}

struct GeneratedSection: View {
    let investigate: InvestigatePhase?
    let isLoading: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("GQ's Generated")
                    .font(.title2).bold()
                Spacer()
                Text("\(investigate?.guidingQuestions.count ?? 0)")
            }
            
            ZStack {
                if let gqs = investigate?.guidingQuestions {
                    List {
                        ForEach(gqs, id:\.id) { gq in
                            Text(gq.questions)
                        }
                    }.listStyle(.plain)
                } else {
                    if !isLoading {
                        ContentUnavailableView("No GQ's generated yet.", systemImage: "questionmark.circle", description: Text("Digite um tópico e toque em Gerar."))
                    }
                }
                
                if isLoading {
                    LoadingOverlayView()
                }
                
            }
        }
    }
}

struct LoadingOverlayView: View {
    var body: some View {
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

#Preview("Vazio") {
    GQsGeneratorView(viewModel: .init())
}

#Preview("Carregando") {
    let vm = GQsViewModel()
    vm.learningTopic = "Swift"
    vm.isGenerating = true
    return GQsGeneratorView(viewModel: vm)
}
