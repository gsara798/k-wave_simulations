function varargout = evaluateStage4Pair(varargin)
%evaluateStage4Pair Compatibility wrapper for kwsim.validation.evaluateStage4Pair.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.validation.evaluateStage4Pair directly.

if nargout == 0
    kwsim.validation.evaluateStage4Pair(varargin{:});
else
    [varargout{1:nargout}] = kwsim.validation.evaluateStage4Pair(varargin{:});
end

end
