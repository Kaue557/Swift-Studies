var valor: Int = 34217
var valor_inicial = valor

let quant200 = valor / 200
valor = valor % 200

let quant100 = valor / 100
valor = valor % 100

let quant50 = valor / 50
valor = valor % 50

let quant20 = valor / 20
valor = valor % 20

let quant10 = valor / 10
valor = valor % 10

let quant5 = valor / 5
valor = valor % 5

let quant2 = valor / 2
valor = valor % 2

let quant1 = valor

print("""
Valor = R$\(valor_inicial)
Cédulas de R$200: \(quant200)
Cédulas de R$100: \(quant100)
Cédulas de R$50: \(quant50)
Cédulas de R$20: \(quant20)
Cédulas de R$10: \(quant10)
Cédulas de R$5: \(quant200)
Cédulas de R$2: \(quant2)
Moedas de R$1: \(quant1)
""")