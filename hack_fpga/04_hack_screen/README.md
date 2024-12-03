# Computador Hack com Vídeo

Neste exemplo juntamos os dois anteiores para formar o sistemas completo. Ainda rodamos um código muito simples, apenas para testar a tela.

A memória ROM tem apenas 1K words (2KB) e a RAM 32K words (64KB), distribuidos da seguinte forma:

    0x0000-0x3FFF: RAM   (16K words = 32KB)
    0x4000-0x5FFF: Screen (8k words = 16KB)
    0x6000-0x7FFF: Unused (8k words = 16KB)
    0x8000-0x800F: Memory Mapped I/O

Relatório de recursos:

    Fitter Status : Successful - Tue Dec  3 15:05:46 2024
    Quartus Prime Version : 23.1std.1 Build 993 05/14/2024 SC Lite Edition
    Revision Name : proj
    Top-level Entity Name : top
    Family : Cyclone V
    Device : 5CSXFC6D6F31C6
    Timing Models : Final
    Logic utilization (in ALMs) : 258 / 41,910 ( < 1 % )
    Total registers : 114
    Total pins : 86 / 499 ( 17 % )
    Total virtual pins : 0
    Total block memory bits : 2,105,984 / 5,662,720 ( 37 % )
    Total RAM Blocks : 262 / 553 ( 47 % )
    Total DSP Blocks : 1 / 112 ( < 1 % )
    Total HSSI RX PCSs : 0 / 9 ( 0 % )
    Total HSSI PMA RX Deserializers : 0 / 9 ( 0 % )
    Total HSSI TX PCSs : 0 / 9 ( 0 % )
    Total HSSI PMA TX Serializers : 0 / 9 ( 0 % )
    Total PLLs : 0 / 15 ( 0 % )
    Total DLLs : 0 / 4 ( 0 % )