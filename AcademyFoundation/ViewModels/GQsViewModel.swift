//
//  GQsViewModel.swift
//  AcademyFoundation
//
//  Created by Anne Auzier on 07/11/25.
//

import SwiftUI
import FoundationModels

@Observable
class GQsViewModel {

    var learningTopic: String = ""
    var guidingQuestions: [String] = []
    var isGenerating: Bool = false
    var errorMessage: String?

    var investigate: InvestigatePhase?

    let instructions = "Generate a list os guiding questions following the CBL principles. The output must be  list of questions based on the text description."
    
    func generateGQs() async throws -> InvestigatePhase {
        let topicDescription = learningTopic
        let session = LanguageModelSession(instructions: instructions)
        let result = try await session.respond(to: topicDescription, generating: InvestigatePhase.self)
        
        return result.content
    }
    
    @MainActor
    func generate() async {
        guard learningTopic.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else {
            errorMessage = "Digite um tópico antes de gerar"
            return
        }
        
        isGenerating = true
        defer { isGenerating = false }
        do {
            investigate = try await generateGQs()
        } catch {
            errorMessage = "Sorry :( Houve um erro ao gerar as guiding questions."
        }
    }

}
