//
//  RecommendationService.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 19-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import Foundation

class RecommendationService {
    
    public func checkForRecommendations() {
        if let recommendations = FirebaseService.shared.getEventRecommendations() {
            
        }
    }
}
