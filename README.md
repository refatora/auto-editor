# auto-editor  

Automatize a edição de seus vídeos com uma seleção de scripts de linha de comando (CLI - Command Line Interface) que facilitam esse processo.

Este projeto é apenas um conjunto de scripts convenientes para edição automatizada de vídeos baseado no [auto-editor](https://auto-editor.com). Quer mais controle sobre as suas edições automatizadas? Visite a página oficial do https://auto-editor.com

## Requisitos  
* Docker  
* Capacidade de executar shell scripts em qualquer distribuição Linux ou no Windows Subsystem for Linux (WSL)  

## Edição Automática de Vídeos  

### Preparação  

Antes de editar vídeos automaticamente, certifique-se de que o serviço Docker está em execução:  
```sh
docker --version
# Docker version 27.5.1, build 9f9e405
```  

Agora, execute o script `build.sh`, que construirá as imagens Docker necessárias:  
```sh
sh build.sh
```  

Podemos verificar que duas imagens foram instaladas: `ffmpeg` e `auto-editor`:  
```sh
docker images

# REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
# ffmpeg        latest    2d7367515713   20 hours ago   73.2MB
# auto-editor   latest    412339995dea   2 days ago     1.23GB
```  

### Editando Vídeos  

Atualmente, esses scripts seguem um fluxo rígido de trabalho. A idéia é torná-los mais flexíveis no futuro.  

Crie dois diretórios em sua máquina: um para os arquivos originais e outro para os arquivos editados. Para esta documentação, utilizaremos os diretórios `footage` e `edits`, relativos aos arquivos deste repositório:  
```sh
mkdir footage
mkdir edits
```  

Agora, você pode gravar seus vídeos e armazenar os arquivos no diretório `footage`. Quando desejar editá-los, execute o script `edit.sh`, passando os dois diretórios como argumento.

Por exemplo, suponha que temos a seguinte estrutura de arquivos:  
```
├── footage
    ├── first-video.mkv
    └── second-video.mkv
├── edits
    └── (empty)
```  

Podemos rodar o comando:  
```sh
sh edit.sh footage/ edits/
# Most recent file: second-video.mkv
# Finished. Took 11.64 seconds (0:00:12) 
```  

Agora, observaremos que o arquivo mais recente do diretório `footage` foi editado e salvo no diretório `edits`, com o prefixo `auto-` adicionado ao nome do vídeo editado automaticamente:  
```
├── footage
    ├── first-video.mkv
    └── second-video.mkv
├── edits
    └── auto-second-video.mkv
```  

**Mas por que apenas o arquivo mais recente do diretório `footage` foi editado automaticamente? Não seria melhor se todos os arquivos fossem editados?**  

Isso depende do seu estilo de edição. Escolhi editar apenas o arquivo mais recente para facilitar a edição em tempo real. Normalmente, edito meus vídeos durante a gravação: gravo um segmento e, se estiver satisfeito, executo o `edit.sh`; caso contrário, regravo o trecho. Esse fluxo tem a vantagem de me permitir selecionar os segmentos que me agradam sem precisar revisar todas as gravações posteriormente.  

Por fim, podemos combinar todos os vídeos do diretório `edits` em um único arquivo:  
```sh
sh merge.sh edits/
```

Esse comando criará um arquivo combinando todos os vídeos do diretório `edits` em um único arquivo chamado `auto-merge.mp4`.