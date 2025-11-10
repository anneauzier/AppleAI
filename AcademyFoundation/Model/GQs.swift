//
//  GQs.swift
//  AcademyFoundation
//
//  Created by Anne Auzier on 07/11/25.
//

import Foundation
import FoundationModels

@Generable(description: "A list of Guiding questions")
struct GQs {
    let id: UUID = UUID()

    @Guide(description: "Questions focused on a specific topic that will be used to encourage students to seek to learn the topic")
    let questions: String
}
