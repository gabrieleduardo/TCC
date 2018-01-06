% Limpa o Workspace
clc;
close all;
clear all;

% Diretórios
dirFormas = ''; % Incluir o caminho para o diretório das formas.
dirSalvarHistogramas = ''; % Incluir o caminho para o diretório onde os histogramas serão salvos. 
dirSalvarDescritores = ''; % Incluir o caminho para o diretório onde os descritores serão salvos. 
dirClasses = ''; % Incluir o caminho para o diretório onde o arquivo classes.mat está salvo.
dirSalvarResultados = ''; % Incluir o caminho para o diretório onde os resultados serão salvos. 

% Auxiliares
classes = load(dirClasses);
limiares = 1/50 : 1/50 : (1 - 1/50);
qtdFormas = 400;
qtdLimiares = length(limiares);
qtdDescritores = 9;
descritores = cell(qtdLimiares,1);
max = [0,0];
resultados = [];

% Parâmetros 
% param(1) - Identifica se deve executar o bloco 1 - Carregar formas
% param(2) - Identifica se deve executar o bloco 2 - Calcular Histograma
% param(3) - Identifica se deve executar o bloco 3 - Calcular Descritores
% param(4) - Identifica se deve executar o bloco 4 - Classificar Formas
% param(5) - Identifica o tipo de classificação a ser feito.
% 			 1 - Classificar por combinações de intervalos e descritores.
%			 2 - Classificar por intervalo fixo e descritor energia.
%			 3 - Classificar por combinações de descritores, limiar por limiar.
param = [0,0,0,0];

% Parâmetros de intervalos utilizados para criar o vetor de classificação.
% Notas:
% 	- Para a classificação por combinações de intervalos, pode-se criar um vetor.
% 		- Exemplo: vIni = 1:10, vFim 30:49, vInc 1:5 
% 	- Para as demais classificações utilizar valores fixos.
%		- Exemplo: vIni = 1, vFim: 10, vInc = 1
vIni = 1;
vFim = 1;
vInc = 1;

% Parâmetros de intervalos para classificar por combinações de intervalo e energia

% Carrega as formas a serem processadas
if param(1) == 1
    filePattern = fullfile(dirFormas, '*.off.data.mat');
    formas = dir(filePattern);
end

% Calcula os histogramas a partir das formas processadas
if param(2) == 1
  % Calcula os histogramas das formas
     for i = 1 : length(formas) % Percorre todas as formas
        %Carrega a forma
        baseFileName = formas(i).name;
        fullFileName = fullfile(folder, baseFileName);
        forma = load(fullFileName);
        forma = forma.X;

        %Calcula matriz de distancia
        matrizDistancias = calculaDistancia(forma);

        for l = 1 : length(limiares)
            % Calcula o grau dos n�s
            limiar = limiares(l);
            grau = calculaNumeroVizinhos(matrizDistancias,limiar);
            % Calcula o histograma normalizado
            maior = max(graus);
            histograma = hist(graus,maior+1);
            sumh = sum(histograma);
            % Normalizar histograma
            histograma = histograma/sumh;
            % Salvar histograma
            toSave = strcat(saveHist,num2str(l),'l',baseFileName);

            save(toSave,'histograma');
        end
     end

     retorno = true;
end

% Calcula os descritores a partir dos descritores processados
if param(3) == 1
  % Calcula os descritores
    matrizDescritores = [];
    %Carrega os histogramas salvos
    for l = 1 : qtdLimiares % Percorre os limeares
        for f = 1 : qtdFormas % No dataset utilizados as formas são numeradas de 1..260,281..400.
            % Truque para pular as formas que faltam na numeração
            if f > 260 && f < 281
                f = 281;
            end

            % Carregar histograma salvo
            path = strcat(dirSalvarHistogramas,int2str(l),'l',int2str(f),'.off.data.mat');
            histogram = load(path);
            histogram = histogram.histograma;
            matrizDescritores = [matrizDescritores; calculaDescritores(histogram)];
        end
        matrizDescritores = matrizDescritores([1:260,281:400],:);
        descritores{l} = matrizDescritores;
        matrizDescritores = [];
    end
    save(dirSalvarDescritores,'descritores');
    retorno = true;
end

% Classifica as formas processadas a partir do seus descritores
if param(4) == 1
    descritores = load(dirSalvarDescritores);
	%
	if param(5) == 1
		retorno = classificar(qtdDescritores, classes, descritores, vIni, vFim, vInc);
	elseif param(5) == 2
		retorno = classificarExpUm(vIni,vInc,vFim,classes, descritores);
	elseif param(5) == 3
		retorno = classificarExpDois(ini,incr,fim, classes, descritores);
	% Valor de parâmetro inválido
	else
		retorno = [];
	end
	
	save(strcat(dirSalvarResultados,'resultado'),'retorno');
end
