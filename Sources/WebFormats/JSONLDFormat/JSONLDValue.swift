public struct JSONLDValue: ExpressibleByNilLiteral, Sendable {
  public let value: String

  init(_ type: JSONLDType) {
    self.value = type.rawValue
  }

  public init(nilLiteral: ()) {
    self.value = ""
  }
}
