% Classifica as formas considerando-se combinações de descritores, limiar por limiar
% param classes - Classificação das formas por classe
% param descritores - Matriz de descritores
% return [ra] - Vetor de Resultados para cada combinação
function [ra] = classificarExpDois(ini,incr,fim, classes, descritores)
	 max = 0;
	 melhores = [];
	 r = resultadosExpDois;
	 ra = [];
 
	% Percorre as combinações de descritores de ki = 1 até a quantidade máxima de descritores
	for ki = 1 : 9
		% Recupera as combinações de descritores divididos em conjuntos de N = ki.
		comb = combnk(1:9,ki);
		% Recupera a quantidade de combinações (xk) é a quantidade de combinações, yk = ki.
		[xk,yk] = size(comb);
		% Percorre todas as combinações de descritores recuperadas nos passos anteriores
		for xi = 1 : xk			
			r.acerto = [];
			% Combinação testada
			r.combY = xi;
			r.comb = comb;
			
			for inc = vInc
				aux = [];
				% Recupera todos os limiares do intervalo determinado
				limiares = vIni:inc:vFim;
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
				r.acerto = [r.acerto,retorno];
				
				
				% Imprime em tela se o acerto for maior que o máximo computado até o momento.
				if max < retorno
					max = retorno
				end
			end
			
			% Insere o resultado no retorno da função
			ra = [ra,r];
			
		end
	end
end