import Foundation

var pedidos: [[Double?]] = [
    [45.90, 32.00, nil],
    [89.50, 120.00, 67.80],
    [nil, 15.00, 23.50],
    [200.00, nil, 55.00]
]

func valorBruto(_ pedido: [Double?]) -> Double {
    var soma = 0.0
    for item in pedido {
        if let valorValido = item {
            soma += valorValido
            print("Item foi processado e somado")
        } else {
            print("Encontrado um nil")
        }
    }
    if soma > 0.0{
        return soma
    } else {
        return 0.0
    }
    
}

func calcularDesconto(_ valor: Double) -> Double{
    if valor >= 100{
        return 15.0
    }else if valor >= 50 && valor < 100{
        return 10.0
    }else if valor >= 0 && valor < 50{
        return 0.0
    }else{
        print("Pedido com valor negativo!")
        return 0.0
    }
}

func valorLiquido(desconto: Double, valorBruto: Double) -> Double{
    let resultado = valorBruto * (100-desconto) / 100
    return  resultado
}

func mostrarInfos(numPedido: Int, pedidos: [[Double?]]) {
    let pedidoAtual = pedidos[numPedido - 1]
    let valorB = valorBruto(pedidoAtual)
    let desc = calcularDesconto(valorB)
    let valorL = valorLiquido(desconto: desc, valorBruto: valorB)

    print("""
    PEDIDO: \(numPedido)
    Total bruto: R$ \(String(format: "%.2f", valorB))
    Valor descontado: R$ \(String(format: "%.2f", desc))
    Total a pagar: R$ \(String(format: "%.2f", valorL))
    """)
}

mostrarInfos(numPedido: 1, pedidos: pedidos)