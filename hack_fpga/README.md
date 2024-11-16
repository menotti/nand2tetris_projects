# Nand2Tetris4FPGA

## Usando um `Makefile` no Quartus II

Vamos usar um único [`Makefile`](./Makefile) para gerar o hardware e compilar o software de cada projeto. Para que ele funcione corretamente, vamos seguir alguns padrões de projeto:

1. Os arquivos Verilog e de conteúdo de memória devem estar na subpasta `rtl`.
1. Os arquivos de software a serem compilados, montados, etc. devem estar na subpasta `src`.

Veja um exemplo a seguir:

```
.
├── 01_johnson (pasta do projeto)
│   ├── rtl
│   │   └── top.sv
│   └── src
│       └── main.hack
├── DE10_standard.qsf (arquivo de pinos da placa)
├── Makefile
└── README.md (este arquivo)
```
Como o Makefile fica na pasta anterior, os comandos para usá-lo devem ser sempre `make -f ../Makefile` dentro das pastas dos projetos quando quiser usar o Quartus II.

Se deseja usar o `iverilog` para simular o projeto e o `gtkwave` para ver a simulação, entre na pasta `rtl` e use `make -f ../../Makefile sim view`. 
