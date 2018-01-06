% Classifica as formas considerando-se combinações de descritores, limiar por limiar
% param qtdDescritores - Quantidade de descritores
% param classes - Classificação das formas por classe
% param descritores - Matriz de descritores
% param vIni - Vetor com as posições iniciais para combinações.
% param vFim - Vetor com as posições finais para combinações.
% param vInc - Vetor com as os valores de incremento.
% return [ra] - Vetor de Resultados para cada combinação
function [ra] = classificar(qtdDescritores, classes, descritores, vIni, vFim, vInc)
	 max = 0;
	 melhores = [];
	 r = resultados;
	 ra = [];
 
	% Percorre as combinações de descritores de ki = 1 até a quantidade máxima de descritores
	for ki = 1 : qtdDescritores
		% Recupera as combinações de descritores divididos em conjuntos de N = ki.
		comb = combnk(1:9,ki);
		% Recupera a quantidade de combinações (xk) é a quantidade de combinações, yk = ki.
		[xk,yk] = size(comb);
		% Percorre todas as combinações de descritores recuperadas nos passos anteriores
		for xi = 1 : xk
			% Determina o valor da posição inicial do intervalo
			for ini = vIni
				% Determina o valor da posição final do intervalo
				for fim = vFim
					% Determina o incremento do intervalo
					for incr = vInc
						aux = [];
						% Recupera todos os limiares do intervalo determinado
						limiares = ini:incr:fim;
						
							% Percorre todos os limiares do intervalo
							for l = limiares
								% Recupera os descritores do limiares
								assin = descritores.descritores{l}; 
								% Recupera os descritores a serem utilizados na combinação
								auxiliar = assin(:,[comb(xi,:)]);
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
						r.qtdComb = ki;
						% Combinações possíveis
						r.comb = comb;
						% Combinação testada
						r.combY = xi;
						% Insere o resultado no retorno da função
						ra = [ra,r];
	
						% Imprime em tela se o acerto for maior que o máximo computado até o momento.
						if max < retorno
							max = retorno
						end
					end
				end
			end
		end
	end
end