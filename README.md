# auto-editor

Automatize a edicao de seus videos com uma selecao de scripts de linha de command (CLI - Command Line Interface) que facilitam este processo.

## Requerimentos
* docker
* capacidade de executar shell scripts com qualquer distribuicao linux ou com o Windows Subsystem for Linux (WSL)

## Editar Videos Automaticamente

### Preparacao

Antes de editar videos automaticamente certifiquese que o seu servico docker estaja rodando:
```sh
docker --version
# Docker version 27.5.1, build 9f9e405
```

Agora execute o `build.sh` que vai construir as imagens do docker necessarias:
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

### Editando Videos

No presente momento estes scripts seguem um fluxo rigido de trabalho a ideia eh poder deixar o fluxo mais flexivel no futuro.

Crie dois diretorios em sua maquina, um diretorio para os arquivos originais e outro diretorio para os arquivos editados. Para esta documentacao vamos utilizar os diretorios `footage` e `edits` relativos aos arquivos deste repositorio.

```sh
mkdir footage
mkdir edits
```

Agora voce pode gravar os seus videos e guardar os arquivos no diretorio `footage`. Quando desejado execute `edit.sh` passando os dois diretorios como argumento, sendo o primeiro argumento o diretorio onde estao os arquivos originais e o segundo diretorio onde os arquivos editados serao salvos.

Por exemplo, tendo os seguintes arquivos:
```
.
├── footage
│   ├── first-video.mkv
│   └── second-video.mkv
├── edits
    └── (empty)
```

Podemos rodar o comando:
```sh
sh edit.sh footage/ edits/
# Most recent file: second-video.mkv
# Finished. took 11.64 seconds (0:00:12) 
```

Agora observaremos que o arquivo mais recent do diretorio `edits` foi editado e salvo no diretorio `edits` e o prefixo `auto-` foi aditionado ao arquivo editado automaticamente.

```
.
├── footage
│   ├── first-video.mkv
│   └── second-video.mkv
├── edits
    └── auto-second-video.mkv
```

_Mas porque apenas o arquivo mais recente do diretorion `edits` foi editatod automaticamente? Nao seria melhor se todos os arquivos fossem editados?_
Isso depende do seu estilo de edicao, eu escolhi a ideia de editar apenas o arquivo mais recente para facilitar edicao ao tempo real. Eu normalmente edito meus videos durante a gravacao. Eu gravo um seguimento e se satisfeito eu jah rodo o `edit.sh`; caso contrario eu gravo novamente. Este fluxo tem a vantagem que eu jah escolho os seguimentos que me agradaram sem ter que olhara toda as gravacoes para escolher os melhores seguimentos.

Por fim, podemos combinar todos os videos do diretorio `edits` em um unico arquivo:
```sh
sh merge.sh edits/
```

Este comando vai criar um arquivo com todos os arquivos do diretorio `/edits` combinados em um unico arquivo chamado `auto-merge.mp4`.