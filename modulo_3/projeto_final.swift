import Foundation

struct Conta{
    var numero: Int
    var titular: String
    var senha: String
    var saldo: Double
    var ehAdmin: Bool
}

// global para ser enxergado pelo while do repeat
var opcao = 0
// dicionario: chave = número da conta, valor = a conta inteira
// o admin já nasce cadastrado (conta 0, senha "admin")
var contas: [Int: Conta] = [
    0: Conta(numero: 0, titular: "Admin", senha: "admin", saldo: 0, ehAdmin: true)
]

// CRIAR CONTA ========================
func criarContaAux() -> (Int, String, String, Double)?{ // devolve uma tupla, se for nil deu "entrada inválida"
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

    print("Senha: ")
    print("> ", terminator: "")
    guard let senha = readLine(),
          !senha.isEmpty // se senha estiver vazio
    else {
        print("Senha inválida!")
        return nil
    }

    print("Saldo inical: ")
    print("> ", terminator: "")
    guard let textoSaldo = readLine(),
          let saldo = Double(textoSaldo),
          saldo >= 0
    else {
        print("Saldo inválido!")
        return nil
    }

    return (numero, titular, senha, saldo)
}

// apenas lógica; recebe os dados já prontos da função auxiliar
func criarConta(numero: Int, titular: String, senha: String, saldo: Double, contas: inout [Int: Conta]) -> Bool{
    // regra de negócio: número de conta não pode se repetir e saldo não pode ser negativo
    if contas[numero] == nil && saldo >= 0{
        // contas criadas pelo usuário nunca são admin
        contas[numero] = Conta(numero: numero, titular: titular, senha: senha, saldo: saldo, ehAdmin: false)
        return true
    }else{
        return false
    }
}

// ENTRAR =========================
func entrarAux() -> (Int, String)?{
    print("Número da conta: ")
    print("> ", terminator: "")
    guard let numConta = readLine(),
          let numero = Int(numConta)
    else {
        print("Número de conta inválido!")
        return nil
    }

    print("Senha: ")
    print("> ", terminator: "")
    guard let senha_titular = readLine(),
          !senha.isEmpty
    else {
        print("Senha invalida!")
        return nil
    }
    return (numero, senha_titular)
}

// apenas lógica; autentica o usuário
// devolve a Conta se as credenciais estiverem corretas, ou nil se falhar
func entrar(numero: Int, senha: String, contas: [Int: Conta]) -> Conta?{
    // 1. a conta existe? (contas[numero] é opcional; o guard let desembrulha)
    // 2. a senha digitada é igual à senha cadastrada?
    guard let conta = contas[numero],
          conta.senha == senha
    else {
        return nil // mesma resposta para "conta não existe" e "senha errada"
    }
    return conta
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
          (1...3).contains(escolha)
    else {
        print("Entrada inválida! Digite 1, 2 ou 3.\n")
        continue
    }

    opcao = escolha

    switch opcao {
        case 1:
            print("Criação de Conta:\n")
            if let (numero, titular, senha, saldo) = criarContaAux(){ // desembrulhando
                if criarConta(numero: numero, titular: titular, senha: senha, saldo: saldo, contas: &contas){ // recebido da função aux
                    print("Conta cadastrada com sucesso!") // apenas print por enquanto
                }else{
                    print("Não foi possível criar a conta...")
                }
            }

        case 2:
            print("Entr:\n")
            if let (numero, senha) == entrarAux(){ // leitura passou
                if let contaLogada = entrar(numero: numero, senha: senha, contas: contas){
                    // autenticado: o ehAdmin decide qual menu abrir
                    if contaLogada.ehAdmin{
                        print("Bem-vindo, administrador!")
                        // menuAdmin(...) a ser construído
                    }else{
                        print("Bem-vindo, \(contaLogada.titular)!")
                        // menuComum(...) a ser construído
                    }
                }else{
                    print("Número da conta ou senha incorretos!")
                }
            }
            

        default: print("Saindo...")
    }

} while opcao != 3