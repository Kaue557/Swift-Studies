import Foundation

let listaNotas: [Double] = [4.6, 7.5, 8, 9, 10, 2, 5.5, 4.7, 7.8, 5.1]
var aprovados: [Double] = []
var reprovados: [Double] = []
var emRecuperacao: [Double] = []
var maiorNotaAtual: Double = 0.0
var menorNotaAtual: Double = 10.0
var somaNotas: Double = 0.0


for nota in listaNotas {
    if nota >= 7.0 && nota <= 10.0{
        aprovados.append(nota)
    }
    else if nota >= 5.0{
        emRecuperacao.append(nota)
    }
    else if nota < 5.0 && nota >= 0.0{
        reprovados.append(nota)
    }
    else{
        print("ERRO! NOTAS INVÁLIDAS")
    }

    if nota > maiorNotaAtual{
        maiorNotaAtual = nota
    }

    if nota < menorNotaAtual{
        menorNotaAtual = nota
    }

    somaNotas += nota
}

let mediaGeral = somaNotas / Double(listaNotas.count)

print("""
Total de Alunos: \(listaNotas.count)
Média Geral da Turma: \(mediaGeral)
Maior nota: \(maiorNotaAtual)
Menor nota: \(menorNotaAtual)
Aprovados: \(aprovados.count)
Em recuperação: \(emRecuperacao.count)
Reprovados: \(reprovados.count)
""")