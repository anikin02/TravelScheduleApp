//
//  RouteStationsService.swift
//  TravelScheduleApp
//
//  Created by Данил on 26/11/2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias RouteStations = Components.Schemas.ThreadStationsResponse

protocol RouteStationsServiceProtocol {
  func getRouteStations(uid: String, date: String?) async throws -> RouteStations
}

final class RouteStationsService: RouteStationsServiceProtocol {
  private let client: Client
  private let apikey: String
  
  init(client: Client, apikey: String) {
    self.client = client
    self.apikey = apikey
  }
  
  func getRouteStations(uid: String, date: String? = nil) async throws -> RouteStations {
    let response = try await client.getRouteStations(query: .init(
      apikey: apikey,
      uid: uid,
      date: date
    ))
    return try response.ok.body.json
  }
}
