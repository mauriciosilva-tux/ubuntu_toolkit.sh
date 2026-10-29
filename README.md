# 🐧 Ubuntu System Toolkit (TUI)

> Um toolkit interativo em Bash com interface gráfica em terminal (TUI) voltado para automação de tarefas de manutenção, limpeza, diagnóstico de rede/hardware e backups rápidos em sistemas Ubuntu.

---

## 🚀 Sobre o Projeto

Desenvolvido com foco em **Infraestrutura, SysAdmin e automação de rotinas**, este script utiliza o utilitário `dialog` para prover uma experiência visual limpa e amigável diretamente no terminal. O objetivo é otimizar o tempo de administradores de sistemas e entusiastas de Linux em tarefas repetitivas de manutenção preventiva e corretiva.

---

## ✨ Funcionalidades

O toolkit oferece um menu interativo com as seguintes opções:

1. **Atualização do Sistema (`APT Update & Upgrade`)**: Executa a atualização completa dos repositórios, upgrade de pacotes e remoção de órfãos com indicador gráfico de progresso (`gauge`).
2. **Limpeza Geral**: Realiza a limpeza de cache do APT (`clean` e `autoclean`) e expurga pacotes residuais/órfãos (`autoremove --purge`).
3. **Informações de Rede & Conectividade**: Exibe de forma resumida o status das interfaces de rede e a tabela de roteamento (`ip -brief` e `ip route`).
4. **Diagnóstico de Sistema**: Monitora o uso de espaço em disco (`df -h`), consumo de memória RAM (`free -h`) e tempo de atividade/carga (`uptime`).
5. **Backup Rápido**: Permite compactar qualquer diretório crítico do sistema (ex: `/etc`) em um arquivo `.tar.gz` nomeado com timestamp de forma automatizada.

---

## ⚙️ Pré-requisitos

O script foi projetado para distribuições **Ubuntu** (e derivados baseados em Debian). 
* O utilitário **`dialog`** é necessário para renderizar a interface gráfica TUI. Caso ele não esteja instalado na sua máquina, **o próprio script detecta e faz a instalação automática** (`sudo apt install dialog`).

---

## 📥 Instalação e Uso

1. Clone o repositório ou baixe o arquivo do script:
   ```bash
   git clone [https://github.com/mauriciosilva-tux/ubuntu-system-toolkit.git](https://github.com/mauriciosilva-tux/ubuntu-system-toolkit.git)
   cd ubuntu-system-toolkit
