% Código adaptado do original cedido pelo Dr. André R. Backes
% Realiza a classificação das formas
% param assim = Matriz de descritores
% param classe = Classificação das formas por classe
% return res = Percentual de acerto
function res = classifica_1NN_LeaveOneOut(descritores,classe)
    % Calcula a distância de todos para todos e transforma na forma quadrada.
    dist = squareform(pdist(descritores,'seuclidean'));
    % Ordena a matriz de distâncias. O v é a matriz ordenada, ind é a posição anterior do elemento.
    [v,ind] = sort(dist,2);
    % Calcula o percentual de acertos comparando o indice dois com a classe.
    acertos = sum(classe(ind(:,2)) == classe);
    % Percentual de acerto
    res = 100*acertos/length(classe);
end
