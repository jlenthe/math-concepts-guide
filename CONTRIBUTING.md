# Contributing to the Guide

Thank you for your interest in contributing to _The Guide to Basic
Mathematical Concepts_! We welcome your ideas, suggestions, and
improvements.

## Getting Started

### Prerequisites

To build using docker images, you will need:

- Docker or Podman
- Bash

### Building in a Container

We recommend building with docker or podman on a UNIX-like system since 
this easily allows for a consistent and reproducible build environment 
as well as easy access to the latest version of LaTeX and its supporting
tools and packages.

To build the PDF file in a docker container:

```bash
$ ./build.sh pdf
```

The web version can be built (in a docker container) with:

```bash
$ ./build.sh web
```

Or to build the PDF and web versions at once (in a docker container):

```bash
$ ./build.sh all
```

### Building Locally

It is possible to build locally without docker. You will need to install the TeX Live Full distribution.

On Debian-based systems:

```bash
$ sudo apt install texlive-full
```

On dnf-based systems:

```bash
$ sudo dnf install texlive-scheme-full
```

Then to build the PDF file, run:

```bash
$ ./scripts/build-pdf.sh
```

And to build the web version, run:

```bash
$ ./scripts/build-web.sh
```

### Spell Checking

The is a wrapper script in the scripts directory called spell-check.sh. Run this
to check spelling. The script configures bew words to be added to word-list.txt file.

```bash
$ ./scripts/spell-check.sh
```

## Submitting Pull Requests

**TODO** - Document how to prepare pull requests.

## Organizational Style

The intent of this guide is to be different from and complementary to ordinary
math textbooks.

| Normal Math Textbook                                                          | This Guide                                                    |
| ----------------------------------------------------------------------------- | ------------------------------------------------------------- |
| Goal is to cover a topic thoroughly                                           | Goal is to cover topics lightly                               |
| Includes definitions, explanations, examples, proofs, exercises, and problems | Includes definitions, brief explanations, and simple examples |
| May include advanced topics                                                   | Includes only basic and foundational topics                   |

Provide a fundamental definition of a concept or term.
Provide minimal explanation and examples.

## Code of Conduct

We are committed to fostering a welcoming, inclusive, and harassment-free
environment.

All contributors must adhere to the [Contributor Covenant Code of Conduct]
(https://www.contributor-covenant.org/version/2/1/code_of_conduct/), which
prohibits racist, sexist, homophobic, or otherwise discriminatory behavior.

Please help us maintain a respectful and collaborative space.

## Licensing

This work is licensed under CC BY-NC-SA 4.0. To view a copy of this license,
visit https://creativecommons.org/licenses/by-nc-sa/4.0/

By submitting a contribution, you agree that your contribution may be modified
and redistributed under the terms of the CC BY-NC-SA 4.0 license.

```

```
