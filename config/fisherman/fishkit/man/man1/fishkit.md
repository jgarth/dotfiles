fishkit(1) -- Create a plugin from a template
=============================================

## SYNOPSIS

`fishkit` [*TEMPLATE*]<br>
`fishkit` TEMPLATE < strings.yaml<br>

## DESCRIPTION

Create a plugin from a template.

## USAGE

```
fishkit plugin
```
```
> What's your plugin name? tron
> What's your plugin about? It's just pong
> What's your GitHub username? flynn
    .editorconfig
    .gitignore
    .travis.yml
    completions/tron.fish
    functions/tron.fish
    LICENSE
    README.md
```


## STRINGS

```
fishkit TEMPLATE < strings.yml
```

```yml
name: tron
description: It's just pong
author: Kevin Flynn
owner: flynn
```

## Templates

The available templates are:

* Plugin
* Prompt
* Snippet
