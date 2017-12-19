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

    private static let recommendationsUserDefaultKey = "recommendations"
    private static let recommendationCheckInterval = 2 // Interval in seconds
    
    private init() {
        _ = Timer.scheduledTimer(timeInterval: TimeInterval(RecommendationService.recommendationCheckInterval), target: self, selector: #selector(self.checkForRecommendations), userInfo: nil, repeats: true)
    }
    
    @objc func checkForRecommendations() {
        if let recommendations = FirebaseService.shared.getEventRecommendations() {
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
            let sorted = savedRecommendations.sorted(by: { $0.name > $1.name })
            let sortedInputRecommendations = recommendations.sorted(by: { $0.name > $1.name })
            
            var notEqual = 0
            for (index,recommendation) in sortedInputRecommendations.enumerated() {
                if recommendation.name != sorted[index].name {
                    notEqual += 1
                }
            }
            return notEqual
        }
        return recommendations.count
    }
}
