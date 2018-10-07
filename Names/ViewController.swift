import UIKit

final class ViewController: UIViewController {
  private lazy var textField: UITextField = self.makeTextField()
  private lazy var resultLabel: UILabel = self.makeResultLabel()
  private let classificationService = ClassificationService()

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Gender detector".uppercased()
    textField.placeholder = "First name"
    resultLabel.text = "-"

    view.backgroundColor = .white
    view.addSubview(textField)
    view.addSubview(resultLabel)

    setupConstraints()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
}

// MARK: - Subviews

private extension ViewController {
  func makeTextField() -> UITextField {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.font = UIFont.systemFont(ofSize: 30)
    textField.returnKeyType = .search
    textField.autocorrectionType = .no
    textField.delegate = self
    return textField
  }

  func makeResultLabel() -> UILabel {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 30)
    label.numberOfLines = 0
    return label
  }
}

// MARK: - Layout

private extension ViewController {
  func setupConstraints() {
    let padding = CGFloat(20)

    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
    textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
    textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
    textField.heightAnchor.constraint(equalToConstant: 70).isActive = true

    resultLabel.translatesAutoresizingMaskIntoConstraints = false
    resultLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: padding).isActive = true
    resultLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
    resultLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
  }
}

// MARK: - Actions

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let firstName = textField.text else {
      return false
    }

    do {
      let result = try classificationService.predictGender(from: firstName)
      show(result: result)
    } catch {
      print(error)
    }

    return false
  }

  private func show(result: ClassificationResult) {
    let paragraph = NSMutableParagraphStyle()
    paragraph.minimumLineHeight = 36

    let titleAttributes: [NSAttributedString.Key: Any] = [
      .font: UIFont.boldSystemFont(ofSize: 22),
      .paragraphStyle: paragraph
    ]

    let valueAttributes: [NSAttributedString.Key: Any] = [
      .font: UIFont.systemFont(ofSize: 22),
      .paragraphStyle: paragraph
    ]

    let string = NSMutableAttributedString()
    string.append(.init(string: "Gender: ", attributes: titleAttributes))
    string.append(.init(string: result.gender.string, attributes: valueAttributes))
    string.append(.init(string: "\n"))
    string.append(.init(string: "Probability: ", attributes: titleAttributes))
    string.append(.init(
      string: "\(result.probability.roundTo(places: 3) * 100.0)%",
      attributes: valueAttributes)
    )

    resultLabel.attributedText = string
  }
}
