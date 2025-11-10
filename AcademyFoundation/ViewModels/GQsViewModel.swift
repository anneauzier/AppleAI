//
//  GQsViewModel.swift
//  AcademyFoundation
//
//  Created by Anne Auzier on 07/11/25.
//

import SwiftUI
import FoundationModels

@Observable
class GQsViewModel {// foundation models com json


    var guidingQuestions: [String]
    
    var learningTopic: String

    init() {
        guidingQuestions = []
        learningTopic = ""
    }

    let instructions = "Generate a list os guiding questions following the CBL principles. The output must be  list of questions based on the text description."
    
    func generateGQs() async throws -> InvestigatePhase {
        let topicDescription = learningTopic
        let session = LanguageModelSession(instructions: instructions)
        let result = try await session.respond(to: topicDescription, generating: InvestigatePhase.self)
        
        return result.content
    }
    
//
//    func featureToEdit(_ feature: String) {
//        featureText = feature
//        featureList.removeAll(where: { $0 == feature})
//    }

}
