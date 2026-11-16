import XCTest
import DocumentosBR

final class DocumentosBRTests: XCTestCase {
    func testCPFValido() {
        XCTAssertTrue(CPF.isValid("529.982.247-25"))
        XCTAssertTrue(CPF.isValid("52998224725"))
    }

    func testCPFInvalido() {
        XCTAssertFalse(CPF.isValid("111.111.111-11"))
        XCTAssertFalse(CPF.isValid("529.982.247-26"))
        XCTAssertFalse(CPF.isValid("123"))
    }

    func testCPFFormat() {
        XCTAssertEqual(CPF.format("52998224725"), "529.982.247-25")
        XCTAssertNil(CPF.format("00000000000"))
    }

    func testCNPJNumerico() {
        XCTAssertTrue(CNPJ.isValid("11.222.333/0001-81"))
        XCTAssertFalse(CNPJ.isValid("11.222.333/0001-82"))
    }

    func testCNPJAlfanumerico() {
        XCTAssertTrue(CNPJ.isValid("12.ABC.345/01DE-35"))
        XCTAssertEqual(CNPJ.format("12abc34501de35"), "12.ABC.345/01DE-35")
        XCTAssertFalse(CNPJ.isValid("12.ABC.345/01DE-36"))
    }
}