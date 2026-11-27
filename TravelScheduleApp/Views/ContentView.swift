//
//  ContentView.swift
//  TravelScheduleApp
//
//  Created by Данил on 26/11/2026.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
  @State var selectedTab: Int = 0
  
  var body: some View {
    TabView(selection: $selectedTab) {
      MainView()
        .tabItem {
          Image(.mainTab)
        }
        .tag(0)
      
      SettingView()
        .tabItem {
          Image(.settingTab)
        }
        .tag(1)
      
    }
  }
  
  func testFetchStations() {
    Task {
      do {
        let client = Client(
          serverURL: try Servers.Server1.url(),
          transport: URLSessionTransport()
        )
        
        let service = NearestStationsService(
          client: client,
          apikey: APIKeyStorage.apiKey
        )
        
        print("Fetching stations...")
        let stations = try await service.getNearestStations(
          lat: 59.864177,
          lng: 30.319163,
          distance: 50
        )
        
        print("Successfully fetched stations: \(stations)")
      } catch {
        print("Error fetching stations: \(error)")
      }
    }
  }
  func testFetchCopyright() {
    Task {
      do {
        let client = Client(
          serverURL: try Servers.Server1.url(),
          transport: URLSessionTransport()
        )
        let service = CopyrightService(client: client,
                                       apikey: APIKeyStorage.apiKey)
        print("Fetching copyright...")
        let copyright = try await service.getCopyright()
        print("Successfully fetched copyright: \(copyright)")
      } catch {
        print("Error fetching copyright: \(error)")
      }
    }
  }
  func testFetchAllStations() {
    Task {
      do {
        let client = Client(
          serverURL: try Servers.Server1.url(),
          transport: URLSessionTransport()
        )
        
        let service = AllStationsService(
          client: client,
          apikey: APIKeyStorage.apiKey
        )
        
        print("Fetching all stations...")
        let stations = try await service.getAllStations()
        print("Countries: \(stations.countries?.count ?? 0)")
        print("Successfully fetched stations: \(stations)")
      } catch {
        print("Error fetching stations: \(error)")
      }
    }
  }
  func testFetchScheduleBetweenStations() {
    Task {
      do {
        let client = Client(
          serverURL: try Servers.Server1.url(),
          transport: URLSessionTransport()
        )
        
        let service = ScheduleBetweenStationsService(
          client: client,
          apikey: APIKeyStorage.apiKey
        )
        
        print("Fetching schedule between stations...")
        let schedule = try await service.getSchedule(
          from: "c2",
          to: "c213",
          date: "2026-12-01"
        )
        
        print("Successfully fetched schedule: \(schedule)")
      } catch {
        print("Error fetching schedule: \(error)")
      }
    }
  }
  func testFetchStationSchedule() {
    Task {
      do {
        let client = Client(
          serverURL: try Servers.Server1.url(),
          transport: URLSessionTransport()
        )
        
        let service = StationScheduleService(
          client: client,
          apikey: APIKeyStorage.apiKey
        )
        
        print("Fetching station schedule...")
        let schedule = try await service.getStationSchedule(
          station: "s9600213",
          date: "2026-12-01"
        )
        
        print("Successfully fetched station schedule: \(schedule)")
      } catch {
        print("Error fetching station schedule: \(error)")
      }
    }
  }
  func testFetchRouteStations() {
    Task {
      do {
        let client = Client(
          serverURL: try Servers.Server1.url(),
          transport: URLSessionTransport()
        )
        
        let scheduleService = ScheduleBetweenStationsService(
          client: client,
          apikey: APIKeyStorage.apiKey
        )
        let schedule = try await scheduleService.getSchedule(
          from: "c2",
          to: "c213",
          date: "2026-12-01"
        )
        guard let uid = schedule.segments?.first?.thread?.uid else {
          print("No thread uid found in schedule")
          return
        }
        
        let service = RouteStationsService(
          client: client,
          apikey: APIKeyStorage.apiKey
        )
        
        print("Fetching route stations for \(uid)...")
        let route = try await service.getRouteStations(
          uid: uid,
          date: "2026-12-01"
        )
        
        print("Successfully fetched route stations: \(route)")
      } catch {
        print("Error fetching route stations: \(error)")
      }
    }
  }
  func testFetchNearestCity() {
    Task {
      do {
        let client = Client(
          serverURL: try Servers.Server1.url(),
          transport: URLSessionTransport()
        )
        
        let service = NearestCityService(
          client: client,
          apikey: APIKeyStorage.apiKey
        )
        
        print("Fetching nearest city...")
        let city = try await service.getNearestCity(
          lat: 59.864177,
          lng: 30.319163,
          distance: 50
        )
        
        print("Successfully fetched nearest city: \(city)")
      } catch {
        print("Error fetching nearest city: \(error)")
      }
    }
  }
  func testFetchCarrierInfo() {
    Task {
      do {
        let client = Client(
          serverURL: try Servers.Server1.url(),
          transport: URLSessionTransport()
        )
        
        let service = CarrierInfoService(
          client: client,
          apikey: APIKeyStorage.apiKey
        )
        
        print("Fetching carrier info...")
        let carrier = try await service.getCarrierInfo(
          code: "26",
          system: "yandex"
        )
        
        print("Successfully fetched carrier info: \(carrier)")
      } catch {
        print("Error fetching carrier info: \(error)")
      }
    }
  }
}

#Preview {
  ContentView()
}
