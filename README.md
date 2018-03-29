[![Coverage Status](https://coveralls.io/repos/github/qgadrian/metadata_plugs/badge.svg?branch=master)](https://coveralls.io/github/qgadrian/metadata_plugs?branch=master)
[![Hex version](https://img.shields.io/hexpm/v/sippet.svg "Hex version")](https://hex.pm/packages/metadata_plugs)
[![Hex Docs](https://img.shields.io/badge/hex-docs-9768d1.svg)](https://hexdocs.pm/metadata_plugs)
[![Build Status](https://travis-ci.org/qgadrian/metadata_plugs.svg?branch=master)](https://travis-ci.org/qgadrian/metadata_plugs)
[![Deps Status](https://beta.hexfaktor.org/badge/all/github/qgadrian/metadata_plugs.svg)](https://beta.hexfaktor.org/github/qgadrian/metadata_plugs)

# MetadataPlugs

Collection of plugs to provide different metadata information.

[Plugs included](#plugs):

* [Health](#health)
* [Info](#info)

## Installation

Add to dependencies

```elixir
def deps do
  [{:metadata_plugs, "~> 0.2.3"}]
end
```

Install dependencies

```bash
mix deps.get
```

## Plugs

### Health

Just add the plug to the endpoint file

```elixir
plug(MetadataPlugs.Health)
```

You can configure the path for the endpoint

```elixir
plug(MetadataPlugs.Health, path: "/healthz")
```

### Info

Add the plug to the endpoint file with the desired environment variables to get the info from.

```elixir
plug(MetadataPlugs.Info, env_vars: ["APP_VERSION", "ENVIRONMENT"])
```

You can configure the path for the endpoint

```elixir
plug(MetadataPlugs.Info, path: "/infoz")
```
