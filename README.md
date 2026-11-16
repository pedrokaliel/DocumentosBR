# validador-de-cpf

Validação e formatação de **CPF** e **CNPJ** (inclusive o **CNPJ alfanumérico**) em Swift puro, sem dependências.

![Swift 5.9+](https://img.shields.io/badge/Swift-5.9%2B-F05138?logo=swift&logoColor=white)
![Licença MIT](https://img.shields.io/badge/licen%C3%A7a-MIT-blue)
![Sem dependências](https://img.shields.io/badge/depend%C3%AAncias-0-brightgreen)

## Exemplo

```swift
import ValidadorDeCPF

CPF.isValid("529.982.247-25")        // true
CPF.isValid("111.111.111-11")        // false (sequência repetida)
CPF.format("52998224725")            // "529.982.247-25"

CNPJ.isValid("11.222.333/0001-81")   // true
CNPJ.isValid("12.ABC.345/01DE-35")   // true (alfanumérico)
CNPJ.format("12abc34501de35")        // "12.ABC.345/01DE-35"
```

## Recursos

- Valida CPF pelos dígitos verificadores e rejeita sequências repetidas (`000.000.000-00`, `111.111.111-11`, etc.).
- Valida CNPJ numérico e **alfanumérico**, o novo formato adotado pela Receita Federal em 2026.
- Aceita entrada com ou sem pontuação (`.`, `-`, `/` e espaços) e letras em minúsculas.
- Formata documentos válidos com a máscara oficial. Se o documento for inválido, `format` devolve `nil`.
- Swift puro, sem dependências externas e com testes automatizados.

## Instalação

Pelo Swift Package Manager, adicione ao `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/SEU_USUARIO/validador-de-cpf.git", from: "1.0.0")
],
targets: [
    .target(
        name: "SeuApp",
        dependencies: [
            .product(name: "ValidadorDeCPF", package: "validador-de-cpf")
        ]
    )
]
```

No Xcode: **File > Add Package Dependencies...** e cole a URL do repositório.

## API

| Função | Retorno | Descrição |
| --- | --- | --- |
| `CPF.isValid(_:)` | `Bool` | Indica se o CPF é válido. |
| `CPF.format(_:)` | `String?` | CPF com máscara `000.000.000-00`, ou `nil` se for inválido. |
| `CNPJ.isValid(_:)` | `Bool` | Indica se o CNPJ (numérico ou alfanumérico) é válido. |
| `CNPJ.format(_:)` | `String?` | CNPJ com máscara `00.000.000/0000-00`, ou `nil` se for inválido. |

### Sobre o CNPJ alfanumérico

Nos 12 primeiros caracteres do CNPJ são aceitos números e letras (A-Z). Os 2 últimos, que são os dígitos verificadores, continuam sendo sempre numéricos. O cálculo usa o valor ASCII de cada caractere menos 48, então `0`-`9` valem 0 a 9 e `A`-`Z` valem 17 a 42.

## Testes

```bash
swift test
```

Os testes cobrem CPF válido e inválido, formatação, CNPJ numérico e CNPJ alfanumérico.

## Como funciona

**CPF:** cada um dos 2 dígitos verificadores é calculado com uma soma ponderada dos dígitos anteriores, multiplicada por 10, e tomando o resto da divisão por 11 (resto 10 vira 0).

**CNPJ:** os 2 dígitos verificadores usam pesos fixos (`5,4,3,2,9,8,7,6,5,4,3,2` e `6,5,4,3,2,9,8,7,6,5,4,3,2`). O resto da divisão por 11 define o dígito: se for menor que 2, o dígito é 0, senão é `11 - resto`.

## Contribuindo

Issues e pull requests são bem-vindos. Antes de abrir um PR, rode `swift test` e inclua testes para o que você alterou.

## Licença

Distribuído sob a licença MIT. Veja o arquivo [LICENSE](LICENSE).
