# `remote_me` - un tunnel ssh reverse pour la prise de control à distance

**English reader**: Ask for translation if you're interested

`remote_me` est un petit outil pour les informatitciens qui veulent fournir une prise de contrôle à distance pour des
PC linux qui ont un serveur ssh, et dernière un réseau NATé.

Par exemple un PC sous linux que vous avez livré à belle maman, derrière une box Internet.


Le script utilise le principe du **reverse tunnel ssh** vers un serveur distant qui permet à l'informatitcien de passer par
ce même serveur et de se connecter via le tunnel ouvert par le client. Il se trouve alors en SSH sur le PC du client.


## État de développement

Encore à l'état de prototype.
Mais fonctionnel.


## Requis

Vous avez besoin d'un serveur linux avec ssh connecté à l'Internet. Voir plus loin pour un exemple d'installation.


## Installation

### PC client

Sur le PC client (que vous voulez controlé à distance):

clone du repository:
~~~
git clone https://github.com/Sylvain303/ssh-remote_me.git remote_me
~~~

installation du serveur ssh sur le PC client

~~~
sudo apt install openssh-serveur
~~~

Génération de la clé ssh client
~~~
ssh-keygen -t rsa -C "$USER@remote_me_user_key" -f ~/.ssh/remote_me_key
~~~

Édition du code pour changer les users et nom de serveur

~~~
cd remote_me
vim remote_me.sh
~~~

éditez les lignes (ça deviendra configurable plus tard)
~~~
# edit remote config here:
remotehost=myserver.remote-name.net
remote_user=depanage
~~~

### Sur le serveur que vous voulez utiliser en relais

Exemple sous debian Linux

~~~
adduser remoteme
su - remoteme
~~~


## Usage

Par téléphone, puisque que c'est de la prise de contôle à distance, hein… 

Dicter au client : (c'est vous qui avez déposé le code au préalable probablement)
On peut aussi lui envoyer un email.

~~~
cd remote_me
./remote_me.sh
~~~

À vous de jouer !

## Amélirorations possibles

Inclure la génération de clé lors d'un process d'initialisation et question de configuration
~~~
./remote_me.sh init
~~~

ou

~~~
./remote_me.sh init -u remote_user -h remotehost.example.net
~~~

diagnostique de connexion.
~~~
./remote_me.sh verify
~~~

Configuration d'un serveur point de relais chez soi à la volée en Upnp ? 
Côté informaticien.

~~~
./remote_me.sh install-server
~~~

packager le tout.
