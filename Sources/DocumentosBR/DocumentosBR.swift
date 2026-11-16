/// Remove pontuacao comum e deixa tudo em maiusculas.
private func clean(_ text: String) -> [Character] {
    text.uppercased().filter { !".-/ ".contains($0) }.map { $0 }
}

public enum CPF {
    public static func isValid(_ text: String) -> Bool {
        let chars = clean(text)
        guard chars.count == 11,
              chars.allSatisfy({ $0.isASCII && $0.isNumber }) else { return false }
        let d = chars.map { $0.wholeNumberValue! }
        guard Set(d).count > 1 else { return false }
        return d[9] == checkDigit(Array(d[0..<9]))
            && d[10] == checkDigit(Array(d[0..<10]))
    }

    public static func format(_ text: String) -> String? {
        guard isValid(text) else { return nil }
        let c = clean(text)
        return "\(String(c[0..<3])).\(String(c[3..<6])).\(String(c[6..<9]))-\(String(c[9...]))"
    }

    private static func checkDigit(_ base: [Int]) -> Int {
        let start = base.count + 1
        let sum = base.enumerated().reduce(0) { $0 + $1.element * (start - $1.offset) }
        let r = (sum * 10) % 11
        return r == 10 ? 0 : r
    }
}

public enum CNPJ {
    private static let w1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    private static let w2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]

    /// Aceita CNPJ numerico e alfanumerico (12 primeiros caracteres A-Z/0-9, 2 digitos finais).
    public static func isValid(_ text: String) -> Bool {
        let chars = clean(text)
        guard chars.count == 14,
              chars.allSatisfy({ $0.isASCII && ($0.isNumber || $0.isLetter) }),
              chars[12...].allSatisfy({ $0.isNumber }),
              Set(chars).count > 1 else { return false }
        let v = chars.map { Int($0.asciiValue!) - 48 }
        return v[12] == checkDigit(Array(v[0..<12]), w1)
            && v[13] == checkDigit(Array(v[0..<13]), w2)
    }

    public static func format(_ text: String) -> String? {
        guard isValid(text) else { return nil }
        let c = clean(text)
        return "\(String(c[0..<2])).\(String(c[2..<5])).\(String(c[5..<8]))/\(String(c[8..<12]))-\(String(c[12...]))"
    }

    private static func checkDigit(_ base: [Int], _ weights: [Int]) -> Int {
        let sum = zip(base, weights).reduce(0) { $0 + $1.0 * $1.1 }
        let r = sum % 11
        return r < 2 ? 0 : 11 - r
    }
}