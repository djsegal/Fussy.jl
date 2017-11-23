# Fusion

[![Build Status](https://travis-ci.org/djsegal/Fusion.jl.svg?branch=master)](https://travis-ci.org/djsegal/Fusion.jl) [![codecov.io](http://codecov.io/github/djsegal/Fusion.jl/coverage.svg?branch=master)](http://codecov.io/github/djsegal/Fusion.jl?branch=master)

[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://djsegal.github.io/Fusion.jl/stable) [![](https://img.shields.io/badge/docs-latest-blue.svg)](https://djsegal.github.io/Fusion.jl/latest)

-----

To get working locally, type these lines into the terminal:

```
> julia
> Pkg.clone("https://github.com/djsegal/Julz.jl.git")
> Pkg.clone("https://github.com/djsegal/Fusion.jl.git")
> using Fusion
```

Then you can edit code in your Julia package directory.

// i.e. in `~/.julia/v0.6/Fusion` (possibly)

-----

A quick usage example would be:

```
> julia
> using Fusion
> Fusion.load_input("arc.jl", true)
> Fusion.load_input(" enable_eta_CD_derive = true ")
> Fusion.sweep_B_0(5:15)
```
