//
//  PregnancyStatus.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 8/12/25.
//


import Foundation

// Enums can be moved here to be globally accessible for the flow.
enum PregnancyStatus: String, CaseIterable, Identifiable {
    case yes = "Yes"
    case no = "No"
    case wantToBe = "No, but I want to be"
    case experiencedLoss = "No, I experienced a loss"
    var id: String { self.rawValue }
}

enum YesNoOption: String, CaseIterable, Identifiable {
    case yes = "Yes"
    case no = "No"
    var id: String { self.rawValue }
}

enum WorkingWithMentalHealthProfessional: String, CaseIterable, Identifiable {
    case therapist = "Yes, a therapist"
    case psychologist = "Yes, a psychologist"
    case both = "Yes, both"
    case no = "No"
    var id: String { self.rawValue }
}


@MainActor
class OnboardingData: ObservableObject {
    // All data collected during the flow will live here.
    @Published var pregnancyStatus: PregnancyStatus?
    @Published var isFirstPregnancy: YesNoOption?
    @Published var isPostpartum: YesNoOption?
    @Published var postpartumWeeks: Int?
    @Published var isFirstPostpartumExperience: YesNoOption?
    @Published var workingWithMentalHealthPro: WorkingWithMentalHealthProfessional?
}