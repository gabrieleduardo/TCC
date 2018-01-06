% Classifica as formas considerando-se um intervalo de limiares, utilizando-se apenas o descritor energia
% param ini - Valor inicial do intervalo
% param incr - Valor de incremento do intervalo
% param fim - Valor final do intervalo
% param classes - Classificação das formas por classe
% param descritores - Matriz de descritores
% return [ra] - Vetor de Resultados para cada combinação
function [ra] = classificarExpUm(ini,incr,fim,classes, descritores)
	max = 0;
	melhores = [];
	r = resultados;
	ra = [];
	aux = [];
	% Recupera todos os limiares do intervalo determinado
	limiares = ini:incr:fim;
		% Percorre todos os limiares do intervalo
		for l = limiares
			% Recupera os descritores do limiares
			assin = descritores.descritores{l}; 
			% Recupera o descritor de energia
			auxiliar = assin(:,4);
			% Insere os descritores na matriz a ser classificada 
			aux = [aux, auxiliar];
		end
		
	% Classifica pelo método 1NN_LeaveOneOut
	retorno = classifica_1NN_LeaveOneOut(aux,classes.classe);
	% Percentual de acertos da combinação
	r.acerto = retorno;
	% Limiares utilizados
	r.limiares = limiares;
	% Quantidade de Descritores na combinação
	r.qtdComb = 1;
	% Combinações possíveis
	r.comb = 4;
	% Combinação testada
	r.combY = 4;
	% Insere o resultado no retorno da função
	ra = [ra,r];

	% Imprime em tela se o acerto for maior que o máximo computado até o momento.
	if max < retorno
		max = retorno
	end
end