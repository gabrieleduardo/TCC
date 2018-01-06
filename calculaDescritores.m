% A função calcula uma série de descritores de um histograma e retorna um vetor com cada um desses descritores
% Os descritores calculados são:
% 1 - Media
% 2 - Variancia
% 3 - Contraste
% 4 - Energia
% 5 - Entropia
% 6 - Kurtose
% 7 - Skewness
% 8 - Smoothness
% 9 - IDM
% param V = Vetor com o histograma da forma
% return descritores = Vetor de descritores da forma
function descritores = calculaDescritores(V)
	G = 1 : length(V);
	descritores = zeros(1,9);
    media = descritorMedia(V,G);
    variancia = descritorVariancia(V,G, media);
    contraste = descritorContraste(V,G);
    energia = descritorEnergia(V);
    entropia = descritorEntropia(V);
    kurtose = descritorKurtose(V,G,media,variancia);
    skewness = descritorSkewness(V,G,media,variancia);
    smoothness = descritorSmoothness(variancia);
	idm = descritorIdm(V,G);
	descritores(1) = media;
	descritores(2) = variancia;
	descritores(3) = contraste;
	descritores(4) = energia;
	descritores(5) = entropia;
	descritores(6) = kurtose;
	descritores(7) = skewness;
	descritores(8) = smoothness;
	descritores(9) = idm;
    %descritores = [media variancia contraste energia entropia kurtose skewness smoothness idm];
end

% Calcula a média de um histograma
% param V = Vetor com o histograma da forma
% param G = Vetor com valores de 1 até N, sendo N o tamanho do histograma
% return media = Media do Histograma
function media = descritorMedia(V, G)
    media = sum(V .* G);
end

% Calcula a Variancia de um histograma
% param V = Vetor com o histograma da forma
% param G = Vetor com valores de 1 até N, sendo N o tamanho do histograma
% return variancia = Variancia do Histograma
function variancia = descritorVariancia(V, G, media)
	y = (G-media).^2;
    variancia = sum(V .* y);
end

% Calcula o Contraste de um histograma
% param V = Vetor com o histograma da forma
% param G = Vetor com valores de 1 até N, sendo N o tamanho do histograma
% return contraste = Contraste do Histograma
function contraste = descritorContraste(V, G)
	contraste = sum(V .* G.^2);
end

% Calcula a Energia de um histograma
% param V = Vetor com o histograma da forma
% return Energia = Energia do Histograma
function energia = descritorEnergia(V)
	energia = sum(V.^2);
end

% Calcula a Entropia de um histograma
% param V = Vetor com o histograma da forma
% return Entropia = Entropia do Histograma
function entropia = descritorEntropia(V)
	y = find(V > 0);
	entropia = -sum(V(y).*log(V(y)));
end

% Calcula a Kurtose de um histograma
% param V = Vetor com o histograma da forma
% param G = Vetor com valores de 1 até N, sendo N o tamanho do histograma
% param media = Media do Histograma
% param variancia = Variancia do Histograma
% return kurtose = Kurtose do Histograma
function kurtose = descritorKurtose(V,G,media,variancia)
	kurtose = auxSkewnessKurtosis(V,G, media, variancia, 4);
end

% Calcula a Skewness de um histograma
% param V = Vetor com o histograma da forma
% param G = Vetor com valores de 1 até N, sendo N o tamanho do histograma
% param media = Media do Histograma
% param variancia = Variancia do Histograma
% return skewness = Skewness do Histograma
function skewness = descritorSkewness(V,G,media,variancia)
	skewness = auxSkewnessKurtosis(V,G, media, variancia, 3);
end

% Função auxiliar para o calculo dos descritores Skewness e Kurtose
% param V = Vetor com o histograma da forma
% param G = Vetor com valores de 1 até N, sendo N o tamanho do histograma
% param media = Media do Histograma
% param variancia = Variancia do Histograma
% param n = Variavel a ser utilizada nos cálculos.
% - Skewness utiliza o valor 3
% - Kurtose utiliza o valor 4
% return aux = Valor do descritor
function aux = auxSkewnessKurtosis(V,G, media, variancia, n)
	y = V .* (G - media).^n;
	aux = sqrt(variancia)^(-n)*sum(y);
end

% Calcula a Smoothness de um histograma
% param variancia = Variancia do Histograma
% return smoothness = Smoothness do Histograma
function smoothness = descritorSmoothness(variancia)
    smoothness = 1 - 1/(1+sqrt(variancia));
end

% Calcula o 'Inverse difference moment' de um histograma
% param V = Vetor com o histograma da forma
% param G = Vetor com valores de 1 até N, sendo N o tamanho do histograma
% return idm = IDM do Histograma
function idm = descritorIdm(V, G)
	y = G.^2+1;
	idm = sum(V ./ y);
end
