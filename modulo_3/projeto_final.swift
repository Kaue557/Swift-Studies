import Foundation

// global para ser enxergado pelo while do repeat
var opcao = 0
var contas: [Int: String] = [:] // dicionario para num de conta e titular

func criarContaAux() -> (Int, String)?{ // devolve uma tupla, se for nil deu "entrada inválida"
    print("Número da conta: ")
    print("> ", terminator: "")
    guard let numConta = readLine(),
          let numero = Int(numConta)
    else {
        print("Número de conta inválido!")
        return nil
    }
    print("Titular: ")
    print("> ", terminator: "")
    guard let titular = readLine(),
          !titular.isEmpty // se titular estiver vazio
    else {
        print("Nome do titular inválido!")
        return nil
    }
    return (numero, titular)
}

func criarConta(numero: Int, titular: String, contas: inout [Int: String]) -> Bool{ // recebe as informações da função auxiliar
    if contas[numero] == nil{
       contas[numero] = titular
       return true
    }else{
       return false
    }
}

func entrar() -> Bool{
    print("Número da conta:\n> ")
    guard let numConta = readLine(),
          let numero = Int(numConta)
    else {
        print("Número de conta inválido!")
        return false
    }
    print("Senha: ")
    guard let senha_titular = readLine()
    else {
        print("Senha invalida")
        return false
    }
    return true
}

func depositar(){

}

repeat {
    print("""
    ================
    CAIXA ELETRÔNICO
    ================

    1. Criar Conta
    2. Entrar
    3. Sair
    """)
    print("> ", terminator: "")

    // confere as três condições, se qualquer uma falhar, vai pro else e volta pra leitura
    guard let entrada = readLine(),
          let escolha = Int(entrada),
          (1...3).contains(numero)
    else {
        print("Entrada inválida! Digite 1, 2 ou 3.\n")
        continue
    }

    opcao = numero

    switch opcao {
        case 1:
            print("Criação de Conta:\n")
            if let (numero, titular) = criarContaAux(){ // desembrulhando
                if criarConta(numero: numero, titular: titular, contas: &contas){ // recebido da função aux
                    print("Conta cadastrada com sucesso!") // apenas print por enquanto
                }else{
                    print("Não foi possível criar a conta...")
                }
            }

        case 2:
            print("Entrada:\n")
            

        default: print("Saindo...")
    }

} while opcao != 3