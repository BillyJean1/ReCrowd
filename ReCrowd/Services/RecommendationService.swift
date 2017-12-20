//
//  RecommendationService.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 19-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import Foundation

class RecommendationService {
    public static let shared = RecommendationService()
    public static let recommendationsUserDefaultKey = "recommendations"

    private init() {
        checkForRecommendations() // This is only for demo. It fires a notification once after opening and immediataly closing the app
    }

    @objc public func checkForRecommendations() {
        if let recommendations = FirebaseService.shared.getEventRecommendations() {
            if let recommendations = FirebaseService.shared.getEventRecommendations() {
                        let checkedInEvent = FirebaseService.shared.getCheckedInEvent(completionHandler: { event in
                            print(event)
                        })
                    }
            let notEqual = compareToSavedRecommendations(recommendations: recommendations)
            if notEqual > 0 {
                NotificationService.shared.sendNotification(
                    withIdentifier: "Nieuwe_Aanbevelingen",
                    withTitle: "ReCrowd - Nieuw aanbevelingen",
                    withBody: "Er zijn \(notEqual) nieuwe aanbevelingen! Ga erna toe om punten te verdienen.")
            }

            self.saveRecommendations(recommendations: recommendations)
        }
    }

    public func getRecommendations() -> [Recommendation]? {
        let data = UserDefaults.standard.object(forKey: RecommendationService.recommendationsUserDefaultKey)
        if let decodedData = data as? Data {
            if let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [Recommendation] {
                return decodedTeams
            }
        }
        return nil
    }

    public func deleteRecommendations() {
        UserDefaults.standard.removeObject(forKey: RecommendationService.recommendationsUserDefaultKey)
    }

    private func saveRecommendations(recommendations: [Recommendation]) {
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: RecommendationService.recommendationsUserDefaultKey) != nil {
            self.deleteRecommendations()
        }

        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: recommendations)
        userDefaults.setValue(encodedData, forKey: RecommendationService.recommendationsUserDefaultKey)
        userDefaults.synchronize()
    }

    /** Returns number of recommendations are not equal */
    private func compareToSavedRecommendations(recommendations: [Recommendation]) -> Int {
        if let savedRecommendations = getRecommendations() {
            let sortedSavedRecommendations = savedRecommendations.sorted(by: { $0.name > $1.name })
            let sortedInputRecommendations = recommendations.sorted(by: { $0.name > $1.name })

            var notEqual = 0
            if sortedSavedRecommendations.count > sortedInputRecommendations.count {
                notEqual = sortedSavedRecommendations.count - sortedInputRecommendations.count
                notEqual += sortRecommendationsAndMeasureDifference(firstList: sortedInputRecommendations, secondList: sortedSavedRecommendations)
                return notEqual

            } else if sortedSavedRecommendations.count < sortedInputRecommendations.count {
                notEqual = sortedInputRecommendations.count - sortedSavedRecommendations.count
                notEqual += sortRecommendationsAndMeasureDifference(firstList: sortedSavedRecommendations, secondList: sortedInputRecommendations)
                return notEqual

            } else {
                return sortRecommendationsAndMeasureDifference(firstList: sortedSavedRecommendations, secondList: sortedInputRecommendations)
            }
        }
        return recommendations.count
    }

    private func sortRecommendationsAndMeasureDifference(firstList: [Recommendation], secondList: [Recommendation]) -> Int {
        var notEqual = 0
        for firstListRecommendation in firstList {
            for secondListRecommendation in secondList {
                if firstListRecommendation.name == secondListRecommendation.name {
                    notEqual = notEqual + 1
                }
            }
        }
        return notEqual
    }
}
