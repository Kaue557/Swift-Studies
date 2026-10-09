import Foundation

// global para ser enxergado pelo while do repeat
var opcao = 0
var contas: [Int: String] = [:] // dicionario para  num de conta e titular

func criarContaAux() -> Bool{
    print("Número da conta:\n> ")
    guard let numConta = readLine(),
          let numero = Int(numConta)
    else {
        print("Número de conta inválido!")
        return false
    }
    print("Titular:\n> ")
    guard let titular = readLine()
    else {
        print("Nome do titular inválido!")
        return false
    }
    return true
}

func criarConta(numero: Int, titular: String, &contas) -> Bool{ // recebe as informações da função auxiliar
    contas[numero] = titular
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
    guard let senha_titular = readLine(),
          let senha = String(senha_titular)
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
          let numero = Int(entrada),
          (1...3).contains(numero)
    else {
        print("Entrada inválida! Digite 1, 2 ou 3.\n")
        continue
    }

    opcao = numero

    switch opcao {
        case 1: print("Criação de Conta:\n")
            if criarConta(){
                print("Conta cadastrada com sucesso!")
            } else {
                print("Não foi possível criar a conta...")
                break
            }
        case 2: print("Entrada:\n")
            if entrar(){
                print("Entrada validada com sucesso!")
            } else {
                print("Não foi possível entrar. Revise suas credenciais!")
            }
        default: print("Saindo...")
    }
} while opcao != 3