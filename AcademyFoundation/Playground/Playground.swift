//
//  Playground.swift
//  AcademyFoundation
//
//  Created by Anne Auzier on 06/11/25.
//

import FoundationModels
import Playgrounds

#Playground {
    let model = SystemLanguageModel.default

    // The availability property provides detailed information on the model's state.
    switch model.availability {
        case .available:
            print("Foundation Models is available and ready to go!")

        case .unavailable(.deviceNotEligible):
            print("The model is not available on this device.")

        case .unavailable(.appleIntelligenceNotEnabled):
            print("Apple Intelligence is not enabled in Settings.")

        case .unavailable(.modelNotReady):
            print("The model is not ready yet. Please try again later.")

        case .unavailable(let other):
            print("The model is unavailable for an unknown reason.")
    }
}


#Playground {
//    let instructions = """
//            Your job is to create an itinerary for the user.
//            Each day needs an activity, hotel and restaurant.
//
//            Always include a title, a short description, and a day-by-day plan.
//            """
//
//    let session = LanguageModelSession()
//
//    let response = try await session.respond(to: "Generate a 3-day itinerary to Manaus.")
//
    
    let learningTopic = "Build a game that teaches users about portuguese."
    
    let instructions = "Generate a list os guiding questions following the CBL principles. The output must be  list of questions based on the text description."
    
//    func generateGQs() async throws -> InvestigatePhase {
//        let topicDescription = learningTopic
        let session = LanguageModelSession(instructions: instructions)
        let result = try await session.respond(to: learningTopic, generating: InvestigatePhase.self)
        
//        return result.content
//    }
    
}
