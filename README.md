# Template for LaTeX article using SageTex + Jupyter Notebooks

## Necessary Environment

### Manual Setup
This project comes with a devcontainer specified, which is the easier way to
get started (see below). If you want to set up the environment manually, you
need:
- LaTeX distribution (e.g. TeXLive)
  - Including the `mylatexformat` package
  - CLI utilities such as `make`, `latexmk`, and `sed` (typically included)
- SageMath installation
  - `sagetex` LaTex package corresponding to this installation must be visible
    to LaTex distribution. You can find details
    [here](https://doc.sagemath.org/html/en/tutorial/sagetex.html#sec-sagetex-install)

### VSCode (or other IDE supporting DevContainers)
On a computer with the following installed:
- VSCode
  - *extension*: Remote Containers
- Docker

Start by cloning a repository that uses this template. When open in VSCode,
you should be prompted to reopen in a container. If not, you can do so by
opening the command palette (Ctrl+Shift+P) and searching for "Reopen in Container".

### GitHub Codespaces
On the GitHub website, use this template to create a new repository. Then,
after clicking the "Code" button, select "Open with Codespaces" > "New
Codespace on main".
After a few minutes, you should have a working environment in your browser
hosted in the cloud. The first 60hrs of each month should be free.

### Installing SageMath/Python Packages (VSCode/Codespaces)
In [.devcontainer/devcontainer.json], you can uncomment the
`postCreateCommand` line, and add shell commands to install any packages you
need.
To use `pip`, `sage` or `python` in this command, you will need to run this in
Bash instead of the default shell, e.g. `bash -c "pip install <package>"`.

## Suggested Workflow

### Clean Build
To build the project (and create the PDF `main.pdf`), run `make` in the root
directory.

### Continuous Build

#### LaTeX -> PDF
After opening the project for the first time, run `make` as above.
Then, when working on the latex document, you can use `latexmk`,
`latexmk -pvc` or your editor's build system (configured to use `latexmk`) to
build the PDF.
The preamble is located in `preamble.tex`, make sure to run `make preamble`
after any changes to this file.

#### Jupyter -> LaTeX
I recommend doing most of the SageMath work in Jupyter notebooks, for easier
iteration and a better experience (including debugging and language
intelligence in some environments).

Create a Sage object or plot as a variable (say `var`) that you need in the
LaTeX document, and make sure that `var` is not modified in the rest of the
notebook.
You can then import that variable into the LaTeX document by adding the
following in `main.tex`:

```latex
\begin{sagesilent}
from notebook import var
\end{sagesilent}
```

Then you can use `var` later in the document in mathmode (e.g. `\sage{var}`),
or display a plot (e.g. `\sageplot{var}`), see [main.tex] for examples in this
template.

Run `make sage_artifacts`, after this, a new build should be triggered for
`latexmk`, which will then render the SageMath objects correctly in the PDF.
