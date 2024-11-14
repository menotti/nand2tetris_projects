#!/usr/bin/env python3

import sys

def netpbm_to_hex(input_file, output_file):
    with open(input_file, 'r') as f:
        # Ler e processar o cabeçalho
        f.readline()  # P3
        # Extrair largura e altura
        width, height = map(int, f.readline().strip().split())  # Largura e altura
        # Largura fixa 
        width = 1 
        f.readline()  # Valor máximo (255)
        # Ler o restante do arquivo (dados dos pixels)
        pixel_data = f.read().split()

    # Converter para hexadecimal e agrupar as linhas com base na largura
    hex_lines = []
    hex_line = ""
    pixels_per_line = width  # Quantidade de pixels por linha conforme o cabeçalho
    for i in range(0, len(pixel_data), 3):
        r = int(pixel_data[i])
        g = int(pixel_data[i + 1])
        b = int(pixel_data[i + 2])
        hex_pixel = f"{r:02x}{g:02x}{b:02x}"
        
        # Adicionar o pixel atual à linha atual
        hex_line += hex_pixel
        
        # Verificar se a linha atingiu o limite de pixels
        if (i // 3 + 1) % pixels_per_line == 0:
            hex_lines.append(hex_line)
            hex_line = ""
    
    # Adicionar qualquer pixel restante na última linha
    if hex_line:
        hex_lines.append(hex_line)

    # Escrever as linhas no arquivo de saída
    with open(output_file, 'w') as f:
        f.write("\n".join(hex_lines))

# Caminho para o arquivo de entrada e saída
input_file = sys.argv[1]
output_file = sys.argv[1].replace(".ppm", ".hex")
netpbm_to_hex(input_file, output_file)
