# Guide d'Installation - FLUX.2-klein-4B

Guide complet pour installer le générateur d'images IA sur votre ordinateur Windows.

## 📋 Ce dont vous avez besoin

- **Ordinateur Windows** 10 ou 11
- **16 GB de RAM** minimum
- **20 GB d'espace disque** libre
- **Connexion Internet** (seulement pour l'installation)
- **Carte NVIDIA** (optionnel mais fortement recommandé pour la vitesse)

## 🚀 Installation en 4 étapes

### Étape 1: Installer Python

1. Allez sur https://www.python.org/downloads/
2. Téléchargez **Python 3.10** ou **Python 3.11** (PAS 3.12+)
3. Lancez l'installateur
4. **⚠️ IMPORTANT**: Cochez la case "Add Python to PATH"
5. Cliquez sur "Install Now"
6. Attendez la fin de l'installation

**Comment vérifier:**
- Ouvrez l'invite de commandes (touche Windows + R, tapez `cmd`)
- Tapez `python --version`
- Vous devriez voir "Python 3.10.x" ou "Python 3.11.x"

---

### Étape 2: Installer Git

1. Allez sur https://git-scm.com/downloads
2. Téléchargez Git pour Windows
3. Lancez l'installateur
4. Utilisez les paramètres par défaut (cliquez sur "Next" partout)
5. Attendez la fin de l'installation

**Pourquoi Git?**
Git est nécessaire pour télécharger certaines bibliothèques Python.

---

### Étape 3: Installer les drivers NVIDIA (si vous avez une carte NVIDIA)

1. Allez sur https://www.nvidia.com/drivers
2. Sélectionnez votre carte graphique
3. Téléchargez le dernier driver
4. Installez-le
5. **Redémarrez votre ordinateur**

**Comment vérifier:**
- Ouvrez l'invite de commandes
- Tapez `nvidia-smi`
- Vous devriez voir les infos de votre carte graphique

**Pas de carte NVIDIA?**
Pas de problème! L'application fonctionnera sur CPU (juste plus lent).

---

### Étape 4: Installer FLUX.2-klein-4B

1. **Téléchargez** le dossier complet du projet
2. **Double-cliquez** sur `install.bat`
3. Le script va vérifier votre système et vous poser quelques questions
4. **Attendez** 10-30 minutes selon votre connexion internet
5. Le script téléchargera ~10 GB de données

**Que fait le script:**
- ✓ Vérifie Python et Git
- ✓ Vérifie votre GPU NVIDIA
- ✓ Crée un environnement virtuel Python
- ✓ Télécharge PyTorch avec support CUDA
- ✓ Télécharge toutes les bibliothèques nécessaires
- ✓ Télécharge le modèle IA (~8 GB)
- ✓ Vérifie que tout fonctionne

**À la fin vous verrez:**
```
========================================
  Installation Complete!
========================================

[SUCCESS] GPU acceleration is enabled!
Your images will generate much faster.

To start the application, run: run.bat
```

---

## ✅ Démarrer l'application

1. **Double-cliquez** sur `run.bat`
2. Une fenêtre noire s'ouvrira (ne la fermez pas!)
3. Votre navigateur s'ouvrira automatiquement
4. L'interface apparaît à: http://127.0.0.1:7860

**Première utilisation:**
- Le chargement du modèle prend 30-60 secondes
- Vous verrez "Model loaded successfully!"
- L'interface web est maintenant prête

---

## 🎨 Comment utiliser

### Générer une image

1. **Tapez votre description** dans "Prompt"
   - Exemple: "un chat portant des lunettes de soleil, photo réaliste"
   - Plus c'est détaillé, mieux c'est!

2. **Ajustez les paramètres** (optionnel)
   - **Width/Height**: Taille de l'image (1024x1024 par défaut)
   - **Guidance Scale**: 3.5 recommandé (plus bas = créatif, plus haut = précis)
   - **Seed**: -1 pour aléatoire, ou un nombre pour reproduire

3. **Cliquez** sur "🚀 Generate / Edit"

4. **Attendez** 5-30 secondes

5. **Votre image** apparaît!

### Modifier une image

1. **Cliquez** sur "Input Image" et uploadez une photo
2. **Tapez** ce que vous voulez changer
   - Exemple: "transforme en coucher de soleil"
3. **Cliquez** sur "🚀 Generate / Edit"
4. L'IA modifie votre image!

---

## ⚡ Vitesse de génération

| Configuration | Temps par image |
|--------------|----------------|
| GPU RTX 4090 | ~5 secondes |
| GPU RTX 3060 | ~10 secondes |
| GPU GTX 1660 | ~20 secondes |
| CPU moderne | 1-3 minutes |

---

## ❓ Problèmes courants

### "Python is not installed"
**Solution:**
1. Installez Python 3.10 ou 3.11
2. Cochez bien "Add Python to PATH"
3. Redémarrez votre ordinateur
4. Relancez `install.bat`

---

### "Git is not installed"
**Solution:**
1. Installez Git depuis https://git-scm.com/downloads
2. Redémarrez votre ordinateur
3. Relancez `install.bat`

---

### GPU non détecté / Génération très lente
**Solution:**
1. Vérifiez que vous avez une carte NVIDIA
2. Installez les derniers drivers: https://www.nvidia.com/drivers
3. Redémarrez votre ordinateur
4. Lancez `install_cuda.bat`
5. Relancez l'application

---

### "Out of memory" ou crash
**Solution:**
1. Réduisez la taille des images (essayez 768x768)
2. Fermez les autres applications
3. Si GPU < 8GB: utilisez des dimensions plus petites

---

### Le téléchargement échoue
**Solution:**
1. Vérifiez votre connexion internet
2. Désactivez temporairement VPN/pare-feu
3. Relancez `install.bat` (le téléchargement reprend où il s'est arrêté)

---

## 🔧 Scripts disponibles

| Script | Quand l'utiliser |
|--------|-----------------|
| `install.bat` | Installation complète (détecte et répare tout automatiquement!) |
| `run.bat` | Démarrer l'application |
| `reinstall.bat` | Réinstallation propre en cas de gros problèmes |

---

## 💡 Conseils pour de meilleures images

### Prompts efficaces

**❌ Mauvais:**
- "chat"
- "voiture"

**✓ Bons:**
- "un chat tigré portant des lunettes de soleil, assis sur un bureau, photo professionnelle, éclairage naturel"
- "une voiture de sport rouge sur une route de montagne au coucher du soleil, photo réaliste, 4k"

**Mots-clés utiles:**
- Style: "photorealistic", "artistic", "cartoon", "oil painting"
- Qualité: "4k", "high quality", "detailed", "professional"
- Éclairage: "sunset", "golden hour", "studio lighting"

---

### Paramètres

**Guidance Scale:**
- **1.0-2.0**: Très créatif, peut s'éloigner du prompt
- **3.5**: Équilibré (recommandé)
- **5.0-10.0**: Suit le prompt strictement

**Dimensions:**
- **1024x1024**: Carré, meilleure qualité
- **1280x768**: Paysage (horizontal)
- **768x1280**: Portrait (vertical)
- Plus petit = plus rapide, plus grand = plus de détails

**Seed:**
- **-1**: Aléatoire (différent à chaque fois)
- **12345** (ou autre nombre): Reproductible (même image avec même prompt)

---

## 📊 Utilisation de la mémoire

| Résolution | VRAM GPU | RAM |
|-----------|----------|-----|
| 512x512 | ~4 GB | ~8 GB |
| 768x768 | ~6 GB | ~10 GB |
| 1024x1024 | ~8 GB | ~12 GB |
| 1280x1280 | ~10 GB | ~16 GB |

---

## 🎓 Pour aller plus loin

### Exemples de prompts

**Portrait:**
```
a professional portrait photo of a young woman with curly hair,
wearing a blue sweater, natural lighting, soft focus, 4k
```

**Paysage:**
```
a mountain landscape at sunset, snow-capped peaks,
golden hour lighting, dramatic clouds, photorealistic, 8k
```

**Art:**
```
a cat dressed as a samurai, digital art, detailed armor,
dramatic pose, cherry blossoms background, artstation quality
```

**Produit:**
```
a modern smartphone on a wooden desk, studio lighting,
professional product photography, white background, 4k
```

---

## ⚖️ Licence et usage

- **Modèle IA**: Apache 2.0 (open source, gratuit)
- **Usage commercial**: ✓ Autorisé
- **Modification**: ✓ Autorisé
- **Partage**: ✓ Autorisé

Vous pouvez utiliser les images générées pour:
- Projets personnels
- Projets commerciaux
- Publications sur les réseaux sociaux
- Tout ce que vous voulez!

---

## 📞 Besoin d'aide?

1. **Lisez** ce guide en entier
2. **Vérifiez** la section "Problèmes courants"
3. **Consultez** le fichier README.md (en anglais, plus détaillé)
4. **Relancez** `reinstall.bat` en cas de doute

---

## ✨ C'est tout!

Vous êtes prêt à créer des images incroyables avec l'IA! 🎨

**N'oubliez pas:**
- La première génération est toujours plus lente (compilation)
- Soyez descriptif dans vos prompts
- Expérimentez avec les paramètres
- Amusez-vous! 😊
