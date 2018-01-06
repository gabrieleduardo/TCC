% Calcula a quantidade de vizinhos com distância inferior ao valor do limiar
% param matriz = Matriz de distâncias de uma forma
% param limiar = Limiar de distância
% return vizinhos = Matriz com a quantidade de vizinhos para cada ponto
function vizinhos = calculaNumeroVizinhos(matriz,limiar)
	pos = (matriz < limiar);
	vizinhos = sum(pos);
  % Retira a relação de vizinhança entre um ponto e ele mesmo (X,X)
	vizinhos = vizinhos - 1;
end
