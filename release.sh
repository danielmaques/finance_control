#!/bin/bash

# Pega a versão atual do pubspec.yaml
CURRENT_VERSION=$(grep 'version:' pubspec.yaml | sed 's/version: //g')

# Divide a versão em major, minor e patch
IFS='.' read -ra VERSION_PARTS <<< "$CURRENT_VERSION"
MAJOR=${VERSION_PARTS[0]}
MINOR=${VERSION_PARTS[1]}
PATCH=${VERSION_PARTS[2]}

# Incrementa o patch
NEW_PATCH=$((PATCH + 1))

# Combina para formar a nova versão
NEW_VERSION="$MAJOR.$MINOR.$NEW_PATCH"

# Atualiza o pubspec.yaml com a nova versão
sed -i "s/version: $CURRENT_VERSION/version: $NEW_VERSION/g" pubspec.yaml

# Gera um release
flutter build apk --release

echo "Versão atualizada para $NEW_VERSION e release gerado!"
