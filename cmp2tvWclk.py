import sys

def convert_to_hex(file_path, output_path):
    # Usando 16 bits para todos os números
    bits = 16  
    # Valor máximo para complemento de 2 (65536)
    max_value = 2 ** bits  

    with open(file_path, 'r') as file, open(output_path, 'w') as output_file:
        for line in file:
            # Ignora a linha do cabeçalho
            if "time" in line:
                continue
            
            # Remove espaços desnecessários e separa os campos
            fields = line.strip().split('|')[1:]  # Ignora a primeira coluna
            hex_values = []
            
            # Converte o valor da coluna 'time'
            time_value = fields[0].strip()
            if '+' in time_value:
                hex_values.append(format(1, '04X'))  # Converte para 1 quando tem '+'
            else:
                hex_values.append(format(0, '04X'))  # Converte para 0 quando não tem '+'
                
            # Converte as outras colunas
            for field in fields[1:]:  # Ignora a primeira coluna (time)
                try:
                    value = int(field.strip())
                    if value < 0:
                        # Converte para complemento de 2 em 16 bits para números negativos
                        hex_value = format(max_value + value, '04X')
                    else:
                        # Converte para hexadecimal em 16 bits com zeros à esquerda para números positivos
                        hex_value = format(value, '04X')
                    hex_values.append(hex_value)
                except ValueError:
                    # Mantém o campo caso não seja um número
                    hex_values.append(field.strip())
            
            # Escreve a linha convertida no arquivo de saída
            output_file.write('_'.join(hex_values) + '\n')

# Caminho para o arquivo de entrada e saída
input_file = sys.argv[1]
output_file = sys.argv[1].replace(".cmp", ".tv")

# Chama a função de conversão e exibe uma mensagem ao final
convert_to_hex(input_file, output_file)
print("Conversão completa! Verifique o arquivo:", output_file)

