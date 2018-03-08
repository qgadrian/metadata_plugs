[![Coverage Status](https://coveralls.io/repos/github/heyorbit/metadata_plugs/badge.svg?branch=master)](https://coveralls.io/github/heyorbit/metadata_plugs?branch=master)
[![Hex version](https://img.shields.io/hexpm/v/sippet.svg "Hex version")](https://hex.pm/packages/metadata_plugs)
[![Hex Docs](https://img.shields.io/badge/hex-docs-9768d1.svg)](https://hexdocs.pm/metadata_plugs)
[![Build Status](https://travis-ci.org/heyorbit/metadata_plugs.svg?branch=master)](https://travis-ci.org/heyorbit/metadata_plugs)
[![Deps Status](https://beta.hexfaktor.org/badge/all/github/heyorbit/metadata_plugs.svg)](https://beta.hexfaktor.org/github/heyorbit/metadata_plugs)

# MetadataPlugs

Collection of plugs to provide different metadata information.

Plugs included:

* Health
* App version

## Installation

Add to dependencies

```elixir
def deps do
  [{:metadata_plugs, "~> 0.1.0"}]
end
```

Install dependencies

```bash
mix deps.get
```

## Usage

Add the desired plugs to the endpoint file

```elixir
plug(MetadataPlugs.Health)
plug(MetadataPlugs.Info)
```

You can configure the path for the endpoints, for example

```elixir
plug(MetadataPlugs.Health, health_path: "/healthz")
```

Check [documentation](https://hexdocs.pm/metadata_plugs) for more options
