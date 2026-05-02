:- consult('carros.pl').

menu :-
    write('========= MENU ========='), nl,
    write('1. Descobre o teu Carro'), nl,
    write('2. Estatisticas dos Carros'), nl,
    write('3. Especificacoes de um Carro'), nl,
    write('4. Sair'), nl,
    write('Escolha uma opcao (1, 2, 3 ou 4): '), nl,
    read(Opcao),
    executar(Opcao).

% Ações com base na escolha do menu
executar(1) :- descobrir_carro(_), menu.
executar(2) :- submenu_estatisticas, menu.
executar(3) :- buscar_especificacoes, menu.
executar(4) :- write('Saindo do sistema. Obrigado!'), nl.
executar(_) :- write('Opcao invalida. Tente novamente.'), nl, menu.

% Submenu para estatísticas
submenu_estatisticas :-
    write('========= ESTATISTICA DOS CARROS ========='), nl,
    write('1. Estatisticas por Tipo'), nl,
    write('2. Estatistica por Combustivel'), nl,
    write('3. Estatistica por Tipo de Caixa'), nl,
    write('4. Estatistica por Tracao'), nl,
    write('5. Voltar ao Menu Principal'), nl,
    write('Escolha uma opcao (1-5): '), nl,
    read(OpcaoEstatisticas),
    executar_submenu(OpcaoEstatisticas).

% Ações com base na escolha do submenu
executar_submenu(1) :- contar_por_tipo, submenu_estatisticas.
executar_submenu(2) :- contar_por_combustivel, submenu_estatisticas.
executar_submenu(3) :- contar_por_tipocaixa, submenu_estatisticas.
executar_submenu(4) :- contar_por_tracao, submenu_estatisticas.
executar_submenu(5) :- write('Voltando ao Menu Principal...'), nl.
executar_submenu(_) :- write('Opcao invalida. Tente novamente.'), nl, submenu_estatisticas.

% Conta carros por tipo
contar_por_tipo :-
    findall(Tipo, (carro(_, Atributos), member(tipo(Tipo), Atributos)), Tipos),
    contar_ocorrencias(Tipos, ContagemTipos),
    write('Quantidade por Tipo:'), nl,
    exibir_contagem(ContagemTipos), nl.

% Conta carros por combustível
contar_por_combustivel :-
    findall(Combustivel, (carro(_, Atributos), member(combustivel(Combustivel), Atributos)), Combustiveis),
    contar_ocorrencias(Combustiveis, ContagemCombustiveis),
    write('Quantidade por Combustivel:'), nl,
    exibir_contagem(ContagemCombustiveis), nl.

% Conta carros por tipo de caixa
contar_por_tipocaixa :-
    findall(TipoCaixa, (carro(_, Atributos), member(tipodecaixa(TipoCaixa), Atributos)), Caixas),
    contar_ocorrencias(Caixas, ContagemCaixas),
    write('Quantidade por Tipo de Caixa:'), nl,
    exibir_contagem(ContagemCaixas), nl.

% Conta carros por tração
contar_por_tracao :-
    findall(Tracao, (carro(_, Atributos), member(tracao(Tracao), Atributos)), Tracoes),
    contar_ocorrencias(Tracoes, ContagemTracoes),
    write('Quantidade por Tracao:'), nl,
    exibir_contagem(ContagemTracoes), nl.

% Conta as ocorrências de cada item em uma lista
contar_ocorrencias(Lista, Contagem) :-
    sort(Lista, Unicos),
    maplist(contar_item(Lista), Unicos, Contagem).

% Conta um único item na lista
contar_item(Lista, Item, Item-Count) :-
    include(=(Item), Lista, Ocorrencias),
    length(Ocorrencias, Count).

% Exibe a contagem formatada
exibir_contagem([]).
exibir_contagem([Item-Count | Resto]) :-
    write(Item), write(' = '), write(Count), nl,
    exibir_contagem(Resto).

% Buscar especificações de um carro pelo nome ou marca
buscar_especificacoes :- 
    write('Introduza o nome ou a marca do carro: '), nl,
    read(NomeOuMarca),
    (carro(NomeOuMarca, Atributos) -> 
        write('Especificacoes do carro:'), nl,
        exibir_atributos_formatados(Atributos)
    ;
        write('Carro nao encontrado. Certifique-se de escrever o nome corretamente.'), nl).

% Exibir atributos formatados
exibir_atributos_formatados([]).
exibir_atributos_formatados([tipo(Tipo) | Resto]) :-
    write('Tipo: '), write(Tipo), nl,
    exibir_atributos_formatados(Resto).
exibir_atributos_formatados([combustivel(Combustivel) | Resto]) :-
    write('Combustivel: '), write(Combustivel), nl,
    exibir_atributos_formatados(Resto).
exibir_atributos_formatados([ano(Ano) | Resto]) :-
    write('Ano: '), write(Ano), nl,
    exibir_atributos_formatados(Resto).
