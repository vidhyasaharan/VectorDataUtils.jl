# VectorDataUtils Documentation

VectorDataUtils.jl provides a number of basic vector operation and data processing routines in Julia. It is intended as a support library for other Julia toolboxes and not as a standalone toolbox. Many of the included routines make use of the excellent [LoopVectorization.jl](https://github.com/JuliaSIMD/LoopVectorization.jl) to speed up the operations.

## Note
Most of the routines implemented in VectorDataUtils.jl do not include any form of checks on the inputs. It is the users responsibility to ensure that array sizes and element types are appropriate.

