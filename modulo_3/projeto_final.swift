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

//----------------------------------------------------------------------------------
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

    print("Saldo inicial: ")
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
    guard let senha_titular = readLine()
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

// MENU DO USUÁRIO COMUM (esqueleto, para ser construído) =========================
func menuComun(numeroLogado: Int, contas: inout [Int: Conta]){
    print("| O que deseja fazer hoje? |\n")

    var escolhaMenu = 0

    repeat{
        print("1. Consultar Dados\n2. Depositar\n3. Transferir\n4. Sair")
        print("> ", terminator: "")

        guard let entrada = readLine(),
              let escolha = Int(entrada),
              (1...4).contains(escolha)
        else {
            print("Entrada inválida! Escolha um número de 1 a 4.\n")
            continue
        }

        escolhaMenu = escolha

        switch escolha{
            case 1: print("em construção\n")
            case 2: print("em construção\n")
            case 3: print("em construção\n")
            default: print("Saindo da conta...\n")
        }

    } while escolhaMenu != 4
}

// MENU DO ADMIN =========================
// só conversa com o usuário; as regras ficam em listarContas e removerConta
func menuAdmin(numeroLogado: Int, contas: inout [Int: Conta]){
    print("| O que deseja fazer hoje? |\n")

    // declarada FORA do repeat para o while enxergar
    var escolhaMenu = 0

    repeat{
        print("1. Listar Contas\n2. Remover Conta\n3. Sair")
        print("> ", terminator: "")

        guard let entrada = readLine(),
              let escolha = Int(entrada),
              (1...3).contains(escolha)
        else {
            print("Entrada inválida! Escolha um número de 1 a 3.\n")
            continue
        }

        escolhaMenu = escolha

        switch escolha{
            case 1:
                // a lógica devolve o array; o menu é quem imprime
                let lista = listarContas(contas: contas)
                if lista.isEmpty{
                    print("Nenhuma conta cadastrada.\n")
                }else{
                    print("\n--- CONTAS CADASTRADAS ---")
                    for conta in lista{
                        // imprime só nome, número e saldo (nunca a senha)
                        print("Conta \(conta.numero) | \(conta.titular) | R$ \(String(format: "%.2f", conta.saldo))")
                    }
                    print("")
                }

            case 2:
                // 1º: auxiliar lê o número da conta alvo (nil = entrada inválida)
                if let alvo = removerAux(){
                    // 2º: a lógica recebe o alvo E quem está logado
                    if removerConta(numero: alvo, logado: numeroLogado, contas: &contas){
                        print("Conta \(alvo) removida com sucesso!\n")
                    }else{
                        print("Conta não existe ou é do administrador!\n")
                    }
                }

            default: print("Saindo da conta...\n")
        }

    } while escolhaMenu != 3
}

// FUNÇÕES DE LÓGICA =========================
func verDados(numero: Int, contas: [Int: Conta]) -> Conta?{ return contas[numero] }

func depositar(numero: Int, valor: Double, contas: inout [Int: Conta]) -> Bool{
    return false // a construir
}

func transferir(origem: Int, destino: Int, valor: Double, contas: inout [Int: Conta]) -> Bool{
    return false // a construir
}

func alterarSenha(numero: Int, senhaAtual: String, novaSenha: String, contas: inout [Int: Conta]) -> Bool{
    return false // a construir
}

// apenas lógica: devolve as contas comuns (sem o admin) ordenadas pelo número
func listarContas(contas: [Int: Conta]) -> [Conta]{
    // .values pega só as contas (sem as chaves)
    // filter descarta o admin; sorted organiza, pois dicionário não tem ordem
    return contas.values
        .filter { !$0.ehAdmin }
        .sorted { $0.numero < $1.numero }
}

// só LÊ do teclado: pergunta qual conta remover (nil = entrada inválida)
func removerAux() -> Int?{
    print("Número da conta a remover: ")
    print("> ", terminator: "")
    guard let texto = readLine(),
          let numero = Int(texto)
    else {
        print("Número de conta inválido!")
        return nil
    }
    return numero
}

// apenas lógica: remove a conta, se puder
// numero = conta alvo; logado = admin que está removendo
func removerConta(numero: Int, logado: Int, contas: inout [Int: Conta]) -> Bool{
    // só continua se: não é a própria conta logada, a conta existe e não é admin
    guard numero != logado,
          let conta = contas[numero],
          !conta.ehAdmin
    else {
        return false
    }
    contas.removeValue(forKey: numero) // apaga a chave do dicionário
    return true
}

//----------------------------------------------------------------------------------
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
            print("Entrar:\n")
            if let (numero, senha) = entrarAux(){ // leitura passou
                if let contaLogada = entrar(numero: numero, senha: senha, contas: contas){
                    // autenticado: o ehAdmin decide qual menu abrir
                    if contaLogada.ehAdmin{
                        print("Bem-vindo, administrador!")
                        menuAdmin(numeroLogado: contaLogada.numero, contas: &contas)
                    }else{
                        print("Bem-vindo, \(contaLogada.titular)!")
                        menuComun(numeroLogado: contaLogada.numero, contas: &contas)
                    }
                }else{
                    print("Número da conta ou senha incorretos!")
                }
            }

        default: print("Saindo...")
    }

} while opcao != 3