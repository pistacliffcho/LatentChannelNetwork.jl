module LatentChannelNetworks

include("edgeListUtils.jl")
include("baseModel.jl")
include("probFunctions.jl")
include("cacheEM.jl")
include("UserUtils.jl")

export simSBM, augSBM
export makeLatChan, probEdge, hubSizes, computeTheta
export em_cached!, computeLLK
export heatMap
export dropLoops, LatentChannelNetwork
export multi_em!

end # module
