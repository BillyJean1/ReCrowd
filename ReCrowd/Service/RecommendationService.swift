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
    public static let recommendationSavedKey = "saved_recommendation"

    private init() {}

    @objc public func checkForRecommendations(completionHandler: @escaping (_ recommendations: [Recommendation]?) -> ()) {
        FirebaseService.shared.getEventRecommendations(completionHandler: { [weak weakSelf = self] (data) in
            if let recommendations = data {
                if let notEqual = weakSelf?.compareToSavedRecommendations(recommendations: recommendations) {
                    if notEqual > 0 {
                        NotificationService.shared.sendNotification(
                            withIdentifier: "Nieuwe_Aanbevelingen",
                            withTitle: "ReCrowd - Nieuw aanbevelingen",
                            withBody: "Er zijn \(notEqual) nieuwe aanbevelingen! Ga erna toe om punten te verdienen.")
                    }
                }
                weakSelf?.saveRecommendations(recommendations: recommendations)
                completionHandler(weakSelf?.getRecommendations())
            }
        })
    }
    
    public func stopStartedRecommendation() {
        deleteRecommendations(forKey: RecommendationService.recommendationSavedKey)
    }

    public func getRecommendations() -> [Recommendation]? {
        let data = UserDefaults.standard.object(forKey: RecommendationService.recommendationsUserDefaultKey)
        if let decodedData = data as? Data {
            if let decodedRecommendations = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [Recommendation] {
                return decodedRecommendations
            }
        }
        return nil
    }
    
    public func getStartedRecommendation() -> Recommendation?  {
        let userDefaults = UserDefaults.standard
        let data = userDefaults.object(forKey: RecommendationService.recommendationSavedKey)
        if let decodedData = data as? Data {
            if let decodedRecommendation = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? Recommendation {
                return decodedRecommendation
            }
        }
        return nil
    }
    
    public func startRecommendation(recommendation: Recommendation) {
        deleteRecommendations(forKey: RecommendationService.recommendationsUserDefaultKey)
        
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: RecommendationService.recommendationSavedKey) != nil {
            deleteRecommendations(forKey: RecommendationService.recommendationSavedKey)
        }
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: recommendation)
        userDefaults.setValue(encodedData, forKey: RecommendationService.recommendationSavedKey)
        userDefaults.synchronize()
    }

    public func deleteRecommendations(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }

    private func saveRecommendations(recommendations: [Recommendation]) {
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: RecommendationService.recommendationsUserDefaultKey) != nil {
            self.deleteRecommendations(forKey: RecommendationService.recommendationsUserDefaultKey)
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
