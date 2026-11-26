//
//  APIKeyStorage.swift
//  TravelScheduleApp
//
//  Created by Данил on 26/11/2026.
//

import Foundation

enum APIKeyStorage {
  static var apiKey: String {
    guard let apiKey = Bundle.main.object(
      forInfoDictionaryKey: "API_KEY"
    ) as? String,
          !apiKey.isEmpty,
          apiKey != "YOUR_API_KEY_HERE" else {
      fatalError("[APIKeyStorage]: API key is missing")
    }
    
    return apiKey
  }
}
