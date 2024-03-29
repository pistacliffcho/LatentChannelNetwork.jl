# Compute probability of edge between nodes i and j
function probEdge(i::Int64, j::Int64, lcn::LatentChannelNetwork)::Float64
    prob_no_edge = 1.0
    nDims = lcn.dim
    probs = lcn.pmat
    for ii in 1:nDims
        prob_no_edge = prob_no_edge * (1.0 - probs[i, ii] * probs[j,ii])
    end
    ans = 1.0 - prob_no_edge
    return(ans)
end



# For one step of EM algorithm, need to compute
# probability two nodes have edge, but exclude case in
# a certain hub connection is responsible for edge
function removeEdgeProbContribution(pik::Float64, pjk::Float64,
                                    edgeProb::Float64)::Float64
    probNoEdge = 1.0 - edgeProb
    probNoEdge_removePairCont = probNoEdge / (1.0 - pik * pjk)
    ans = 1.0 - probNoEdge_removePairCont
    return(ans)
end

# We also need to add in the contribution of a latent channel
function addEdgeProbContribution(pik::Float64, pjk::Float64,
    edgeProb::Float64)::Float64
    probNoEdge = 1.0 - edgeProb
    newProbNoEdge = probNoEdge * (1.0 - pik * pjk)
    ans = 1. - newProbNoEdge
    return(ans)
end

# Updating an edge probability after pik as been updated
function updateEdgeProb(pik_new::Float64, pik_old::Float64,
    pjk::Float64, edgeProb::Float64)::Float64
    oldProbNoEdge = 1.0 - edgeProb
    newProbNoEdge = oldProbNoEdge * (1. - pik_new * pjk)/ (1. - pik_old * pjk)
    ans = 1.0 - newProbNoEdge
    return(ans)
end

# Computes the expected value of latent edge conditional on observed edge
function edgeSumContribution(pik::Float64, pjk::Float64,
                             pi_ij::Float64)::Float64
    p_no_ijk = 1.0 - pik * pjk
    inner_term = 1.0 - (1. - pi_ij) / p_no_ijk
    ans = pik * (pjk + (1.0 - pjk) * inner_term ) / pi_ij
    return(ans)
end


# Gets probability of connection through k, given that nodes i,j have an edge
# Note: this is basically equivalent to edgeSumContribution
function expHubConnect_hasEdge(p_ik::Float64, p_jk::Float64, edgeProb::Float64)::Float64
    edgeProb_contRemoved =
            removeEdgeProbContribution(p_ik, p_jk, edgeProb)
    top = p_ik * (p_jk + (1.0 - p_jk) * edgeProb_contRemoved)
    ans = top / edgeProb
    return(ans)
end
