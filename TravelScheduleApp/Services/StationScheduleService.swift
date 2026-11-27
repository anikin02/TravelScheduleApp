//
//  StationScheduleService.swift
//  TravelScheduleApp
//
//  Created by Данил on 26/11/2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias StationSchedule = Components.Schemas.ScheduleResponse

protocol StationScheduleServiceProtocol {
  func getStationSchedule(station: String, date: String?, transportTypes: String?) async throws -> StationSchedule
}

final class StationScheduleService: StationScheduleServiceProtocol {
  private let client: Client
  private let apikey: String
  
  init(client: Client, apikey: String) {
    self.client = client
    self.apikey = apikey
  }
  
  func getStationSchedule(
    station: String,
    date: String? = nil,
    transportTypes: String? = nil
  ) async throws -> StationSchedule {
    let response = try await client.getStationSchedule(query: .init(
      apikey: apikey,
      station: station,
      date: date,
      transport_types: transportTypes
    ))
    return try response.ok.body.json
  }
}
