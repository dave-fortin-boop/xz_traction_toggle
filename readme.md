📘 README — car_traction_toggle
🚙 Description

car_traction_toggle est un script FiveM pour ESX Legacy, permettant de changer dynamiquement la traction de ton véhicule entre 2x4 (propulsion) et 4x4 (intégrale) directement depuis le menu radial ox_lib.

Idéal pour les serveurs RP mécano, police, offroad ou survival, ce système permet de simuler un vrai passage de différentiel 4x4/2x4 sans quitter le véhicule.

⚙️ Fonctionnalités

🔄 Bascule instantanée entre 2x4 et 4x4

🌍 Synchronisation entre joueurs (même traction pour tous autour)

🚗 Compatible avec les véhicules :

Offroad (class 9)

SUV (class 10)

Camions (class 11)

Industriels (class 14)

🧭 Intégration native au menu radial ox_lib

💬 Notifications stylées via ox_lib.notify

🧠 Script 100 % client-side pour la logique de traction + server-side pour la synchronisation

🧩 Dépendances

ox_lib v3.30.6+

ESX Legacy (ou framework compatible avec esx:getSharedObject)

📁 Installation

Place le dossier complet dans :

resources/[scripts]/car_traction_toggle


Ajoute ceci à ton server.cfg :

ensure ox_lib
ensure car_traction_toggle


Structure du dossier :

car_traction_toggle/
├─ fxmanifest.lua
├─ client.lua
└─ server.lua

💻 Utilisation

Entre dans un 4x4 / SUV / camion / véhicule offroad

Ouvre ton menu radial ox_lib (touche Z ou F1 selon ton serveur)

Sélectionne :

🚗 Mode 2x4 → propulsion arrière

🚙 Mode 4x4 → traction intégrale

Une notification te confirme le changement.

🔄 Synchronisation

Le serveur sauvegarde le mode de traction actif par plaque de véhicule.

Si tu changes de conducteur, le mode reste actif.

Les autres joueurs voient le même comportement physique.

🧰 Notes techniques

SetVehicleHandlingFloat(..., 'fDriveBiasFront', value) contrôle la répartition de traction :

0.0 = 100% arrière (2x4)

0.5 = 50/50 (4x4)

Aucun impact sur la base de données — stockage en mémoire côté serveur.

Aucun waitForResource() ni showRadial() requis (entièrement compatible avec ox_lib v3.30.6).

🔧 Personnalisation (optionnel)

Tu peux modifier la liste des classes autorisées :

if class ~= 9 and class ~= 10 and class ~= 11 and class ~= 14 then


➡️ Ajoute ou retire des types selon les véhicules autorisés à changer de traction.

🧠 Crédits

👨‍💻 Script : Xziot

⚙️ Assistance technique & structure : ChatGPT (GPT-5)

🧩 Frameworks : ESX Legacy & ox_lib (Overextended)