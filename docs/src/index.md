# VectorDataUtils Documentation

VectorDataUtils.jl provides a number of basic vector data processing routines in Julia. It is intended as a support library for other Julia toolboxes and not as a standalone toolbox. Many of the included routines make use of the excellent [LoopVectorization.jl](https://github.com/JuliaSIMD/LoopVectorization.jl) to improve their runtime performance.

## Note
Most of the routines implemented in VectorDataUtils.jl do not include any form of checks on the inputs. It is the users responsibility to ensure that array sizes and element types are appropriate.

## Outline
Currently VectorDataUtils.jl implements routines for:
- [Norms and Inner Products](norms.md)
- [Distances](distances.md)
- [Running Statistics](running_stats.md)
- [K-means Clustering](kmeans.md)
- [Utilities](utilities.md)