exibir_atributos_formatados([km(Km) | Resto]) :-
    write('Km: '), write(Km), nl,
    exibir_atributos_formatados(Resto).
exibir_atributos_formatados([cor(Cor) | Resto]) :-
    write('Cor: '), write(Cor), nl,
    exibir_atributos_formatados(Resto).
exibir_atributos_formatados([portas(Portas) | Resto]) :-
    write('Portas: '), write(Portas), nl,
    exibir_atributos_formatados(Resto).
exibir_atributos_formatados([arcondicionado(Ar) | Resto]) :-
    write('Ar Condicionado: '), write(Ar), nl,
    exibir_atributos_formatados(Resto).
exibir_atributos_formatados([tipodecaixa(Caixa) | Resto]) :-
    write('Tipo de Caixa: '), write(Caixa), nl,
    exibir_atributos_formatados(Resto).
exibir_atributos_formatados([tracao(Tracao) | Resto]) :-
    write('Tracao: '), write(Tracao), nl,
    exibir_atributos_formatados(Resto).
exibir_atributos_formatados([cavalos(Cavalos) | Resto]) :-
    write('Cavalos: '), write(Cavalos), nl,
    exibir_atributos_formatados(Resto).
exibir_atributos_formatados([preco(Preco) | Resto]) :-
    write('Preco: '), write(Preco), write(' EUROS'), nl,
    exibir_atributos_formatados(Resto).
exibir_atributos_formatados([caracteristicas(Caracteristicas) | Resto]) :-
    write('Caracteristicas: '), write(Caracteristicas), nl,
    exibir_atributos_formatados(Resto).

    descobrir_carro(Marca) :- 
        pergunta('O Tipo do Carro: [sedan, coupe, cuv, suv, hatch_back, supercar]', Tipo), 
        pergunta('O Combustivel do Carro: [gasolina, eletrico, diesel]', Combustivel),
        pergunta_intervalo('o intervalo do Ano do Carro', AnoMin, AnoMax),
        pergunta_intervalo('o intervalo da Km do Carro (Km)', KmMin, KmMax),
        pergunta('A Cor do Carro: [Preto, Branco, Prata, Azul, Vermelho], [Fosco,Prolado,Metalico,CromadoFluorescente]', Cor),
        pergunta('Quantas Portas o Carro tem: [3, 5]', Portas),
        pergunta('O Carro tem Ar Condicionado? [sim, nao]', ArCondicionado),
        pergunta('Qual o Tipo de Caixa do Carro? [manual, automatica]', TipoDeCaixa),
        pergunta('Qual o Tipo de Tracao do Carro? [dianteira, traseira, as_quatro]', Tracao),
        pergunta_intervalo('o intervalo de Cavalos de Potencia do Carro', CavalosMin, CavalosMax),
        pergunta_intervalo('o intervalo de Preco do Carro (EUROS)', PrecoMin, PrecoMax),
        pergunta_caracteristicas('Quais as Características desejadas do Carro? [autopilot, gps, paineldigital, assistenteestacionamento, ecomode]', CaracteristicasDesejadas),
        carro(Marca, Atributos),
        member(tipo(Tipo), Atributos),
        member(combustivel(Combustivel), Atributos),
        member(ano(Ano), Atributos), Ano >= AnoMin, Ano =< AnoMax,
        member(km(Km), Atributos), Km >= KmMin, Km =< KmMax,
        member(cor(Cor), Atributos),
        member(portas(Portas), Atributos),
        member(arcondicionado(ArCondicionado), Atributos),
        member(tipodecaixa(TipoDeCaixa), Atributos),
        member(tracao(Tracao), Atributos),
        member(cavalos(Cavalos), Atributos), Cavalos >= CavalosMin, Cavalos =< CavalosMax,
        member(preco(Preco), Atributos), Preco >= PrecoMin, Preco =< PrecoMax,
        member(caracteristicas(Caracteristicas), Atributos),
        subset(CaracteristicasDesejadas, Caracteristicas), 
        write('Carro encontrado: '), write(Marca), nl.

% Pergunta simples ao utilizador
pergunta(Pergunta, Resposta) :-
    write(Pergunta), nl,
    read(Resposta).

% Pergunta ao utilizador para fornecer um intervalo
pergunta_intervalo(Pergunta, Min, Max) :-
    format('Introduza o valor minimo para ~w:', [Pergunta]), nl,
    read(Min),
    format('Introduza o valor maximo para ~w:', [Pergunta]), nl,
    read(Max).

% Pergunta ao utilizador as características desejadas
pergunta_caracteristicas(Pergunta, Caracteristicas) :-
    write(Pergunta), nl,
    write('Introduza a lista de características desejada: [abs, assitenciatrajetoria, airbags, controletracao, assistentedetravagem, autopilot, gps, paineldigital, assistenteestacionamento, sos, ecomode, assitenciadearranque, cruisecontrol]'), nl,
    read(Caracteristicas).