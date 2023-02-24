# FAQ

Vous trouverez sur cette page des informations utiles sur l'utilisation et le fonctionnement de Dish, l'application de détection d'allergènes.

Si vous ne trouvez pas de réponse à votre question, n'hésitez pas [nous contacter](/contact).

---

## Comment renseigner mes allergènes ?
Pour renseigner vos allergènes, rendez-vous sur la page [Utilisateur](/user).
Ici, vous pouvez ajouter et visualiser les allergènes que vous avez déjà renseignés.
En cliquant sur le bouton [+], vous avez la possibilité de choisir un allergène parmi la liste affichée.

![Capture d'écran de la liste d'allergènes](./img/EcranUtilisateurAllergenes.png "")

N'oubliez pas de sauvegarder les modifications effectuées en cliquant sur le bouton _Sauvegarder les changements_.

## Mon compte est marqué comme étant désactivé. Que dois-je faire ?
Si en essayant de vous connecter vous rencontrer l'erreur suivante, c'est que votre compte a été désactivé par un administrateur :

![Capture d'écran d'une erreur de connexion suite à la désactivation du compte par un administrateur](./img/EcranCompteDesactive.png "")

Vous pouvez [nous contacter](/contact) afin de résoudre ce problème, ou créer un nouveau compte avec une adresse mail différente du compte bloqué.

## Comment télécharger l'application mobile ?
L'application mobile peut être téléchargée sur [la page de téléchargement](/download).
Un fichier sous format APK sera alors téléchargé sur votre ordinateur.
Celui-ci correspondant à une application mobile que vous pouvez installer sur votre smartphone.
Assurez-vous que votre smartphone permette l'installation d'application à partir de ce type de fichier.

## Que faire en cas d'oubli de mot de passe ?
En cas d'oubli de mot de passe, vous pouvez en demandez un nouveau.
Pour cela, rendez-vous sur [la page de connexion](/signin).
Après avoir renseigné votre adresse mail de connexion, cliquez sur _Troubles signin in?_ .

![Capture d'écran de la page de connexion avec oubli de mot de passe](./img/EcranMotDePasseOublie.png "")

Vous recevrez alors un mail à l'adresse mail renseignée qui vous permettra de renseigner un nouveau mot de passe.

## Comment renseigner un allergène qui n'est pas présent dans la liste ?
Si un allergène n'est pas disponible dans la liste des allergènes, veuillez [prendre contact avec notre équipe](/contact).

---

## Features

- Import a HTML file and watch it magically convert to Markdown
- Drag and drop images (requires your Dropbox account be linked)
- Import and save files from GitHub, Dropbox, Google Drive and One Drive
- Drag and drop markdown and HTML files into Dillinger
- Export documents as Markdown, HTML and PDF

Markdown is a lightweight markup language based on the formatting conventions
that people naturally use in email.
As [John Gruber] writes on the [Markdown site][df1]

> The overriding design goal for Markdown's
> formatting syntax is to make it as readable
> as possible. The idea is that a
> Markdown-formatted document should be
> publishable as-is, as plain text, without
> looking like it's been marked up with tags
> or formatting instructions.

This text you see here is *actually- written in Markdown! To get a feel
for Markdown's syntax, type some text into the left window and
watch the results in the right.

## Tech

Dillinger uses a number of open source projects to work properly:

- [AngularJS] - HTML enhanced for web apps!
- [Ace Editor] - awesome web-based text editor
- [markdown-it] - Markdown parser done right. Fast and easy to extend.
- [Twitter Bootstrap] - great UI boilerplate for modern web apps
- [node.js] - evented I/O for the backend
- [Express] - fast node.js network app framework [@tjholowaychuk]
- [Gulp] - the streaming build system
- [Breakdance](https://breakdance.github.io/breakdance/) - HTML
to Markdown converter
- [jQuery] - duh

And of course Dillinger itself is open source with a [public repository][dill]
 on GitHub.

## Installation

Dillinger requires [Node.js](https://nodejs.org/) v10+ to run.

Install the dependencies and devDependencies and start the server.

```sh
cd dillinger
npm i
node app
```

For production environments...

```sh
npm install --production
NODE_ENV=production node app
```

## Plugins

Dillinger is currently extended with the following plugins.
Instructions on how to use them in your own application are linked below.

| Plugin | README |
| ------ | ------ |
| Dropbox | [plugins/dropbox/README.md][PlDb] |
| GitHub | [plugins/github/README.md][PlGh] |
| Google Drive | [plugins/googledrive/README.md][PlGd] |
| OneDrive | [plugins/onedrive/README.md][PlOd] |
| Medium | [plugins/medium/README.md][PlMe] |
| Google Analytics | [plugins/googleanalytics/README.md][PlGa] |

## Development

Want to contribute? Great!

Dillinger uses Gulp + Webpack for fast developing.
Make a change in your file and instantaneously see your updates!

Open your favorite Terminal and run these commands.

First Tab:

```sh
node app
```

Second Tab:

```sh
gulp watch
```

(optional) Third:

```sh
karma test
```

#### Building for source

For production release:

```sh
gulp build --prod
```

Generating pre-built zip archives for distribution:

```sh
gulp build dist --prod
```

## Docker

Dillinger is very easy to install and deploy in a Docker container.

By default, the Docker will expose port 8080, so change this within the
Dockerfile if necessary. When ready, simply use the Dockerfile to
build the image.

```sh
cd dillinger
docker build -t <youruser>/dillinger:${package.json.version} .
```

This will create the dillinger image and pull in the necessary dependencies.
Be sure to swap out `${package.json.version}` with the actual
version of Dillinger.

Once done, run the Docker image and map the port to whatever you wish on
your host. In this example, we simply map port 8000 of the host to
port 8080 of the Docker (or whatever port was exposed in the Dockerfile):

```sh
docker run -d -p 8000:8080 --restart=always --cap-add=SYS_ADMIN --name=dillinger <youruser>/dillinger:${package.json.version}
```

> Note: `--capt-add=SYS-ADMIN` is required for PDF rendering.

Verify the deployment by navigating to your server address in
your preferred browser.

```sh
127.0.0.1:8000
```

## License

MIT

<style scoped>

img {
  display: block;
  margin-left: auto;
  margin-right: auto;
  border: solid hsla(160, 100%, 37%, 1) 2px !important;
  width: 60%;
  height: 50%
}

</style>