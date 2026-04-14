# VS Code Setup

## Install

Download from [code.visualstudio.com](https://code.visualstudio.com/).
Install on Windows; connect to WSL via the `ms-vscode-remote.remote-wsl`.

## Extensions

### Windows Layer

Install on Windows (run in PowerShell or Windows terminal):

```powershell
# Core connectivity
code --install-extension ms-vscode-remote.remote-wsl

# TypeScript / JavaScript
code --install-extension yoavbls.pretty-ts-errors

# Fonts & appearance
code --install-extension aaron-bond.better-comments
```

### WSL Layer

```bash
# TypeScript / JavaScript
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension yoavbls.pretty-ts-errors

# Git & UI
code --install-extension eamodio.gitlens
code --install-extension vivaxy.vscode-conventional-commits

# Linting & analysis
code --install-extension SonarSource.sonarlint-vscode

# Spell checker (works on both, but content lives in WSL)
code --install-extension streetsidesoftware.code-spell-checker

# Fonts & appearance
code --install-extension seyyedkhandon.firacode

```

## Settings — Windows (`settings.json`)

```json
{
  // ─────────────────────────────────────────
  // EDITOR — Typography & Appearance
  // ─────────────────────────────────────────
  "editor.fontFamily": "Fira Code",
  "editor.fontLigatures": true,
  "editor.smoothScrolling": true,
  "editor.cursorBlinking": "phase",
  "editor.cursorSmoothCaretAnimation": "on",
  "editor.minimap.enabled": false,
  "editor.bracketPairColorization.enabled": true,
  "editor.guides.bracketPairs": true,
  "editor.renderWhitespace": "selection",
  "editor.semanticHighlighting.enabled": true,
  "editor.stickyScroll.enabled": true,

  // ─────────────────────────────────────────
  // EDITOR — Formatting & Indentation
  // ─────────────────────────────────────────
  "editor.formatOnSave": true,
  "editor.insertSpaces": true,
  "editor.tabSize": 2,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.linkedEditing": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit",
    "source.organizeImports": "explicit"
  },

  // ─────────────────────────────────────────
  // FILES
  // ─────────────────────────────────────────
  "files.autoSave": "onFocusChange",
  "files.insertFinalNewline": true,
  "files.trimTrailingWhitespace": true,
  "files.trimFinalNewlines": true,
  "files.eol": "\n",

  // ─────────────────────────────────────────
  // WORKBENCH
  // ─────────────────────────────────────────
  "workbench.externalBrowser": "firefox",
  "workbench.colorTheme": "Dark+",
  "workbench.list.smoothScrolling": true,
  "workbench.preferredLightColorTheme": "Dark+",
  "window.autoDetectColorScheme": false,
  "workbench.settings.enableNaturalLanguageSearch": false,

  // ─────────────────────────────────────────
  // WINDOW
  // ─────────────────────────────────────────
  "window.title": "${dirty}${activeEditorMedium}${separator}${rootName}",

  // ─────────────────────────────────────────
  // TERMINAL
  // ─────────────────────────────────────────
  "terminal.integrated.defaultProfile.windows": "Ubuntu",
  "terminal.integrated.scrollback": 10000,
  "terminal.integrated.copyOnSelection": true,

  // ─────────────────────────────────────────
  // DIFF EDITOR
  // ─────────────────────────────────────────
  "diffEditor.renderSideBySide": true,
  "diffEditor.ignoreTrimWhitespace": true,

  // ─────────────────────────────────────────
  // GIT
  // ─────────────────────────────────────────
  "git.confirmSync": false,
  "git.enableCommitSigning": true,
  "git.autofetch": true,
  "git.allowNoVerifyCommit": true,
  "git.ignoredRepositories": ["/home/arekz/.nvm"],

  // ─────────────────────────────────────────
  // LANGUAGES (JS/TS)
  // ─────────────────────────────────────────
  "js/ts.updateImportsOnFileMove.enabled": "always",
  "js/ts.preferences.importModuleSpecifier": "non-relative",
  "js/ts.preferences.autoImportSpecifierExcludeRegexes": ["^@mui/[^/]+$"],

  // ─────────────────────────────────────────
  // EXTENSIONS — SonarLint & GitLens
  // ─────────────────────────────────────────
  "gitlens.telemetry.enabled": false,
  "sonarlint.automaticAnalysis": true,
  "sonarlint.focusOnNewCode": false,
  "sonarlint.disableTelemetry": true,
  "sonarlint.pathToNodeExecutable": "/home/arekz/node-active",

  // ─────────────────────────────────────────
  // SEARCH & TELEMETRY
  // ─────────────────────────────────────────
  "telemetry.telemetryLevel": "off",
  "remote.autoForwardPortsSource": "hybrid",
  "search.exclude": {
    "**/node_modules": true,
    "**/dist": true,
    "**/.git": true,
    "**/__pycache__": true,
    "**/.next": true
  }
}
```

sonarlint.pathToNodeExecutable requires fresh path to current node version.
It is solved by creation of a `node-active` symlink - see `.bashrc`
