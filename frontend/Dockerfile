# Étape 1 : Construire l'application Next.js
FROM node:18.17.0 AS build

# Définir le répertoire de travail
WORKDIR /frontend

# Copier package.json et package-lock.json pour installer les dépendances
COPY package.json package-lock.json ./

# Installer les dépendances
RUN npm install

# Copier le reste du code source
COPY . .

# Compiler l'application Next.js
RUN npm run build

# Étape 2 : Démarrer le serveur Next.js
FROM node:18.17.0

# Définir le répertoire de travail
WORKDIR /frontend

# Copier les fichiers de build et les dépendances installées
COPY --from=build /frontend/.next /frontend/.next
COPY --from=build /frontend/node_modules /frontend/node_modules
COPY --from=build /frontend/package.json /frontend/package.json

# Exposer le port utilisé par Next.js
EXPOSE 3000

# Définir les variables d'environnement pour Next.js
ENV PORT 3000
ENV HOST 0.0.0.0

# Démarrer le serveur Next.js
CMD ["npx", "next", "start", "--port", "3000", "--hostname", "0.0.0.0"]
