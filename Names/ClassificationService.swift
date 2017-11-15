import CoreML

final class ClassificationService {
  enum Error: Swift.Error {
    case unknownGender
    case probabilityMissing(gender: ClassificationResult.Gender)
  }

  private let model = NamesDT()

  // MARK: - Prediction

  func predictGender(from firstName: String) throws -> ClassificationResult {
    let output = try model.prediction(input: features(from: firstName))

    guard let gender = ClassificationResult.Gender(rawValue: output.classLabel) else {
      throw Error.unknownGender
    }

    guard let probability = output.classProbability[output.classLabel] else {
      throw Error.probabilityMissing(gender: gender)
    }

    return ClassificationResult(gender: gender, probability: probability)
  }
}

// MARK: - Features

private extension ClassificationService {
  func features(from string: String) -> [String: Double] {
    guard !string.isEmpty else {
      return [:]
    }

    let string = string.lowercased()
    var keys = [String]()

    keys.append("first-letter=\(string.prefix(1))")
    keys.append("first2-letters=\(string.prefix(2))")
    keys.append("first3-letters=\(string.prefix(3))")
    keys.append("last-letter=\(string.suffix(1))")
    keys.append("last2-letters=\(string.suffix(2))")
    keys.append("last3-letters=\(string.suffix(3))")

    return keys.reduce([String: Double]()) { (result, key) -> [String: Double] in
      var result = result
      result[key] = 1.0
      return result
    }
  }
}
