% Calcula a distância euclidiana entre todas as posições do modelo
% e normaliza a distância pelo maior valor.
% param modelo - Forma 3D como uma lista de pontos (x,y,z)
% return matriz - Matriz de distância entre todos pontos do modelo
function matriz = calculaDistancia(modelo)
	matriz = pdist2(modelo,modelo);
	maior = max(matriz(:));
	matriz = matriz ./ maior;
end
