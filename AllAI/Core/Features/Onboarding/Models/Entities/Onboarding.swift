//
//  OnboardingModel.swift
//  AllAI
//
//  Created by hosam abufasha on 20/02/2024.
//

import Foundation

struct Onboarding: Codable, Hashable, Identifiable {
    var id: String {
        title
    }
    var title: String
    var image: String
}
