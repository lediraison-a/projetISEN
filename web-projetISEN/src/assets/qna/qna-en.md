# QnA

On this page you will find helpful information about the use and functioning of Dish, the allergen detection application.

If you cannot find the answer to one of your question, feel free to [contact us](/contact).

---
## How do I fill in my allergens?
To fill in your allergens, visit the [User page](/user).
Here you can add and view the allergens you have already filled in.
By clicking on the [+] button, you can choose an allergen from the displayed list.

![Screenshot of allergen list](./img/EcranUtilisateurAllergenes.png "")

Remember to save the changes made by clicking on the _Save Changes_ button.

## My account seems deactivated. What should I do ?
If you encounter the following error while trying to log in, it is that your account has been deactivated by an administrator:

![Screenshot of a login error after an administrator deactivated the account](./img/EcranUtilisateurAllergenes.png "")

You can [contact us](/contact) to solve this problem, or create a new account with a different email address from the blocked account.

## How to download the mobile app ?
The mobile app can be downloaded from the [download page](/download).
An APK file will then be downloaded to your computer.
This one corresponds to a mobile application that you can install on your smartphone.
Make sure your smartphone allows application installation from this type of file.

## What do I do if I forgot my password?
If you forget your password, you can request a new one.
To do this, go to [the login page](/signin).
After filling in your login email address, click _Troubles signin in? _ .

![Screen shot of login page with password forgotten](./img/EcranUtilisateurAllergenes.png "")

You will then receive an email to the email address you entered, which will allow you to enter a new password.

## How do I fill in an allergen that is not on the list?
If an allergen is not available in the list of allergens, please [contact our team](/contact).

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