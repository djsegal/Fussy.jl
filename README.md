# Tokamak

[![Build Status](https://travis-ci.org/djsegal/Tokamak.jl.svg?branch=master)](https://travis-ci.org/djsegal/Tokamak.jl) [![codecov.io](http://codecov.io/github/djsegal/Tokamak.jl/coverage.svg?branch=master)](http://codecov.io/github/djsegal/Tokamak.jl?branch=master)

[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://djsegal.github.io/Tokamak.jl/stable) [![](https://img.shields.io/badge/docs-latest-blue.svg)](https://djsegal.github.io/Tokamak.jl/latest)

-----

To get working locally, type these lines into the terminal:

```
> julia
> Pkg.clone("https://github.com/djsegal/Julz.jl.git")
> Pkg.clone("https://github.com/djsegal/Tokamak.jl.git")
> using Tokamak
```

Then you can edit code in your Julia package directory.

// i.e. in `~/.julia/v0.6/Tokamak` (possibly)

-----

A quick usage example would be:

```
> julia
> using Tokamak
> Tokamak.load_input("arc.jl", true)
> Tokamak.load_input(" enable_eta_CD_derive = true ")
> Tokamak.sweep_B_0(5:15)
```
