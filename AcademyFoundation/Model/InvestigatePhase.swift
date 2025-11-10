//
//  InvestigatePhase.swift
//  AcademyFoundation
//
//  Created by Anne Auzier on 07/11/25.
//

import FoundationModels

@Generable
struct InvestigatePhase {
    @Guide(description: "A list of questions that will be used to guide students in their research")
    var guidingQuestions: [GQs]
}

