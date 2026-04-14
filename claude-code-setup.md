# Claude Code Setup

## Claude Code — MCP Plugins

| Plugin                          | Notes                                                                                                 |
| ------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `mui-mcp`                       | MUI component context                                                                                 |
| `context7`                      | Library documentation lookup                                                                          |
| `explonatory-output-style`      | Output formatting                                                                                     |
| `feature-dev`                   | Feature development workflow                                                                          |
| `frontend-design`               | Design system guidance                                                                                |
| `gitlab` + `gitlab-mcp`         | GitLab integration                                                                                    |
| `gopls-lsp`                     | Go language server                                                                                    |
| `playwright` + `playwright-mcp` | E2E testing                                                                                           |
| `rust-analyzer-lsp`             | Rust language server                                                                                  |
| `typescript-lsp`                | TypeScript language server                                                                            |
| `chrome-devtools-mcp`           | Browser DevTools integration                                                                          |
| `datadog mcp`                   | claude mcp add -s user --transport http datadog https://mcp.datadoghq.com/api/unstable/mcp-server/mcp |
| `tilt mcp`                      | https://github.com/0xBigBoss/tilt-mcp                                                                 |
| `claude-code-setup`             |                                                                                                       |
| `code-review`                   |                                                                                                       |
| `code-simplifier`               |                                                                                                       |

---

## `CLAUDE.md` — WSL Global Config

Location: `/home/arekz/.claude/CLAUDE.md`

```md
# Environment

- OS: Ubuntu 24.04 on WSL2 (Windows 11 host)
- Shell: Bash — or PowerShell for Windows
- Editor: VS Code connected to WSL via WSL extension
- Source code lives on the WSL filesystem (not /mnt/c/)
- Node.js managed via nvm; package manager is pnpm (never use npm or yarn)

# Communication

- Use English, be extremely concise; sacrifice grammar for brevity
- Confirm before introducing changes that were not discussed
- Act as a collaborator, not a code generator — explain decisions and trade-offs so I deepen my understanding
- Before starting work, research the problem and come back with 2–3 options with drawbacks; don't jump into implementation
- Make sure I understand every line of code you write — if something is non-obvious, explain it
- End plans with a list of unresolved questions, if any

# Skills & Experience

- I'm proficient in JS and TypeScript with a React frontend background — skip basic explanations unless asked
- Transitioning to general-purpose fullstack — be extra educational about backend, infrastructure, networking, and databases
- Learning backend in JS/TS - explain concepts, patterns, and idioms as they come up

# Code

## Principles

- Write highly maintainable, clear code that is readable without deep context
- Follow established best practices and conventions of the tools, frameworks, and libraries in use
- Explicit over implicit; composition over inheritance
- Don't over-abstract prematurely — duplication is cheaper than the wrong abstraction
- Always consider edge cases and input validation
- When refactoring, preserve existing test coverage and behavior
- Prefer small, focused PRs/MRs over large sweeping changes

## Style

- Keep functions short and single-purpose
- Use early returns to reduce nesting; avoid deeply nested ternaries
- Prefer descriptive names over comments; add comments for "why" not "what"
- Extract magic numbers and strings to named constants
- Prefer immutable patterns: readonly, as const, spread over mutation
- Colocate related code — keep helpers close to where they're used
- Prefer named exports over default exports
- Use const and arrow functions for components and utilities

## TypeScript

- Code must pass linting, formatting, and typechecking at all times — don't defer fixes
- Strict mode: no implicit any, strict null checks, prefer unknown over any
- Prefer well-maintained, widely adopted dependencies over niche ones

# Git

- Branch naming: `az/<TICKET-ID>-short-description`
- Use conventional commits: feat:, fix:, chore:, refactor:, docs:, test:, ci:
- Atomic commits with shor but meaningful messages
- Commits must be GPG signed; pre-commit hooks running linting, formatting, and typechecking hooks must pass
- Rebase from origin/main — never merge main into feature branches
- When branching from origin/main, use `--no-track` or unset upstream; verify tracking with `git status` before pushing
- **Never commit or push to main.** Run `git branch --show-current` before every commit. If on main, stop and ask for a branch name.
- **Never run `git commit` unprompted.** After code changes, stop and report. Wait for explicit instruction.
- **Only stage files the user explicitly named.** Do not bundle unmentioned changes.

# Testing

- Always consider testability when writing or refactoring code
- When fixing a bug, suggest a regression test if one doesn't exist
```

npx skills add vercel-labs/agent-skills

Install 3 skills globaly

◇ Installed 3 skills ──────────────────────────────────────────╮

│ │

│ ✓ ~/.agents/skills/vercel-composition-patterns │

│ symlinked: Claude Code │

│ ✓ ~/.agents/skills/vercel-react-best-practices │

│ symlinked: Claude Code │

│ ✓ ~/.agents/skills/web-design-guidelines │

│ symlinked: Claude Code

---

\~/.claude/settings.json

```javascript
{
  "model": "sonnet[1m]",
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "powershell.exe -c \"[console]::beep(800,200)\"",
            "async": true
          }
        ]
      }
    ]
  },
  "enabledPlugins": {
    "frontend-design@claude-plugins-official": true,
    "context7@claude-plugins-official": true,
    "code-review@claude-plugins-official": true,
    "code-simplifier@claude-plugins-official": true,
    "feature-dev@claude-plugins-official": true,
    "playwright@claude-plugins-official": true,
    "typescript-lsp@claude-plugins-official": true,
    "claude-code-setup@claude-plugins-official": true,
    "explanatory-output-style@claude-plugins-official": true,
    "gitlab@claude-plugins-official": true,
    "rust-analyzer-lsp@claude-plugins-official": true,
    "chrome-devtools-mcp@claude-plugins-official": true
  }
}

```
