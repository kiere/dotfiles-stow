# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) for user-level preferences.

## Planning

Use the `planning-with-files` skill instead of native plan mode for multi-step tasks and complex projects. This creates persistent markdown files that are visible across multiple Claude Code sessions, enabling coordination when running parallel instances.

## 1:3:1 Method

Use the 1:3:1 method for architectural decisions where multiple valid approaches exist.

**Structure**: Problem (1) → Three Solutions (3) → Recommended Solution (1)

Use 3 parallel agents to explore the 3 possible solutions, then synthesize and recommend the best fit.

### When to Use 1:3:1
- Architectural decisions with trade-offs (e.g., "How should we structure the API client?")
- Technology choices (e.g., "Which caching strategy should we use?")
- Design patterns where multiple valid approaches exist

### When NOT to Use 1:3:1
- Comprehensive requirement coverage or validation
- Simple implementation tasks with obvious solutions
- Problems too broad to compare approaches (e.g., "How should we implement Feature X?")

### Scope the Problem Correctly
- GOOD: "How should we structure the HTTP client?" (bounded, architectural)
- GOOD: "What pattern should we use for background job retries?" (specific decision)
- BAD: "How should we implement the full integration?" (too broad)
- BAD: "What should the code look like?" (not a decision point)

### Process for Complex Features
1. **Extract requirements first** - List every requirement from the spec explicitly
2. **Identify decision points** - Find specific architectural choices that need 1:3:1
3. **Run 1:3:1 per decision** - Give agents full context for each bounded problem
4. **Validate against requirements** - Gap analysis checking plan against original spec
5. **Iterate** - Address gaps before finalizing the plan

### Verification is Critical
Always validate the combined plan against the original requirements. 1:3:1 solves architectural decisions but does not guarantee requirement coverage. A separate validation step ensures nothing is missed.

## Containers

I use **Podman** instead of Docker. When providing examples or running commands, use `podman` and `podman-compose`.

However, all artifacts must remain **Docker-compatible**:
- Use `docker-compose.yml` (not `podman-compose.yml`)
- Use standard Dockerfile syntax
- Avoid Podman-specific features in committed files

This allows teammates using Docker to work seamlessly without knowing I use Podman.
