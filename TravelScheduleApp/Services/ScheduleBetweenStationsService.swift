//
//  ScheduleBetweenStationsService.swift
//  TravelScheduleApp
//
//  Created by Данил on 26/11/2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleBetweenStations = Components.Schemas.Segments

protocol ScheduleBetweenStationsServiceProtocol {
  func getSchedule(from: String, to: String, date: String?, transportTypes: String?, transfers: Bool?) async throws -> ScheduleBetweenStations
}

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
  private let client: Client
  private let apikey: String
  
  init(client: Client, apikey: String) {
    self.client = client
    self.apikey = apikey
  }
  
  func getSchedule(
    from: String,
    to: String,
    date: String? = nil,
    transportTypes: String? = nil,
    transfers: Bool? = nil
  ) async throws -> ScheduleBetweenStations {
    let response = try await client.getSchedualBetweenStations(query: .init(
      apikey: apikey,
      from: from,
      to: to,
      date: date,
      transport_types: transportTypes,
      transfers: transfers
    ))
    return try response.ok.body.json
  }
}
