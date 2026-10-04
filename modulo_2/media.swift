import Foundation

let notas: [Double] = [8, 9.4, 8.3, 4.9, 7]
var media: Double = 0
var soma: Double = 0

for i in 0..<notas.count{
    soma += notas[i]
}

media = soma / Double(notas.count)
print(String(format: "média = %.2f", media))
