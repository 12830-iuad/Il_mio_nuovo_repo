#!/bin/zsh

# Script per automatizzare commit e push su GitHub

# Colori per l'output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}==> Inizio sincronizzazione Git...${NC}"

# Controlla se ci sono modifiche
if [[ -z $(git status -s) ]]; then
    echo -e "${YELLOW}Nessuna modifica rilevata.${NC}"
    exit 0
fi

# Chiedi il messaggio di commit se non passato come argomento
COMMIT_MSG=$1
if [[ -z "$COMMIT_MSG" ]]; then
    echo -e "${YELLOW}Inserisci il messaggio di commit:${NC}"
    read COMMIT_MSG
fi

# Se il messaggio è ancora vuoto, usa un default
if [[ -z "$COMMIT_MSG" ]]; then
    COMMIT_MSG="Aggiornamento automatico: $(date +'%Y-%m-%d %H:%M:%S')"
fi

# Ottieni il nome del branch corrente
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo -e "${BLUE}==> Branch rilevato: ${GREEN}$CURRENT_BRANCH${NC}"

# Aggiungi tutto
git add .

# Commit
echo -e "${BLUE}==> Esecuzione commit...${NC}"
git commit -m "$COMMIT_MSG"

# Push
echo -e "${BLUE}==> Invio delle modifiche su GitHub (${GREEN}$CURRENT_BRANCH${NC})...${NC}"
git push origin "$CURRENT_BRANCH"

if [[ $? -eq 0 ]]; then
    echo -e "${GREEN}✅ Sincronizzazione completata con successo!${NC}"
else
    echo -e "${RED}❌ Errore durante il push. Controlla la tua connessione o le credenziali.${NC}"
fi
