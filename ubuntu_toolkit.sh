#!/bin/bash

# ==============================================================================
# Script Name: Ubuntu System Toolkit (Versão Gráfica TUI)
# Description: Script interativo com interface gráfica em terminal (dialog)
# para manutenção, limpeza, diagnóstico e backups no Ubuntu.
# Author: Mauricio Silva Costa
# License: MIT
# ==============================================================================

# Cores para output e fallback
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Verifica se o utilitário 'dialog' está instalado, se não, instala automaticamente
if ! command -v dialog &> /dev/null; then
    echo -e "${YELLOW}[*] O pacote 'dialog' não foi encontrado. Instalando para habilitar a interface gráfica...${NC}"
    sudo apt update && sudo apt install -y dialog
fi

# Função para exibir mensagens de aviso/sucesso
mensagem() {
    dialog --title "$1" --msgbox "$2" 10 50
}

# Loop principal do menu TUI
while true; do
    MENU=$(dialog --clear \
                --title " UBUNTU SYSTEM TOOLKIT - INFRA & SYSADMIN " \
                --menu "Escolha uma opção de gerenciamento:" \
                15 65 6 \
                "1" "Atualizar o Sistema (APT Update & Upgrade)" \
                "2" "Limpeza Geral (Cache, Pacotes Órfãos & Lixeira)" \
                "3" "Informações de Rede & Conectividade" \
                "4" "Diagnóstico de Sistema (Uso de Disco & Memória)" \
                "5" "Backup Rápido de Diretório Crítico" \
                "6" "Sair" \
                3>&1 1>&2 2>&3)

    case $MENU in
        1)
            # Atualização do Sistema
            {
                echo "10"; echo "=== Atualizando lista de pacotes ==="
                sudo apt update -y
                echo "50"; echo "=== Realizando upgrade do sistema ==="
                sudo apt upgrade -y
                echo "90"; echo "=== Removendo pacotes desnecessários ==="
                sudo apt autoremove -y
                echo "100"; echo "=== Processo Concluído! ==="
            } | dialog --title "Atualização do Sistema" --gauge "Processando atualizações..." 8 50 0
            mensagem "Sucesso" "O sistema foi atualizado com sucesso!"
            ;;
        2)
            # Limpeza do Sistema
            {
                echo "20"; echo "=== Limpando cache do APT ==="
                sudo apt clean
                sudo apt autoclean
                echo "60"; echo "=== Removendo pacotes órfãos ==="
                sudo apt autoremove --purge -y
                echo "100"; echo "=== Limpeza Finalizada! ==="
            } | dialog --title "Limpeza do Sistema" --gauge "Executando limpeza de arquivos..." 8 50 0
            mensagem "Sucesso" "Limpeza de sistema concluída com folga de espaço!"
            ;;
        3)
            # Informações de Rede
            NET_INFO=$(ip -brief address show; echo "-----------------------------------"; ip route show)
            dialog --title "Diagnóstico de Rede & Interfaces" --msgbox "$NET_INFO" 18 70
            ;;
        4)
            # Diagnóstico de Hardware/Sistema
            SYS_INFO=$(echo "=== USO DE DISCO (DF) ==="; df -h /; echo ""; echo "=== USO DE MEMÓRIA (FREE) ==="; free -h; echo ""; echo "=== CARGA DO SISTEMA (UPTIME) ==="; uptime)
            dialog --title "Diagnóstico de Hardware & Sistema" --msgbox "$SYS_INFO" 18 70
            ;;
        5)
            # Backup Rápido
            DIR_ORIGEM=$(dialog --inputbox "Digite o caminho absoluto do diretório que deseja fazer backup:" 10 50 "/etc" 3>&1 1>&2 2>&3)
            if [ -n "$DIR_ORIGEM" ] && [ -d "$DIR_ORIGEM" ]; then
                DESTINO="$HOME/backup_$(date +%Y%m%d_%H%M%S).tar.gz"
                tar -czf "$DESTINO" "$DIR_ORIGEM" 2>/dev/null
                mensagem "Backup Concluído" "O backup foi compactado com sucesso em:\n$DESTINO"
            else
                mensagem "Erro" "Diretório inválido ou não informado!"
            fi
            ;;
        6)
            clear
            echo -e "${GREEN}Encerrando o Ubuntu System Toolkit. Até logo!${NC}"
            exit 0
            ;;
    esac
done
