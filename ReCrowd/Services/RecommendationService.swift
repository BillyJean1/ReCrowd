//
//  RecommendationService.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 19-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import Foundation

class RecommendationService {
    
    public static var shared = RecommendationService()
    
    private init() {
        
    }
    
    public func checkForRecommendations() {
        print("RecommendationService :: checkForRecommendations()")
        if let recommendations = FirebaseService.shared.getEventRecommendations() {
            let checkedInEvent = FirebaseService.shared.getCheckedInEvent()
        }
    }
}
