function varargout = plotStage4Pair(varargin)
%plotStage4Pair Compatibility wrapper for kwsim.viz.plotStage4Pair.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.viz.plotStage4Pair directly.

if nargout == 0
    kwsim.viz.plotStage4Pair(varargin{:});
else
    [varargout{1:nargout}] = kwsim.viz.plotStage4Pair(varargin{:});
end

end
