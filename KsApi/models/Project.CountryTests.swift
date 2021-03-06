@testable import KsApi
import XCTest

final class ProjectCountryTests: XCTestCase {
  func testEquatable() {
    XCTAssertEqual(Project.Country.us, Project.Country.us)
    XCTAssertNotEqual(Project.Country.us, Project.Country.ca)
    XCTAssertNotEqual(Project.Country.us, Project.Country.au)
    XCTAssertNotEqual(Project.Country.de, Project.Country.es)
  }

  func testDescription() {
    XCTAssertNotEqual(Project.Country.us.description, "")
  }

  func testJsonDecoding_StandardJSON() {
    let decodedCountry = Project.Country.decodeJSONDictionary([
      "country": "US",
      "currency": "USD",
      "currency_symbol": "$",
      "currency_trailing_code": true
    ])

    XCTAssertEqual(.us, decodedCountry.value)

    // swiftlint:disable:next force_unwrapping
    let country = decodedCountry.value!
    XCTAssertEqual(country, Project.Country.decodeJSONDictionary(country.encode()).value)
  }

  func testJsonDecoding_ConfigJSON() {
    let decodedCountry = Project.Country.decodeJSONDictionary([
      "name": "US",
      "currency_code": "USD",
      "currency_symbol": "$",
      "trailing_code": true
    ])

    XCTAssertEqual(.us, decodedCountry.value)

    // swiftlint:disable:next force_unwrapping
    let country = decodedCountry.value!
    XCTAssertEqual(country, Project.Country.decodeJSONDictionary(country.encode()).value)
  }

  func testJsonDecoding_ConfigJSON_SwiftDecodable() {
    let json = """
     { "name": "US",
       "currency_code": "USD",
       "currency_symbol": "$",
       "trailing_code": true
     }
    """

    let data = json.data(using: .utf8)
    if let data = data, let country = try? JSONDecoder().decode(Project.Country.self, from: data) {
      XCTAssertEqual(country, .us)
    } else {
      XCTFail("Project.Country should be successfully decoded")
    }
  }
}
