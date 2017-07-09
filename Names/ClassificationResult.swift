struct ClassificationResult {
  enum Gender: String {
    case male = "M"
    case female = "F"

    var string: String {
      switch self {
      case .male:
        return "Male"
      case .female:
        return "Female"
      }
    }
  }

  let gender: Gender
  let probability: Double
}
